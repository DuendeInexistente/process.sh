#!/bin/bash
mkdir -p logs
date=$(date)
echo " " >>"logs/$date"
echo "URL: $@" >>"logs/$date"
echo "====================" >>"logs/$date"
gallery-dl --cookies ./twitter.com_cookies.txt  --download-archive tera.sqlite   --write-metadata --write-info-json --write-tags   --mtime-from-date --filter "extension not in ('psd','zip','clip')"  $@ >> "logs/$date"

#You may think it's tiny files, but a single run of my archiver generates 6 megs of files. gzipping reduces it to 1.
#nvim opens the gz files fine.
gzip logs/*.txt

