#!/bin/bash
revert() {
  #rm /tmp/*screen*.png
  xset dpms 0 0 0
}
trap revert HUP INT TERM
xset +dpms dpms 0 0 1

#scrot -d 0.25 /tmp/locking_screen.png
#convert -blur 0x8 /tmp/locking_screen.png /tmp/screen_blur.png
#convert -composite /tmp/screen_blur.png $HOME/.config/i3/Evil_Rick_Sprite.png -gravity South -geometry -20x1200 /tmp/lockscreen.png

echo "1" > $HOME/.config/i3/locked
# Inactivity timeout set to 7 seconds
xset +dpms dpms 0 0 7

#if (( `xrandr | grep ' connected' .... how to detect disabled monitors?
#LOCK_IMAGE=$HOME/.config/i3/default_lockscreen_single.png
#LOCK_IMAGE=$HOME/.config/i3/default_lockscreen_vertmon.png
LOCK_IMAGE=$HOME/.config/i3/default_lockscreen_dual_horizontal.png

#i3lock --nofork -i /tmp/lockscreen.png --ignore-empty-password --show-failed-attempts
i3lock --nofork -i $LOCK_IMAGE --ignore-empty-password --show-failed-attempts

echo "0" > $HOME/.config/i3/locked
revert
