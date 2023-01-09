#!/bin/bash
mkdir -p logs
date=$(date)
echo " " >>"logs/$date.txt"
echo "URL: $@" >>"logs/$date.txt"
echo "====================" >>"logs/$date.txt"
gallery-dl --cookies ./twitter.com_cookies.txt  --download-archive tera.sqlite   --write-metadata --write-info-json --write-tags   --mtime-from-date --filter "extension not in ('psd','zip','clip')"  $@ >> "logs/$date.txt"

#You may think it's tiny files, but a single run of my archiver generates 6 megs of files. gzipping reduces it to 1.
#nvim opens the gz files fine.

