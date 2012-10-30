
#!/bin/bash
#find . -name "*.lua" | perl -pi.bak -e "s/$1/$2/"
for file in `find . -name "*.lua"`
do
	sed -i "s/$1/$2/g" $file
done

for file in `find . -name "*.s3o"`
do
        sed -i "s/$1/$2/g" $file
done


for infile in `find . \( ! -regex '.*/\..*' \)`
do 
	newname=`echo $infile | sed "s/$1/$2/"`
	if [ "$infile" != "$newname" ]
	then 
		svn mv $infile $newname
	fi
done
