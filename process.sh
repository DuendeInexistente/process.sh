#!/bin/zsh
#for file in gallery-dl/(*booru|*rule34*|e621)/*(|/*).(jpg|png|mp4|gif|wmv|webm|avi) ; do
#	echo "$file">>test
#	cat "$file.json" | jq ".source" >>test
#	cat "$file.json" | jq ".sources">>test
#	cat "$file.json" | jq ".sourcelist">>test
#	cat "$file.json" | jq ".source_url">>test
#done
find gallery-dl -iname "info.json" -delete
find gallery-dl -empty -delete

if [ -d "./gallery-dl/kemonoparty" ]
then

for file in gallery-dl/kemonoparty/*/* ; do
echo "$file"
cd "$file"
	for file in *.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do
		echo "$file"

		cat "$file.json" | jq '.user' | sed 's/^/user: /g' >> "$file.txt"
		cat "$file.json" | jq '.id' | sed 's/^/post: /g' >> "$file.txt"
		cat "$file.json" | jq '.service' | sed 's/^/service: /g' >> "$file.txt"

		cat "$file.txt" | sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g'>/tmp/c
		cp /tmp/c "$file.txt"

		sed 's/'\"'//g' "$file.txt" > /tmp/a
		cp /tmp/a "$file.txt"

		sed 's/,$//g' "$file.txt" > /tmp/b
		cp /tmp/b "$file.txt"
	done

cd ../../../..
done

    echo "$DIR_ABSOLUTE_PATH exists."
fi

if [ -d "./gallery-dl/coomerparty" ]
then

for file in gallery-dl/coomerparty/*/* ; do
echo "$file"
cd "$file"
	for file in *.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do
		echo "$file"

		cat "$file.json" | jq '.user' | sed 's/^/user: /g' >> "$file.txt"
		cat "$file.json" | jq '.id' | sed 's/^/post: /g' >> "$file.txt"
		cat "$file.json" | jq '.service' | sed 's/^/service: /g' >> "$file.txt"

		cat "$file.txt" | sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g'>/tmp/c
		cp /tmp/c "$file.txt"

		sed 's/'\"'//g' "$file.txt" > /tmp/a
		cp /tmp/a "$file.txt"

		sed 's/,$//g' "$file.txt" > /tmp/b
		cp /tmp/b "$file.txt"
	done

cd ../../../..
done

fi

if [ -d "./gallery-dl/exhentai" ]
then

for file in gallery-dl/exhentai/* ; do
echo "$file"
cd "$file"

	for file in *.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do
		echo "$file"

		cat "$file.json" | jq '.title' | sed 's/^/gallery: /g' >> "$file.txt"
		cat "$file.json" | jq '.num' | sed 's/^/page: /g' >> "$file.txt"
		cat "$file.json" | jq '.tags' >> "$file.txt"
		cat "$file.txt" | sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g'>/tmp/c
		cp /tmp/c "$file.txt"

		sed 's/'\"'//g' "$file.txt" > /tmp/a
		cp /tmp/a "$file.txt"

		sed 's/,$//g' "$file.txt" > /tmp/b
		cp /tmp/b "$file.txt"
	done
cd ../../..
done

fi



if [ -d "./gallery-dl/twitter" ]
then

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


		cat "$file.json" | jq '.tweet_id' | sed 's/^/tweet_id:/g' >> "$file.txt"
		#cat "$file.json" | jq '.content' | sed 's/^/tweet_content:/g' >> "$file.txt"
		cat "$file.txt" | sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g'>/tmp/c
		cp /tmp/c "$file.txt"
		sed 's/'\"'//g' "$file.txt" > /tmp/a
		cp /tmp/a "$file.txt"
		sed 's/,$//g' "$file.txt" > /tmp/b
		cp /tmp/b "$file.txt"
	done
cd ../../..
done



fi


if [ -d "./gallery-dl/e621/pool" ]
then 

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

for file in gallery-dl/pixiv/**/*.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip);do
                cat "$file.json" | jq '.rating' | grep \"rating | sed 's/^/rating: /g' | sed 's/   \"rating\": \"//g' | sed 's/\",//g' >>$file.txt
		echo $file
done

fi


if [ -d "./gallery-dl/newgrounds" ]
then

for file in gallery-dl/newgrounds/**/*.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip);do
                jq .rating "$file.json" | sed 's/\"//g' |sed 's/^/rating: /g' >>$file.txt
done

fi




for file in gallery-dl/**/*.(avi|gif|jpg|m4v|mp4|png|swf|webm|wmv|zip) ; do  
echo "$file"
	cat "$file.json" | jq '.category' | sed 's/^/source: /g' >> "$file.txt"

	cat "$file.txt" | sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g'>/tmp/c
	cp /tmp/c "$file.txt"
	sed 's/'\"'//g' "$file.txt" > /tmp/a
	cp /tmp/a "$file.txt"
	sed 's/,$//g' "$file.txt" > /tmp/b
	cp /tmp/b "$file.txt"
done



















