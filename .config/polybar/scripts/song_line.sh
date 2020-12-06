#!/bin/bash
STATUS=$(playerctl -p spotify status 2> /dev/null)
#STATUS=$(playerctl status 2> /dev/null)
[[ $STATUS != 'Playing' ]] && [[ $STATUS != 'Paused' ]] && echo " " && exit 0
echo "$(playerctl -p spotify metadata artist)  /  $(playerctl -p spotify metadata title)"
#echo "$(playerctl metadata artist)  /  $(playerctl metadata title)"
#♪
