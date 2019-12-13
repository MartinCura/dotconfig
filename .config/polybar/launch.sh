#!/usr/bin/env bash
IFS=' '

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#BARNAME=main
BARNAME=minimalist
#CONFIG="-c ~/.config/polybar/config"
CONFIG=~/Code/zetc/polybar-themes/polybar-2/dark/config.green
OPTS="-r"

# To have access to scripts and else
cd ~/.config/polybar

# Launch polybars
echo "---" | tee -a /tmp/polybar-main.log
polybar $BARNAME -c $CONFIG $OPTS >>/tmp/polybar-$BARNAME.log 2>&1 &

echo "polybar launched..."
