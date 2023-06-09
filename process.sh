#!/bin/zsh
setopt NULL_GLOB
#for file in gallery-dl/(*booru|*rule34*|e621)/*(|/*).(jpg|png|mp4|gif|wmv|webm|avi) ; do
#	echo "$file">>test
#	cat "$file.json" | jq ".source" >>test
#	cat "$file.json" | jq ".sources">>test
#	cat "$file.json" | jq ".sourcelist">>test
#	cat "$file.json" | jq ".source_url">>test
#done
gzip logs/*.txt

find gallery-dl -iname "info.json" -delete
find gallery-dl -empty -delete


#cd gallery-dl
#for file in * ; do
#	cd $file
#	find . -mindepth 1 -type d '!' -exec sh -c 'ls -1 "{}"|egrep -i -q "^**\.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip)$"' ';' -print
#done
#cd ..



if [ -d "./gallery-dl/kemonoparty" ]
then
echo kemono
for file in gallery-dl/kemonoparty/*/* ; do
echo "$file"
cd "$file"
	for file in *.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip|rar|7z) ; do
		echo "$file"

		cat "$file.json" | jq '.user' | sed 's/^/user: /g' >> "$file.txt"
		cat "$file.json" | jq '.id' | sed 's/^/post: /g' >> "$file.txt"
		cat "$file.json" | jq '.service' | sed 's/^/service: /g' >> "$file.txt"
	done
	
	for file in *.(zip|rar|7z); do 
	unar -f "$file" -o "$file ext"
	cp "$file.txt" "$file ext/tags.txt"
	cd "$file ext"
	echo "zipfile" >> tags.txt
		for file in ./**/*; do
			cp tags.txt "$file.txt"
	done
	cd ..
done

cd ../../../..
done

    echo "$DIR_ABSOLUTE_PATH exists."
fi

if [ -d "./gallery-dl/coomerparty" ]
then
echo coomer

for file in gallery-dl/coomerparty/*/* ; do
echo "$file"
cd "$file"
	for file in *.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do
		echo "$file"

		cat "$file.json" | jq '.user' | sed 's/^/user: /g' >> "$file.txt"
		cat "$file.json" | jq '.id' | sed 's/^/post: /g' >> "$file.txt"
		cat "$file.json" | jq '.service' | sed 's/^/service: /g' >> "$file.txt"
	done

cd ../../../..
done

fi

if [ -d "./gallery-dl/exhentai" ]
then
echo exh

for file in gallery-dl/exhentai/* ; do
echo "$file"
cd "$file"

	for file in *.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do
		echo "$file"

		cat "$file.json" | jq '.title' | sed 's/^/gallery: /g' >> "$file.txt"
		cat "$file.json" | jq '.num' | sed 's/^/page: /g' >> "$file.txt"
		cat "$file.json" | jq '.tags' | sed 's/ /\n/g' >> "$file.txt"
	done
cd ../../..
done

fi



if [ -d "./gallery-dl/twitter" ]
then
echo twitter

for file in gallery-dl/twitter/* ; do
echo "$file"
cd "$file"

	for file in *.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do
		echo "$file"
		cat "$file.json" | jq '.mentions' | grep id | sed 's/^/mentions: /g' >> "$file.txt"
		cat "$file.json" | jq '.mentions' | grep name | sed 's/^/mentions: /g'  >> "$file.txt"
		cat "$file.json" | jq '.mentions' | grep nick | sed 's/^/mentions: /g'  >> "$file.txt"

		cat "$file.json" | jq '.author' | grep name | sed 's/^/author: /g' >> "$file.txt"
		cat "$file.json" | jq '.author' | grep nick | sed 's/^/author: /g' >> "$file.txt"
		cat "$file.json" | jq '.author' | grep id | sed 's/^/author: /g' >> "$file.txt"
		
		cat "$file.json" | jq '.search' | sed 's/^/search: /g' >> "$file.txt"


		cat "$file.json" | jq '.tweet_id' | sed 's/^/tweet_id:/g' >> "$file.txt"
		#cat "$file.json" | jq '.content' | sed 's/^/tweet_content:/g' >> "$file.txt"
	done
cd ../../..
done



fi


if [ -d "./gallery-dl/e621/pool" ]
then 
echo e621pool

cd gallery-dl/e621/pool
for file in *;do
cd $file
	for file in *.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do
                cat "$file.json" | jq '.pool' | grep \"name | sed 's/^/series: /g' | sed 's/   \"name\": \"//g' | sed 's/\",//g' >>$file.txt
		echo $file
	done
cd ..
done
repeat 3 cd ..

fi



if [ -d "./gallery-dl/pixiv" ]
then 
echo pixiv

for file in gallery-dl/pixiv/**/*.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip);do
                cat "$file.json" | jq '.rating' | grep \"rating | sed 's/^/rating: /g' | sed 's/   \"rating\": \"//g' | sed 's/\",//g' >>$file.txt
		echo $file
done

fi


if [ -d "./gallery-dl/newgrounds" ]
then
echo newgrounds

for file in gallery-dl/newgrounds/**/*.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip);do
                jq .rating "$file.json" | sed 's/\"//g' |sed 's/^/rating: /g' >>$file.txt
done

fi




if [ -d "./gallery-dl/directlink" ]
then
echo directlink

cd gallery-dl/directlink
for file in *.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do
		echo "$file"
		echo "source: directlink" >>"$file.txt"
		cat "$file.json" | jq '.domain' | sed 's/^/domain: /g' >> "$file.txt"

done
cd ../..
fi


if [ -d "./gallery-dl/toyhouse" ]
then
echo toyhouse

cd gallery-dl/toyhouse
for file in ./**/*.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do

echo $file

	cat "$file.json" | jq .characters | grep -v "\[" | grep -v "\]" | sed 's/ /\n/g' | sed 's/^/character:/g' | sed 's/character:$//g' >> $file.txt
	#cat "$file.txt" | sed 's/character:$//g' > /tmp/char
	#cp -f /tmp/char "$file.txt"

done

cd ../..

fi


echo tweak
for file in gallery-dl/**/*.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do  
echo "$file"

	cat "$file.json" | jq '.category' | sed 's/^/source: /g' >> "$file.txt"
	cat "$file.json" | jq '.artist' | sed 's/^/artist: /g' >> "$file.txt"
	sed -i '/artist: null/d' "$file.txt"
	sed -i '/artist: \[/d' "$file.txt"
	sed -i '/artist: \]/d' "$file.txt"



#	cat "$file.json" | jq '.tags' | sed 's/[[:space:]]/\n/g'>> "$file.txt"
	sed -i '/null/d' "$file.txt"

	
	cat "$file.txt" | sed 's/}//g' |\
	sed 's/{//g' |\
	\
	sed 's/\[//g' |\
	sed 's/\]//g' |\
	\
	sed 's/^ //g' |\
	sed 's/^tags: //g' |\
	sed 's/"//g' |\
	\
	sed 's/,$//g' |\
	\
	sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g' > /tmp/a.txt
	cp -f /tmp/a.txt $file.txt

done



find -iname "*.txt.txt" -delete
