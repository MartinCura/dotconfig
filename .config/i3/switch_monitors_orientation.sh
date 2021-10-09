#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

ORIENTATION_FILE=/home/martin/.config/i3/orientation
# Vertical: 0, horizontal: 1

if [ ! -f ${ORIENTATION_FILE} -o $(cat ${ORIENTATION_FILE}) -eq 1 ]
then
	#notify-send -a x "Switching to vertical (0)"
	echo "0" > ${ORIENTATION_FILE}
	${HOME}/.screenlayout/vertical-two-monitor.sh -i3
else
	#notify-send -a x "Switching to horizontal with laptop first (1)"
	echo "1" > ${ORIENTATION_FILE}
	${HOME}/.screenlayout/horizontal-two-monitor.sh -i3
fi
