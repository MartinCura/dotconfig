#!/bin/bash
PLAYER=youtubemusic #spotify
STATUS=$(playerctl -p $PLAYER status 2> /dev/null)
#STATUS=$(playerctl status 2> /dev/null)
[[ $STATUS != 'Playing' ]] && [[ $STATUS != 'Paused' ]] && echo " " && exit 0
echo "$(playerctl -p $PLAYER metadata artist)  /  $(playerctl -p $PLAYER metadata title)"
#echo "$(playerctl metadata artist)  /  $(playerctl metadata title)"
#♪
