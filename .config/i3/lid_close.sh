#!/bin/bash
LOCKED_DIR=/home/martin/.config/i3
while :
do
	sleep 3
	[ ! -f $LOCKED_DIR/locked -o $(cat $LOCKED_DIR/locked) -eq 1 ] && continue
        LID_STATE=$(cut -c 13- /proc/acpi/button/lid/*/state)
	[ "$LID_STATE" == "closed" ] && $LOCKED_DIR/rick_lock.sh
done
