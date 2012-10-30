-- TODO: make EPIC save changed options somehow!
-- TODO: add missing command icons
-- TODO: commandschanged gets called 2x for some reason, investigate
-- TODO: display which unit is currently selected
-- TODO: proper tooltips for queue buttons
-- TODO: make tab scrolling with keyboard detect actions prevmenu and nextmenu instead of KeyPress

function widget:GetInfo()
  return {
    name      = "Chili Integral Menu",
    desc      = "v0.33 Integral Command Menu",
    author    = "Licho, KingRaptor, Google Frog",
    date      = "12.10.2010",
    license   = "GNU GPL, v2 or later",
    layer     = math.huge,
    enabled   = true,
	handler   = true,
  }
end

include("keysym.h.lua")
--[[
for i,v in pairs(KEYSYMS) do
	Spring.Echo(i.."\t"..v)
end
--]]
--[[
HOW IT WORKS:
	Main window (invisible) is parent of a fake window.
		Tabs are buttons in main window, just above fake window.
		Currently selected tab is highlighted, when tab is changed all tabs are removed and regenerated.
		
		Two parent StackPanels (children of fake window), a column for normal commands and a row for state commands.
		<numRows> (or <numStateColumns>) more StackPanels are nested in each of the parents, at right angles.
		When sorting commands, it splits commands into batches of <MAX_COLUMNS> and assigns them to children
			so if there are 10 commands, it puts 6 in first row and 4 in second row
			Build orders work a little differently, they have a predefined row in the config.
		Ditto for states, except it uses MAX_STATE_ROWS
		
		If unit tab is selected and third command row is free, build queue of first selected factory found in array returned by SelectionChanged is displayed.
		The queue shows up to <MAX_COLUMNS> batches of units and their exact sequence.
		
	All items resize with main window.
	
NOTE FOR OTHER GAME DEVS:
	ZK uses WG.GetBuildIconFrame to draw the unit type border around buildpics.
	If you're not using them (likely), remove all lines containing that function.
--]]

------------------------
--  CONFIG
------------------------
------------------------
options_path = 'Settings/Interface/Integral Menu'
options_order = { 'disablesmartselect', 'hidetabs', }
options = {
	disablesmartselect = {
		name = 'Disable Smart Tab Select',
		type = 'bool',
	},
	hidetabs = {
		name = 'Hide Tab Row',
		type = 'bool',
		advanced = true,
	},
}


------------------------
--speedups
local spGetUnitDefID = Spring.GetUnitDefID
local spGetUnitHealth     = Spring.GetUnitHealth
local spGetFullBuildQueue = Spring.GetFullBuildQueue
local spGetUnitIsBuilding = Spring.GetUnitIsBuilding

local push        = table.insert

local CMD_PAGES = 60
local CMD_MORPH = 31210

local common_commands, states_commands, factory_commands, econ_commands, defense_commands, special_commands, globalCommands, overrides = include("Configs/integral_menu_commands.lua")



