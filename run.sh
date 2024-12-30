#!/bin/bash
pipx upgrade gallery-dl
mkdir -p terabackups
7z a "terabackups/$(date).7z" tera.sqlite
./list.sh
./concurr.sh $@
./process.sh

