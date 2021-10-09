#!/bin/bash
#set -euo pipefail
IFS='\n\t'

# less than 2 monitors, just exit
if (( `xrandr | grep ' connected' | wc -l` < 2 )); then
  xrandr \
	--output DP-3 --off \
	--output eDP-1  --mode 3840x2160 --rotate normal --primary
  xrandr --output DP-3 --off
  xrandr --output eDP-1 --primary
  notify-send -a x "Switched to single monitor"

  xinput --map-to-output 'Wacom HID 488F Finger' eDP-1
  xinput --map-to-output 'Wacom HID 488F Finger touch' eDP-1
  xinput --map-to-output 'Wacom HID 488F Pen stylus' eDP-1
  xinput --map-to-output 'Wacom HID 488F Pen eraser' eDP-1
  exit 1
fi

SCALE_OPT1=""
SCALE_OPT2=""
# (for i3) pass any argument to scale down 1080p monitor
if (( $# > 0 )); then
  SCALE_OPT1="--scale"
  SCALE_OPT2="2x2"
fi

#xrandr --output DP-3 --mode 1920x1080 --pos 0x0 --rotate normal --primary --output DP-1 --off --output eDP-1 --mode 3840x2160 --pos 0x2160 --rotate normal --output DP-2 --off
xrandr --output DP-3  --mode 1920x1080 $SCALE_OPT1 $SCALE_OPT2 --pos 3840x0 --rotate normal --primary                     --output eDP-1  --mode 3840x2160 --pos 0x0 --rotate normal

# TODO: fix touch mapping

notify-send -a x "Switched to horizontal with laptop first (1)"
