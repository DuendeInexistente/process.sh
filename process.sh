#!/bin/zsh
find -empty -delete

for file in gallery-dl/twitter/* ; do
echo "$file"
cd "$file"

						for file in *.(jpg|png|mp4) ; do
						echo "$file"
						echo "Source:Twitter" > "$file.txt"

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

for file in gallery-dl/kemonoparty/*/* ; do
echo "$file"
cd "$file"

						for file in *.(jpg|png|mp4) ; do
						echo "$file"
						echo "Source:Kemono" > "$file.txt"
cat "$file.txt"

						cat "$file.json" | jq '.user' | sed 's/^/user: /g' >> "$file.txt"
						cat "$file.json" | jq '.id' | sed 's/^/post: /g' >> "$file.txt"
						cat "$file.json" | jq '.service' | sed 's/^/service: /g' >> "$file.txt"
						done
cd ../../..
done

for file in gallery-dl/coomerparty/*/* ; do
echo "$file"
cd "$file"

						for file in *.(jpg|png|mp4) ; do
						echo "$file"
						echo "Source:coomer" > "$file.txt"
cat "$file.txt"

						cat "$file.json" | jq '.user' | sed 's/^/user: /g' >> "$file.txt"
						cat "$file.json" | jq '.id' | sed 's/^/post: /g' >> "$file.txt"
						cat "$file.json" | jq '.service' | sed 's/^/service: /g' >> "$file.txt"
						done
cd ../../..
done



find -empty


