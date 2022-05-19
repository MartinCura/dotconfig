#!/usr/bin/env bash

# Terminate already running instances
killall -q picom
killall -q compton

# Wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
while pgrep -u $UID -x compton >/dev/null; do sleep 1; done

CONFIG="--config $HOME/.config/picom/picom.conf"
LOGFILE="/tmp/picom.log"

# Launch picom
echo "---" | tee -a ${LOGFILE}
picom $CONFIG -b --experimental-backends >>${LOGFILE} 2>&1

echo "picom launched..."
