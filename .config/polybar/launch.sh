#!/usr/bin/env bash
#IFS=' '

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

#BARNAME=main
BARNAME=minimalist
#CONFIG="-c ~/.config/polybar/config"
CONFIG="~/.config/polybar/config.green"
OPTS="-r"

# To have access to scripts and else
cd ~/.config/polybar

# Launch polybar(s)
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | grep -v "None" | cut -d" " -f1); do
		LOGFILE="/tmp/polybar-$BARNAME-$m.log"
		echo "---" | tee -a "$LOGFILE"
		MONITOR=$m polybar $BARNAME --reload -c $CONFIG $OPTS >>${LOGFILE} 2>&1 &
		echo "polybar $BARNAME launched in monitor $m"
	done
else
	echo "---" | tee -a /tmp/polybar-${BARNAME}.log
	polybar $BARNAME -c $CONFIG $OPTS >>/tmp/polybar-$BARNAME.log 2>&1 &
fi

echo "polybar(s) launched..."
