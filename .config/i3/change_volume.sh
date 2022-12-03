#!/bin/bash
export LC_ALL=C
# Copied from https://askubuntu.com/a/1362081, hack-ish but so volume doesn't get so loud

# + or -
orientation=$1

max_volume_pc=80
delta=2
current_volume_pc=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

if [[ $orientation == "+" ]]; then
    if (($current_volume_pc < $max_volume_pc-$delta)) ; then
        pactl set-sink-volume @DEFAULT_SINK@ +$delta%
    else
        a=$(($max_volume_pc - $current_volume_pc))
        pactl set-sink-volume @DEFAULT_SINK@ +$a%
    fi
else
    if (($current_volume_pc > $max_volume_pc)); then
        pactl set-sink-volume @DEFAULT_SINK@ $max_volume_pc%
    else
        pactl set-sink-volume @DEFAULT_SINK@ -$delta%
    fi
fi
