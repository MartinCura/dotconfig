#!/bin/bash
#set -euo pipefail
IFS='\n\t'

# less than 2 monitors, just exit
if (( `xrandr | grep ' connected' | wc -l` < 2 )); then
  xrandr \
	--output DP3 --off \
	--output eDP1  --mode 3840x2160 --rotate normal --primary
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
xrandr --output DP3  --mode 1920x1080 $SCALE_OPT1 $SCALE_OPT2 --pos 0x0 --rotate normal --primary                     --output eDP1  --mode 3840x2160 --pos 0x2160 --rotate normal
