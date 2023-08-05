#!/usr/bin/bash
number=0
mkdir /tmp/lists

./randlist.sh >/tmp/list.txt
echo $@>/tmp/echos.txt

while read p; do
  echo "$p">/tmp/lists/$(printf "%03d" $number).txt
  number=$(($number+1))
done < /tmp/list.txt


tmux kill-session -t backup
tmuxp load ./layout.yaml
