#!/bin/bash
gallery-dl  --download-archive tera.sqlite   --write-metadata --write-info-json --write-tags   --mtime-from-date --filter "extension not in ('psd','clip')"  $@ 

#You may think it's tiny files, but a single run of my archiver generates 6 megs of files. gzipping reduces it to 1.
#nvim opens the gz files fine.

