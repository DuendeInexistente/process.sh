#!/usr/bin/bash

valuelines=$(( $(./randlist.sh  | wc -l)/6+6))
currlines=$valuelines
episode=1
./randlist.sh >/tmp/list.txt
mkdir /tmp/lists
echo $@>/tmp/lists/echos.txt

function increas
(
[ $episode != 7 ] && {
	echo $episode:$currlines
	head -n $currlines /tmp/list.txt | tail -n $valuelines>/tmp/lists/$episode.txt
	currlines=$(($currlines+$valuelines))
	episode=$(($episode+ 1 ))
	increas
}
)
increas

tmux kill-session -t backup
tmuxp load ./layout.yaml
