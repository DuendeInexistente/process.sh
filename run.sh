#!/bin/bash
mkdir -p terabackups
7z a "terabackups/$(date).7z" tera.sqlite
./list.sh
./list.sh > /tmp/list.txt 
./concurr.sh $@
./process.sh
gzip logs/*.txt