for cmd, _ in pairs(overrides) do 
	
	local cmdname = CMD[cmd]
	if cmdname then
		options[cmdname] = {
			name = cmdname,
			type = 'button',
			action = cmdname:lower(),
			path = 'Game/Hotkeys/Commands',
		}
	end
	options_order[#options_order+1] = cmdname
end 




local MAX_COLUMNS = 6
local MAX_STATE_ROWS = 5
local MIN_HEIGHT = 80
local MIN_WIDTH = 200
local COMMAND_SECTION_WIDTH = 74	--percent
local STATE_SECTION_WIDTH = 24	--percent

local numRows = 3
local numStateColumns = 3

local selectedFac	--unitID

-- Chili classes
local Chili
local Button
local Label
local Colorbars
local Checkbox
local Window
local ScrollPanel
local StackPanel
local LayoutPanel
local Grid
local Trackbar
local TextBox
local Image
local Progressbar
local Control

-- Chili instances
local screen0
local window		--main window (invisible)
local fakewindow	--visible Panel
local menuTabRow	--parent row of tabs
local menuTabs = {}		--buttons
local commands_main	--parent column of command buttons
local sp_commands = {}	--buttons
local states_main	--parent row of state buttons
local sp_states = {}	--buttons
local buildRow	--row of build queue buttons
local buildRowButtons = {}	--contains arrays indexed by number 1 to MAX_COLUMNS, each of which contains three subobjects: button, label and image
local buildProgress = {}	--Progressbar, child of buildRowButtons[1].image; updates every gameframe

local buildRow_visible = false
local buildQueue = {}	--build order table of selectedFac
local buildQueueUnsorted = {}	--puts all units of same type into single index; thus no sequence

-- arrays with commands to be displayed 
local n_common = {}
local n_factories = {}
local n_econ = {}
local n_defense = {}
local n_special = {}
local n_units = {}
local n_states = {}

--shortcuts
local menuChoices = {
	[1] = { array = n_common, name = "Order" },
	[2] = { array = n_factories, name = "Factory", config = factory_commands },
	[3] = { array = n_econ, name = "Econ", config = econ_commands },
	[4] = { array = n_defense, name = "Defense", config = defense_commands },
	[5] = { array = n_special, name = "Special", config = special_commands },
	[6] = { array = n_units, name = "Units" },
}

local menuChoice = 1
local lastBuildChoice = 2

-- command id indexed field of items - each item is button, label and image 
local commandButtons = {} 
----------------------------------- COMMAND COLORS  - from cmdcolors.txt - default coloring
local cmdColors = {}

-- default config
local config = {
}


------------------------
--  FUNCTIONS
------------------------
-- this gets invoked when button is clicked 
local function ClickFunc(button) 
	local _,_,left,_,right = Spring.GetMouseState()
	local alt,ctrl,meta,shift = Spring.GetModKeyState()
	local index = Spring.GetCmdDescIndex(button.cmdid)
	if (left) then
		Spring.SetActiveCommand(index,1,left,right,alt,ctrl,meta,shift)
	end
	if (right) then
		Spring.SetActiveCommand(index,3,left,right,alt,ctrl,meta,shift)
	end
end 

------------------------
--  Generates or updates chili button - either image or text or both based - container is parent of button, cmd is command desc structure
------------------------
local function MakeButton(container, cmd, insertItem) 
	local isState = (cmd.type == CMDTYPE.ICON_MODE and #cmd.params > 1) or states_commands[cmd.id]	--is command a state toggle command?
	local isBuild = (cmd.id < 0)
	local text
	local texture
	local countText = ''
	local tooltip = cmd.tooltip

	local te = overrides[cmd.id]  -- command overrides 
	
	-- text 
	if te and te.text then 
		text = te.text 
	elseif isState then 
		text = cmd.params[cmd.params[1]+2]
	elseif isBuild then
		text = ''
	else 
		text = cmd.name 
	end
	
	--count label (for factory build options)
	if menuChoice == 6 and isBuild and buildQueueUnsorted[-cmd.id] then
		countText = tostring(buildQueueUnsorted[-cmd.id])
	end
	
	--texture 
	if te ~= nil and te.texture then 
		if (isState) then 
			texture = te.texture[cmd.params[1]+1]
		else 
			texture = te.texture
		end 
	elseif isBuild then
		texture = '#'..-cmd.id
	else
		texture = cmd.texture 
	end 
	
	-- tooltip 
	if te and te.tooltip then 
		tooltip = te.tooltip
	else 
		tooltip = cmd.tooltip
	end
	
	-- get cached menu item 
	local item = commandButtons[cmd.id]
	if not item then  -- no item, create one 
		if not insertItem then 
			Spring.SendMessage("CommandBar - internal error, unexpectedly adding item!")
		end 
		-- decide color 
--[[		local color = {1,1,1,1}
		if te ~= nil and te.color ~= nil then 
			color = te.color 
		elseif cmd.name ~= nil then 
			local nl = cmd.name:lower()
			if cmdColors[nl] then 
				color = cmdColors[nl]
				color[4] = color[4] + 0.2
			end 
		end]]
		
		local button = Button:New {
			parent=container;
			padding = {5, 5, 5, 5},
			margin = {0, 0, 0, 0},
			caption="";
			isDisabled = cmd.disabled;
			tooltip = tooltip;
			cmdid = cmd.id;
			OnMouseDown = {ClickFunc}
		}
		if cmd.OnClick then 
			button.OnMouseDown = cmd.OnClick
		end 
		if (isState) then 
			button.padding = {0,0,0,0}
			button.backgroundColor = {0,0,0,0}
		end 
		if (isBuild) then
			button.padding = {1,1,1,1}
		end
		
		local label 
		if (not cmd.onlyTexture and text and text ~= '') then 
			label = Label:New {
				width="100%";
				height="100%";
				autosize=false;
				align="left";
				valign="top";
				caption = text;
				fontSize = 11;
				fontShadow = true;
				parent = button;
			}
		end
		
		local image
		if (texture and texture ~= "") then
			image= Image:New {
				width="90%";
				height= (not isBuild) and nil or "90%";
				bottom = (isBuild) and 10 or nil;
				y="5%";
				x="5%";
--				color = color;
				keepAspect = not isBuild,	--true,	--isState;
				file = texture;
				parent = button;
			}
			if isBuild then 
				image.file2 = WG.GetBuildIconFrame(UnitDefs[-cmd.id]) 
			end 
			
			if isState then 
				height = "100%"
				y = 0
			end
		else 
			if label~=nil then label.valign="center" end
		end 
		
		local countLabel
		if isBuild then
			countLabel = Label:New {
				parent = image,
				autosize=false;
				width="100%";
				height="100%";
				align="right";
				valign="bottom";
				caption = countText;
				fontSize = 16;
				fontShadow = true;
			}
			local costLabel = Label:New {
				parent = button,
				right = 0;
				y = 0;
				x = 3;
				bottom = 3;
				autosize=false;
				align="left";
				valign="bottom";
				caption = string.format("%d m", UnitDefs[-cmd.id].metalCost);
				fontSize = 11;
				fontShadow = true;
			}
		end
		

		
		--if button is disabled, set effect accordingly
		if button.isDisabled then 
			button.backgroundColor = {0,0,0,1};
			image.color = {0.3, 0.3, 0.3, 1}
		end
		
		item = {
			button = button,
			image = image,
			label = label,
			countLabel = countLabel,
		}
		commandButtons[cmd.id] = item
	else 
		if insertItem then 
			container:AddChild(item.button)
		end 
	end 
	
	-- update item if something changed
	if (cmd.disabled ~= item.button.isDisabled) then 
		if cmd.disabled then 
			item.button.backgroundColor = {0,0,0,1};
			item.image.color = {0.3, 0.3, 0.3, 1}
		else 
			item.button.backgroundColor = {1,1,1,0.7};
			item.image.color = {1, 1, 1, 1}
		end 
		item.button:Invalidate()
		item.image:Invalidate()
		item.button.isDisabled = cmd.disabled
	end 
	
	if (not cmd.onlyTexture and item.label and text ~= item.label.caption) then 
		item.label:SetCaption(text)
	end
	
	if (item.countLabel and countText ~= item.countLabel.caption) then
		item.countLabel:SetCaption(countText)
	end
	
	if (item.image and texture ~= item.image.file) then 
		item.image.file = texture
		item.image:Invalidate()
	end 
end

--sorts commands into categories
local function ProcessCommand(cmd) 
	if not cmd.hidden and cmd.id ~= CMD_PAGES then 
		-- state icons 
		if (cmd.type == CMDTYPE.ICON_MODE and cmd.params ~= nil and #cmd.params > 1) then 
			n_states[#n_states+1] = cmd 
		elseif common_commands[cmd.id] then 
			n_common[#n_common+1] = cmd
		elseif factory_commands[cmd.id] then
			n_factories[#n_factories+1] = cmd
		elseif econ_commands[cmd.id] then
			n_econ[#n_econ+1] = cmd
		elseif defense_commands[cmd.id] then
			n_defense[#n_defense+1] = cmd
		elseif special_commands[cmd.id] then
			n_special[#n_special+1] = cmd
		elseif UnitDefs[-(cmd.id)] then
			n_units[#n_units+1] = cmd
		else
			n_common[#n_common+1] = cmd	--shove unclassified stuff in common
		end
	end
end 

local function RemoveChildren(container) 
	for i = 1, #container.children do 
		container:RemoveChild(container.children[1])
	end
end 

-- compared real chili container with new commands and update accordingly
local function UpdateContainer(container, nl, columns) 
	if not columns then columns = MAX_COLUMNS end 
	local cnt = 0 
	local needUpdate = false 
	local dif = {}
	for i =1, #container.children do  
		if container.children[i].isEmpty then 
			break 
		end 
		cnt = cnt + 1 
		dif[container.children[i].cmdid] = true 
	end 
	
	if cnt ~= #nl then  -- different counts, we update fully
		needUpdate = true 
	else  -- check if some items are different 
		for _, cmd in ipairs(nl) do  
			dif[cmd.id] = nil
		end 
	
		for _, _ in pairs(dif) do  -- different item found, we do full update 
			needUpdate = true 
			break
		end 
	end 
	
	if needUpdate then 
		RemoveChildren(container) 
		for _, cmd in ipairs(nl) do 
			MakeButton(container, cmd, true)
		end 
		for i = 1, columns - #container.children do 
			Control:New {
				isEmpty = true,
				parent = container
			}
		end 
	else 
		for _, cmd in ipairs(nl) do  -- update buttons only 
			MakeButton(container, cmd, false)
		end 
	end 
end 

-- if you ever want to know why the command removal works use this on Spring.GetFactoryCommands(selectedFac)
--[[
local function EchoTable(ta, front)
	for i, v in pairs(ta) do
		if (type(v) == "table") then
			Spring.Echo(i)
			EchoTable(v,front .. "  ")
		elseif v == nil then
			if i == nil then
				Spring.Echo(front .. "nil  nil")
			else
				Spring.Echo(front .. i .. "   nil")
			end
		else
			if i == nil then
				Spring.Echo(front .. "nil   " .. v)
			else
				Spring.Echo(front .. i .. "  " .. v)
			end
		end
	end
end
--]]

local function BuildRowButtonFunc(num, cmdid, left, right)
	buildQueue = spGetFullBuildQueue(selectedFac)
	local alt,ctrl,meta,shift = Spring.GetModKeyState()
	local order = CMD.INSERT
	local pos = 1
	local numInput = 1	--number of times to send the order
	
	local function BooleanMult(int, bool)
		if bool then return int
		else return 0 end
	end
	
	--Spring.Echo(CMD.OPT_META) = 4
	--Spring.Echo(CMD.OPT_RIGHT) = 16
	--Spring.Echo(CMD.OPT_SHIFT) = 32
	--Spring.Echo(CMD.OPT_CTRL) = 64
	--Spring.Echo(CMD.OPT_ALT) = 128
	
	--it's not using the options, even though it's receiving them correctly
	--so we have to do it manually
	if shift then numInput = numInput * 5 end
	if ctrl then numInput = numInput * 20 end
	
	--local options = BooleanMult(CMD.OPT_SHIFT, shift) + BooleanMult(CMD.OPT_ALT, alt) + BooleanMult(CMD.OPT_CTRL, ctrl) + BooleanMult(CMD.OPT_META, meta) + BooleanMult(CMD.OPT_RIGHT, right)
	
	--insertion position is by unit rather than batch, so we need to add up all the units in front of us to get the queue
	
	for i=1,num-1 do
		for _,units in pairs(buildQueue[i]) do
			pos = pos + units
		end
	end
	
	-- skip over the commands with an id of 0, left behind by removal
	local commands = Spring.GetFactoryCommands(selectedFac)
	local i = 1
	while i <= pos do
		if commands[i].id == 0 then
			pos = pos + 1
		end
		i = i + 1
	end
	
	--Spring.Echo(cmdid)
	if not right then
		for i = 1, numInput do
			Spring.GiveOrderToUnit(selectedFac, order, {pos, cmdid, 0 }, {"alt", "ctrl"})
		end
	else
		-- delete from back so that the order is not canceled while under construction
		local i = 0
		while commands[i+pos] and commands[i+pos].id == cmdid do
			i = i + 1
		end
		i = i - 1
		j = 0
		while commands[i+pos] and commands[i+pos].id == cmdid and j < numInput do
			Spring.GiveOrderToUnit(selectedFac, CMD.REMOVE, {commands[i+pos].tag}, {"ctrl"})
			j = j + 1
			i = i - 1
		end 
	end
end

local function UpdateFactoryBuildQueue() 
	buildQueue = spGetFullBuildQueue(selectedFac)
	buildQueueUnsorted = {}
	for i=1, #buildQueue do
		for udid, count in pairs(buildQueue[i]) do
			buildQueueUnsorted[udid] = (buildQueueUnsorted[udid] or 0) + count
			--Spring.Echo(udid .. "\t" .. buildQueueUnsorted[udid])
		end
	end
end

--uses its own function for more fine control
local function ManageBuildRow()
	--if (menuChoice ~= 6) or (not buildRow_visible) or (not selectedFac) then return end
	local overrun = false
	RemoveChildren(buildRow)
	if buildQueue[MAX_COLUMNS + 1] then 
		overrun = true 
	end

	for i=1, MAX_COLUMNS do
		local buttonArray = buildRowButtons[i]
		if buttonArray.button then RemoveChildren(buttonArray.button) end
		if buildQueue[i] then	--adds button for queued unit
			local udid, count, caption
			for id, num in pairs(buildQueue[i]) do
				udid = id
				count = num
				break
			end
			buildRowButtons[i].cmdid = -udid
			if overrun and i == MAX_COLUMNS then
				caption = tostring(#buildQueue - MAX_COLUMNS + 1)
			elseif count > 1 then caption = tostring(count)
			else caption = '' end
			buttonArray.button = Button:New{
				parent = buildRow;
				x = tostring((i-1)*(100/MAX_COLUMNS)).."%",
				y = 0,
				width = tostring(100/MAX_COLUMNS).."%",
				height = "100%",
				--caption = '',
				OnMouseDown = {	function () 
					local _,_,left,_,right = Spring.GetMouseState()
					BuildRowButtonFunc(i, buildRowButtons[i].cmdid, left, right)
					end},
				padding = {1,1,1,1},
				--keepAspect = true,
			}
			if overrun and i == MAX_COLUMNS then
				buttonArray.button.caption = '...'
				buttonArray.button.OnMouseDown = nil
			end
			buttonArray.button.backgroundColor[4] = 0.3
			
			if not (overrun and i == MAX_COLUMNS) then
				buttonArray.button.tooltip = 'Add to/subtract from queued batch'
				buttonArray.image = Image:New {
					parent = buttonArray.button,
					width="90%";
					height="90%";
					x="5%";
					y="5%";
					file = '#'..udid,
					file2 = WG.GetBuildIconFrame(UnitDefs[udid]),
					keepAspect = false,
				}
				buttonArray.label = Label:New {
					parent = buttonArray.image,
					width="100%";
					height="100%";
					autosize=false;
					--x = "70%",
					--y = "70%",
					align="right";
					valign="bottom";
					caption = caption;
					fontSize = 16;
					fontShadow = true;
				}
			end
			
			if i == 1 then
				buttonArray.image:AddChild(buildProgress)
				--Spring.Echo("Adding build progress bar")
			end
		end
	end
end

--these two functions place the items into their rows
local function ManageStateIcons()
	local stateCols = { }
	for i=1, numStateColumns do
		stateCols[i] = {}
		for v=(MAX_STATE_ROWS * (i-1)) + 1, (MAX_STATE_ROWS*i) do
			stateCols[i][v - MAX_STATE_ROWS*(i-1)] = n_states[v]
		end
	end
	for i=1, numStateColumns do
		UpdateContainer(sp_states[i], stateCols[i], MAX_STATE_ROWS)
	end
end

local function ManageCommandIcons(useRowSort)
	local sourceArray = menuChoices[menuChoice].array
	local configArray = menuChoices[menuChoice].config
	--update factory data
	if menuChoice == 6 and selectedFac then
		UpdateFactoryBuildQueue()
	end
	local commandRows = { }
	--most commands don't use row sorting; econ, defense and special do
	if not useRowSort then
		for i=1, numRows do
			commandRows[i] = {}
			for v=(MAX_COLUMNS * (i-1)) + 1, (MAX_COLUMNS*i) do
				commandRows[i][v - MAX_COLUMNS*(i-1)] = sourceArray[v]
			end
		end
	else
		for i=1, numRows do
			commandRows[i] = {}
			for v=1,#sourceArray do
				if configArray[sourceArray[v].id].row == i then
					commandRows[i][#commandRows[i]+1] = sourceArray[v]
				end
			end
		end	
	end
	for i=1, numRows do
		UpdateContainer(sp_commands[i], commandRows[i], MAX_COLUMNS)
	end
	
	--manage factory queue if needed
	if menuChoice == 6 and selectedFac and #commandRows[numRows] == 0 then
		if not buildRow_visible then
			commands_main:AddChild(buildRow)
			buildRow_visible = true
		end
		ManageBuildRow()
	else
		commands_main:RemoveChild(buildRow)
		buildRow_visible = false
	end
end

local function Update(buttonpush) 
    local commands = widgetHandler.commands
    local customCommands = widgetHandler.customCommands
	--most commands don't use row sorting; econ, defense and special do
	local useRowSort = (menuChoice == 3 or menuChoice == 4 or menuChoice == 5)
	
	--if (#commands + #customCommands == 0) then 
		---screen0:RemoveChild(window);
		--window_visible = false;
	--	return
	--else 
		--if not window_visible then 
			--screen0:AddChild(window);
			--window_visible = true;
		--end 
	--end 
	
	n_common = {}
	n_factories = {}
	n_econ = {}
	n_defense = {}
	n_special = {}
	n_units = {}
	n_states = {}
	
	--Spring.Echo(#commands)
	for i = 1, #commands do ProcessCommand(commands[i]) end 
	for i = 1, #customCommands do ProcessCommand(customCommands[i]) end 
	for i = 1, #globalCommands do ProcessCommand(globalCommands[i]) end 

	menuChoices[1].array = n_common
	menuChoices[2].array = n_factories
	menuChoices[3].array = n_econ
	menuChoices[4].array = n_defense
	menuChoices[5].array = n_special
	menuChoices[6].array = n_units
	
	--[[
	local function Sort(a, b, array)
		return array[a.id] < array[b.id]
	end
	
	table.sort(n_factories, Sort(a,b, factory_commands))
	table.sort(n_econ, Sort(a,b, econ_commands))
	table.sort(n_defense, Sort(a,b, defense_commands))
	]]--
	
	--sorting isn't strictly needed, it uses the same order as listed in buildoptions
	table.sort(n_factories, function(a,b) return factory_commands[a.id].order < factory_commands[b.id].order end )
	table.sort(n_econ, function(a,b) return econ_commands[a.id].order < econ_commands[b.id].order end)
	table.sort(n_defense, function(a,b) return defense_commands[a.id].order < defense_commands[b.id].order end)
	table.sort(n_special, function(a,b) return special_commands[a.id].order < special_commands[b.id].order end)

	ManageStateIcons()
	ManageCommandIcons(useRowSort)
end 

local function MakeMenuTab(i, alpha)
	local button = Button:New{
		parent = menuTabRow;
		x = tostring((16.5*i)-16.5).."%",
		y = 0,
		width = "16%",
		height = "100%",
		font = {
			shadow = true
		},
		
		
		caption = menuChoices[i].name,
		OnClick = {
			function()
				menuChoice = i
				if i >= 2 and i <= 5 then lastBuildChoice = i end
				Update(true)
				ColorTabs(i)
			end
		},
	}
	button.backgroundColor[4] = alpha or 1
	return button
end

--need to recreate the tabs completely because chili is dumb
--also needs to be non-local so MakeMenuTab can call it
function ColorTabs(arg)
	arg = arg or menuChoice
	RemoveChildren(menuTabRow)
	for i=1,6 do
		if i ~= arg then menuTabs[i] = MakeMenuTab(i, 0.4) end
	end
	menuTabs[arg] = MakeMenuTab(arg, 1)
end

local function SmartTabSelect()
	Update()
	if options.hidetabs.value then
		menuChoice = 1
		ColorTabs(1)
	elseif options.disablesmartselect.value then 
		return
	elseif #n_units > 0 and #n_econ == 0 then
		menuChoice = 6	--selected factory, jump to units
		ColorTabs(6)
	elseif #n_econ > 0 and menuChoice == 6 then
		menuChoice = lastBuildChoice	--selected non-fac and in units menu, jump to last build menu
		ColorTabs(lastBuildChoice)
	elseif #n_factories + #n_econ + #n_defense + #n_units == 0 then
		menuChoice = 1	--selected non-builder, jump to common
		ColorTabs(1)
	end
end

local function CopyTable(outtable,intable)
  for i,v in pairs(intable) do 
    if (type(v)=='table') then
      if (type(outtable[i])~='table') then outtable[i] = {} end
      CopyTable(outtable[i],v)
    else
      outtable[i] = v
    end
  end
end

-- layout handler - its needed for custom commands to work and to delete normal spring menu
local function LayoutHandler(xIcons, yIcons, cmdCount, commands)
	widgetHandler.commands   = commands
	widgetHandler.commands.n = cmdCount
	widgetHandler:CommandsChanged()
	local reParamsCmds = {}
	local customCmds = {}
	
	local cnt = 0
	
	local AddCommand = function(command) 
		local cc = {}
		CopyTable(cc,command )
		cnt = cnt + 1
		cc.cmdDescID = cmdCount+cnt
		if (cc.params) then
			if (not cc.actions) then --// workaround for params
				local params = cc.params
				for i=1,#params+1 do
					params[i-1] = params[i]
				end
				cc.actions = params
			end
			reParamsCmds[cc.cmdDescID] = cc.params
		end
		--// remove api keys (custom keys are prohibited in the engine handler)
		cc.pos       = nil
		cc.cmdDescID = nil
		cc.params    = nil
		
		customCmds[#customCmds+1] = cc
	end 
	
	
	--// preprocess the Custom Commands
	for i=1,#widgetHandler.customCommands do
		AddCommand(widgetHandler.customCommands[i])
	end
	
	for i=1,#globalCommands do
		AddCommand(globalCommands[i])
	end

	Update()
	return "", xIcons, yIcons, {}, customCmds, {}, {}, {}, {}, reParamsCmds, {[1337]=9001}
end 

-- INITS 
function widget:Initialize()
	widgetHandler:ConfigLayoutHandler(LayoutHandler)
	Spring.ForceLayoutUpdate()


	--[[local f,it,isFile = nil,nil,false
	f  = io.open('cmdcolors.txt','r')
	if f then
		it = f:lines()
		isFile = true
	else
		f  = VFS.LoadFile('cmdcolors.txt')
		it = string.gmatch(f, "%a+.-\n")
	end
 
	local wp = '%s*([^%s]+)'           -- word pattern
	local cp = '^'..wp..wp..wp..wp..wp -- color pattern
	local sp = '^'..wp..wp             -- single value pattern like queuedLineWidth
 
	for line in it do
		local _, _, n, r, g, b, a = string.find(line, cp)
 
		r = tonumber(r or 1.0)
		g = tonumber(g or 1.0)
		b = tonumber(b or 1.0)
		a = tonumber(a or 1.0)
 
		if n then
			cmdColors[n]= { r, g,b,a}
		else
			_, _, n, r= string.find(line:lower(), sp)
			if n then
				cmdColors[n]= r
			end
		end
	end]]--
	
	-- setup Chili
	Chili = WG.Chili
	Button = Chili.Button
	Label = Chili.Label
	Colorbars = Chili.Colorbars
	Checkbox = Chili.Checkbox
	Window = Chili.Window
	Panel = Chili.Panel
	ScrollPanel = Chili.ScrollPanel
	StackPanel = Chili.StackPanel
	LayoutPanel = Chili.LayoutPanel
	Grid = Chili.Grid
	Trackbar = Chili.Trackbar
	TextBox = Chili.TextBox
	Image = Chili.Image
	Progressbar = Chili.Progressbar
	Control = Chili.Control
	screen0 = Chili.Screen0
	
	--create main Chili elements
	local screenWidth,screenHeight = Spring.GetWindowGeometry()
	local height = tostring(math.floor(screenWidth/screenHeight*0.35*0.35*100)) .. "%"
	local y = tostring(math.floor((1-screenWidth/screenHeight*0.35*0.35)*100)) .. "%"
	
	Spring.Echo(height)
	Spring.Echo(y)
	
	window = Window:New{
		parent = screen0,
		name   = 'integralwindow';
		color = {0, 0, 0, 0},
		width = 420;
		height = 200; -- keep an aspect ratio regardless of screen ratio
		x = 0; 
		bottom = 0;
		dockable = true;
		draggable = false,
		resizable = false,
		tweakDraggable = true,
		tweakResizable = true,
		minimumSize = {MIN_WIDTH, MIN_HEIGHT},
		padding = {0, 0, 0, 0},
		--itemMargin  = {0, 0, 0, 0},
	}
	
	fakewindow = Panel:New{
		parent = window,
		x = 0,
		y = '15%',
		width = "100%";
		height = "86%";
		--disableChildrenHitTest = false,
		--itemMargin  = {0, 0, 0, 0},
		dockable = false;
		draggable = false,
		resizable = false,
		padding = {0, 0, 0, 0},
		--color = {0.3, 0.3, 0.3, 1},	--broke?
		skinName  = "DarkGlass",
	}

	menuTabRow = StackPanel:New{
		parent = window,
		resizeItems = true;
		orientation   = "horizontal";
		height = "15%";
		width = "100%";
		x = '1%';
		y = 0;
		padding = {0, 0, 0, 0},
		itemMargin  = {0, 0, 0, 0},
	}
	
	for i=1,6 do
		menuTabs[i] = MakeMenuTab(i, 1)
	end
	ColorTabs()
	
	commands_main = StackPanel:New{
		parent = fakewindow,
		resizeItems = true;
		orientation   = "vertical";
		height = "98%";
		width = tostring(COMMAND_SECTION_WIDTH).."%";
		x = "1.5%";
		y = "1.5%";
		padding = {0, 0, 0, 0},
		itemMargin  = {0, 0, 0, 0},
	}
	for i=1,numRows do
		sp_commands[i] = StackPanel:New{
			parent = commands_main,
			resizeItems = true;
			orientation   = "horizontal";
			height = tostring(math.floor(100/numRows)).."%";
			width = "100%";
			x = "0%";
			y = tostring(math.floor(100/numRows))*(i-1).."%";
			padding = {0, 0, 0, 0},
			itemMargin  = {0, 0, 0, 0},
		}
		--Spring.Echo("Command row "..i.." created")
	end
	
	states_main = StackPanel:New{
		parent = fakewindow,
		resizeItems = true;
		orientation   = "horizontal";
		height = "96%";
		width = tostring(STATE_SECTION_WIDTH).."%";
		--x = tostring(100-STATE_SECTION_WIDTH).."%";
		right = 4;
		y = "3%";
		padding = {0, 0, 0, 0},
		itemMargin  = {0, 0, 0, 0},
	}
	for i=1, numStateColumns do
		sp_states[i] = StackPanel:New {
			parent = states_main,
			resizeItems = true;
			orientation   = "vertical";
			height = "100%";
			width = tostring(math.floor(100/numStateColumns)).."%";
			x = tostring(100 - (math.floor(100/numStateColumns))*i).."%";
			y = "0%";
			padding = {0, 0, 0, 0},
			itemMargin  = {0, 0, 0, 0},
		}
	end
	
	buildRow = StackPanel:New{
		parent = commands_main,
		resizeItems = true;
		orientation   = "horizontal";
		height = tostring(math.floor(100/numRows)).."%";
		width = "100%";
		x = "0%";
		y = tostring(math.floor(100/numRows))*(numRows-1).."%";
		padding = {0, 0, 0, 0},
		itemMargin  = {0, 0, 0, 0},
		backgroundColor = {0.2, 0.2, 0.2, 0.6}
	}

	buildProgress = Progressbar:New{
		value = 0.0,
		name    = 'prog';
		max     = 1;
		color   		= {0.7, 0.7, 0.4, 0.6},
		backgroundColor = {1, 1, 1, 0.01},
		width = "92%",
		height = "92%",
		x = "4%",
		y = "4%",
		skin=nil,
		skinName='default',
	},
	
	commands_main:RemoveChild(buildRow);
	for i=1,MAX_COLUMNS do
		buildRowButtons[i] = {}
	end
end

local lastCmd = nil  -- last active command 
local lastColor = nil  -- original color of button with last active command

-- this is needed to highlight active command
function widget:DrawScreen()
	local _,cmdid,_,cmdname = Spring.GetActiveCommand()
	if cmdid ~= lastCmd then 
		if cmdid and commandButtons[cmdid]  then 
			local but = commandButtons[cmdid].button
			lastColor = but.backgroundColor
			but.backgroundColor = {0.8, 0, 0, 1};
			but:Invalidate()
		end 
		if lastCmd ~= nil and commandButtons[lastCmd] then 
			local but = commandButtons[lastCmd].button
			but.backgroundColor = lastColor
			but:Invalidate()
		end 
		lastCmd = cmdid
	end
end

function widget:GameFrame()
	--set progress bar
	if menuChoice == 6 and selectedFac and buildRowButtons[1] and buildRowButtons[1].image then
		local progress
		local unitBuildID      = spGetUnitIsBuilding(selectedFac)
		if unitBuildID then _, _, _, _, progress = spGetUnitHealth(unitBuildID) end
		--Spring.Echo(progress)
		buildProgress:SetValue(progress or 0)
	end
end

function widget:SelectionChanged(newSelection)
	--get new selected fac, if any
	local function IsFactory(udid)
		return (UnitDefs[udid].TEDClass == "PLANT") or UnitDefs[udid].isFactory
	end
	for i=1,#newSelection do
		local id = newSelection[i]
		if IsFactory((spGetUnitDefID(id))) then
			selectedFac = id
			SmartTabSelect()
			return
		end
	end
	selectedFac = nil
	SmartTabSelect()
end

local function ScrollTabs(key)
	return false
	--[[
	local delta
	if key == KEYSYMS.COMMA then delta = -1
	elseif key == KEYSYMS.PERIOD then delta = 1 end
	if not delta then return end
	
	menuChoice = menuChoice + delta
	if menuChoice <= 0 then menuChoice = #menuChoices
	elseif menuChoice > #menuChoices then menuChoice = 1 end
	if menuChoice >= 2 and menuChoice <= 5 then lastBuildChoice = menuChoice end
	Update(true)
	ColorTabs()
	return	--returning true "eats" the keypress so nothing else registers it
	--]]
end

--[[
local function AddAction(cmd, func, data, types)
	return widgetHandler.actionHandler:AddAction(widget, cmd, func, data, types)
end
local function RemoveAction(cmd, types)
	return widgetHandler.actionHandler:RemoveAction(widget, cmd, types)
end

AddAction(nextMenu, ScrollTabs, {KEYSYMS.PERIOD}, "t")
AddAction(prevMenu, ScrollTabs, {KEYSYMS.COMMA}, "t")
--]]

function widget:KeyPress(key)
	return ScrollTabs(key)
end

function widget:Shutdown()
  widgetHandler:ConfigLayoutHandler(nil)
  Spring.ForceLayoutUpdate()
end

options.hidetabs.OnChange = function(self) 
	fakewindow:SetPosRelative(_, self.value and 0 or '15%', _, self.value and '100%' or '86%')
	fakewindow:SetPosRelative(_, self.value and 0 or '15%', _, self.value and '100%' or '86%')
	
	if self.value then 
		window:RemoveChild(menuTabRow)
	else
		window:AddChild(menuTabRow)
	end
	menuChoice = 1
	ColorTabs(1)
end