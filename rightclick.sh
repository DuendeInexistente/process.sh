#!/usr/bin/zsh
cd "/mnt/OldExt/Archives/gallery-dl/"
mkdir -p logs
date=$(date)
echo " " >>"logs/$date.txt"
echo "URL: $@" >>"logs/$date.txt"
echo "====================" >>"logs/$date.txt"

./dl.sh $@ | tee "logs/$date.txt"
