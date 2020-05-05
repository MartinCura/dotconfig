#!/bin/bash
STATUS=$(playerctl status 2> /dev/null)
[[ $STATUS != 'Playing' ]] && [[ $STATUS != 'Paused' ]] && echo " " && exit 0
echo "$(playerctl metadata artist)  /  $(playerctl metadata title)"
#♪
