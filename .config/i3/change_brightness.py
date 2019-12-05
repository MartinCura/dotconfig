##!/bin/bash
#actual=`cat /sys/class/backlight/intel_backlight/actual_brightness`
#max=`cat /sys/class/backlight/intel_backlight/max_brightness`

#if (( $# != 1 )); then
#	echo "Usage: change_brightness +/-"
#        exit 0
#fi

#echo "Actual is $actual and max is $max."
#new_n=$(( log ))

#!/usr/bin/env python3
import sys
import math

brightness_dir = '/sys/class/backlight/intel_backlight/'
with open(brightness_dir + 'max_brightness') as f:
    max_brightness = int(f.read().strip())
with open(brightness_dir + 'actual_brightness') as f:
    actual_brightness = int(f.read().strip())

#print(f'max is >{max_brightness}<')
#print(f'actual >{actual_brightness}<')

if len(sys.argv) != 2 or sys.argv[1] not in ['+', '-']:
    print("Usage:  change_brightness +/-")
    sys.exit(1)

actual_level = int(10 * math.log(actual_brightness + 3) / math.log(max_brightness))
diff = 1 if sys.argv[1] == '+' else -1
#print(actual_level + diff)
new_level = min(10, max(0, actual_level + diff))
#print(f'actual level is {actual_level} and new level will be {new_level}')
new_brightness = min(int(max_brightness ** (new_level / 10)), max_brightness)
#print(new_level)
#print(f'actual brightness is {actual_brightness} and new brightness is {new_brightness}')

with open('/sys/class/backlight/intel_backlight/brightness', 'w') as f:
    #print(str(new_brightness))
    f.write(str(new_brightness))

sys.exit(0)
