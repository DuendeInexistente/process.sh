#!/bin/zsh
find -empty -delete

for file in gallery-dl/twitter/* ; do
echo "$file"
cd "$file"

						for file in *.(jpg|png|mp4) ; do
						echo "$file"

						cat "$file.json" | jq '.mentions' | grep id | sed 's/^/mentions: /g' > "$file.txt"
						cat "$file.json" | jq '.mentions' | grep name | sed 's/^/mentions: /g'  >> "$file.txt"
						cat "$file.json" | jq '.mentions' | grep nick | sed 's/^/mentions: /g'  >> "$file.txt"

						cat "$file.json" | jq '.user' | grep name | sed 's/^/author: /g' >> "$file.txt"
						cat "$file.json" | jq '.user' | grep nick | sed 's/^/author: /g' >> "$file.txt"

						cat "$file.json" | jq '.tweet_id' | sed 's/^/tweet_id:/g' >> "$file.txt"
						#cat "$file.json" | jq '.content' | sed 's/^/tweet_content:/g' >> "$file.txt"

						cat "$file.txt" | sed 's/  / /g' | sed 's/  / /g' | sed 's/  / /g'>/tmp/c
						cp /tmp/c "$file.txt"

						sed 's/'\"'//g' "$file.txt" > /tmp/a
						cp /tmp/a "$file.txt"

						sed 's/,$//g' "$file.txt" > /tmp/b
						cp /tmp/b "$file.txt"
						done


cd ..
cd ..
cd ..
done


find -empty


