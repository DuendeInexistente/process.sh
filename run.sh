#!/bin/bash
7z a "terabackups/$(date).7z" tera.sqlite
./list.sh
./list.sh > /tmp/list.txt 
./concurr.sh $@
./process.sh
