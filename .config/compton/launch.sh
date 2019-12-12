#!/usr/bin/env bash

# Terminate already running instances
killall -q compton

# Wait until the processes have been shut down
while pgrep -u $UID -x compton >/dev/null; do sleep 1; done

CONFIG="--config $HOME/.config/compton.conf"
OPTS="-b --paint-on-overlay"

# Launch compton
echo "---" | tee -a /tmp/compton.log
compton $CONFIG $OPTS >>/tmp/compton.log 2>&1

echo "compton launched..."
