#!/bin/bash
gallery-dl --cookies ./twitter.com_cookies.txt  --download-archive tera.sqlite   --write-metadata --write-info-json --write-tags   --mtime-from-date --filter "extension not in ('psd','zip','clip')"  $@

#$(cat downloads/75-exhentai-magictouch.txt)

#gallery-dl -i download.txt --cookies twitter.com_cookies.txt  --download-archive tera.txt  --write-metadata --write-info-json --write-tags   --mtime-from-date --filter "extension not in ('psd')"