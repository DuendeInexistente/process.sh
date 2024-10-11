#!/usr/bin/zsh

tmux set -g pane-border-status top
for file in /tmp/lists/*.txt ; do
if [ -f "$file" ]
then
	URL=$(cat $file)
	rm -f $file
	echo $file: $URL
	tmux rename-window -t $TMUX_PANE "$URL"
	./dl.sh $URL $(cat /tmp/echos.txt)
fi
done

#if [ -d "$file" ] then
#fi
