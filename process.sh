#!/usr/bin/zsh
setopt NULL_GLOB
startdir=$PWD
find gallery-dl -iname "info.json" -delete
find gallery-dl -empty -delete

#some_routine() {
#    echo "foo $1"
#}
#
#some_var=$(some_routine bar)



textise() {
  txt="$(echo $json | sed 's/\.json/\.txt/g')"
  #echo $json
  #echo $txt
}

basictag() {
 # echo $json \"$json\"
 # cat "$json" | jq $1 | sed 's/^/\${2}: /g' >> "$txt"
 #sed doesn't like dealing with $variables, not at all
 cat "$json" | jq $1 | while read line; do
  echo $2: $line >>$txt
 done
}

greptag() {
 # echo $json \"$json\"
 # cat "$json" | jq $1 | sed 's/^/\${2}: /g' >> "$txt"
 #sed doesn't like dealing with $variables, not at all
 cat "$json" | jq $1 | grep $2 | while read line; do
  echo $3: $line >>$txt
 done
}



# -newermt $(date +%Y-%m-%d -d '4 days ago') What for?
find -L gallery-dl -type d | while IFS= read -r p; do
#Primer find  
  echo -----------------------
  movepath="$startdir/$p"
  echo "route: \($movepath\)"
  cd "$movepath"
  category=$(cat "$(find -iname "*.json" | head -1)" | jq .category | sed 's/"//g')
  subcat=$(cat "$(find -iname "*.json" | head -1)" | jq .subcategory | sed 's/"//g')

  echo $PWD
  echo "$p"
  #ls  
  

echo $category
case $category in
  deviantart)
    for json in *.json ; do
      textise
      basictag ".author.username" artist
      basictag ".folders" dafolder
      basictag ".is_mature" damature
      basictag ".da_category" dacategory 
    done
;;
  kemonoparty|coomerparty)
    for json in *.json ; do
      textise
 
      basictag ".user" user
      basictag ".id" post
      basictag ".service" service
      basictag ".subcategory" service
      cat "$json" | jq '.tags' | sed 's/,/\n/g' | sed 's/\\//g' >> "$txt"
    done

        if [ $subcat = discord ]; then
          for json in *.json ; do
            textise

            basictag ".author.username" discord_user
            basictag ".chanel_name" discord_channel
            basictag ".id" message_id
          done
        fi
;;
  exhentai)
    for json in *.json ; do
      textise
        rm $txt

        basictag ".title" gallery
        basictag ".num" page
    done
;;
  twitter)
    for json in *.json ; do
      textise
      

    greptag ".mentions" id mentions
    greptag ".mentions" name mentions
    greptag ".mentions" nick mentions


    greptag ".author" id author
    greptag ".author" name author
    greptag ".author" nick author
    
    
    greptag ".author" id involves
    greptag ".author" name involves
    greptag ".author" nick involves
    greptag ".mentions" id involves
    greptag ".mentions" name involves
    greptag ".mentions" nick involves

    cat "$json" | jq '.hashtags' | grep -v "\[" | grep -v "\]" |  sed 's/^/hashtag: /g' >> "$txt"

    basictag ".search" search
    basictag ".tweet_id" tweet_id

    done
;;
bluesky)
  for json in *.json ; do
    textise

    basictag ".post_id" post_id

    greptag ".author" handle author
    greptag ".author" displayname author

    cat "$json" | jq '.labels.values' | grep val | sed 's/\"val\"://g' | sed 's/,/\n/g'  |  sed 's/^/bluesky_label: /g' >> "$txt"
  done
;;
toyhouse)
  for json in *.json ; do
    textise
      cat "$json" | jq .characters | grep -v "\[" | grep -v "\]" | sed 's/ /\n/g' | sed 's/^/character:/g' | sed 's/character:$//g' >> $txt
      cat "$json" | jq .artists | grep -v "\[" | grep -v "\]" | sed 's/ /\n/g' | sed 's/^/artist:/g' | sed 's/artist:$//g' >> $txt
  done
;;
patreon)
  for json in *.json ; do
    textise

    cat "json" | jq .title | sed 's/"//g' | sed 's/^/title:/g' >> $txt
    basictag ".num" page
  done
  ;;
itaku)
  for json in *.json ; do
    textise
    basictag ".owner_username" itaku_user
    basictag ".maturity_rating" itaku_rating
    cat "$json" | jq .sections | sed 's/^  "/itaku_folder: /g' | sed 's/,$//g' | sed 's/\"$//g' >> $txt
  done
  ;;
redgifs)
  for json in *.json ; do
    textise
    basictag ".userName" redgif_user
    basictag ".sexuality" redgif_sex
    cat "$json" | jq .sexuality | grep -v "\[" | grep -v "\]" | sed 's/ /\n/g' | sed 's/^/redgif_sex:/g' | sed 's/redgif_sex:$//g' >> $txt
  done
  ;;
reddit)
  for json in *.json ; do
    textise
    basictag ".author" reddit_user
  done
  ;;
furaffinity)
  for json in *.json ; do
  textise
  basictag .folders fa_folder
  basictag .artist artist
  basictag .rating fa_rating
  done
;;

directlink)
  for json in *.json ; do
    textise

    basictag ".domain" domain
  done
  ;;
esac




echo $subcat
case $subcat in
  pool)
    for json in *.json ; do
      textise
      basictag ".pool.name" series
      basictag ".num" page
    done
;;
 gumroad)
  for json in *.json ; do
    textise
    basictag ".user" artist
  done
esac













  #General


    echo "cleaning"
#    echo 1
  for json in *.json ; do  
  textise
 # echo $json $txt

    basictag ".category" source
    basictag ".artist" artist
    basictag ".rating" rating
  
  done
#echo 1 done
#echo 2

  for file in *.txt ; do  
  #echo $file
      sed -i '/artist: null/d' "$file"
      sed -i '/artist: \[/d' "$file"
      sed -i '/artist: \]/d' "$file"



      sed -i '/null/d' "$file"

      
      cat "$file" | sed 's/}//g' |\
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
      cp -f /tmp/a.txt $file

  done
#echo 2 done



for file in *.(zip|rar|7z); do 
	echo $file
	unar -f "$file" -o "$file ext"
	cp "$file.txt" "$file ext/tags.txt"
	cd "$file ext"
	echo "zipfile" >> tags.txt
		for file in ./**/*; do
			cp tags.txt "$file.txt"
		done
	cd ..
done





#Ultimo done
done
