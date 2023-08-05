#!/usr/bin/zsh

for file in /tmp/lists/*.txt ; do
if [ -f "$file" ]
then
	URL=$(cat $file)
	rm -f $file
	echo $file: $URL
	./dl.sh $URL $(cat /tmp/echos.txt)
fi
done

#if [ -d "$file" ] then
#fi
