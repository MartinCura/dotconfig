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
xset +dpms dpms 0 0 10

#i3lock --nofork -i /tmp/lockscreen.png --ignore-empty-password --show-failed-attempts
i3lock --nofork -i $HOME/.config/i3/default_lockscreen_vertmon.png --ignore-empty-password --show-failed-attempts

echo "0" > $HOME/.config/i3/locked
revert
