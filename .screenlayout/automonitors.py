#!/usr/bin/env python3
from typing import List
from enum import Enum
import subprocess
import yaml
'''
switch
    only eDP-1 -> off rest, only that
    eDP-1 + 1 ext monitor -> off rest, switch vertical or horizontal
    eDP-1 + 2 ext monitors -> laptop off & 2 horiz OR all on, laptop below, switch externals
    2 ext monitors -> off eDP-1
'''
LAPTOP = 'eDP-1'
EXT_1 = 'DP-3'
EXT_2 = 'DP-1-1'
CONFIG_FILE = './mode.yml'


class Mode(Enum):
    LAPTOP = 'laptop'
    LAPTOP_EXT_1 = 'laptop_ext_1'
    LAPTOP_EXT_2 = 'laptop_ext_2'
    LAPTOP_TWO_EXT = 'laptop_ext_1_2'
    TWO_EXT = 'ext_1_2'


with open(CONFIG_FILE, 'r') as rf:
    config = yaml.safe_load(rf)


def getScreens():
    proc = subprocess.run(['xrandr'], encoding='utf-8', stdout=subprocess.PIPE)
    xrandr_outout = proc.stdout.split('\n')
    return {line.split(' ')[0]: (' connected' in line) for line in xrandr_outout
            if 'connected' in line}


screens = getScreens()
connectedScreens = set([s for s, c in screens.items() if c])
disconnectedScreens = set([s for s, c in screens.items() if not c])
print('connected:', connectedScreens)

if connectedScreens == {LAPTOP}:
    mode = Mode.LAPTOP
elif connectedScreens == {LAPTOP, EXT_1}:
    mode = Mode.LAPTOP_EXT_1
elif connectedScreens == {LAPTOP, EXT_2}:
    mode = Mode.LAPTOP_EXT_2
elif connectedScreens == {LAPTOP, EXT_1, EXT_2}:
    mode = Mode.LAPTOP_TWO_EXT
elif connectedScreens == {EXT_1, EXT_2}:
    mode = Mode.TWO_EXT

print(mode)
mode_commands = config['modes'][mode.value]['commands']
actual = config['modes'][mode.value]['actual']
new_actual = (actual + 1) % len(mode_commands)
config['modes'][mode.value]['actual'] = new_actual
print('new_actual:', new_actual, '\n->', mode_commands[new_actual]['name'])


def generateOutputOption(mode: Mode, screen: str) -> List[str]:
    return mode_commands[new_actual][screen].split(' ')


def generateXrandrCommand(mode: Mode, connectedScreens=[], disconnectedScreens=[]) -> List[str]:
    command = ['xrandr']
    for screen in connectedScreens:
        command.extend(['--output', screen])
        command.extend(generateOutputOption(mode, screen))
    for screen in disconnectedScreens:
        command.extend(['--output', screen, '--off'])
    return command


xrandrCommand = generateXrandrCommand(
    mode, connectedScreens, disconnectedScreens)
print(xrandrCommand)

subprocess.run(xrandrCommand, encoding='utf-8')

subprocess.run(['notify-send', '-a', 'automonitors.py', mode_commands[new_actual]['name']])

# TODO: Could be prettier with ruamel.yaml instead of (py)yaml
with open(CONFIG_FILE, 'w') as wf:
    yaml.safe_dump(config, wf)

subprocess.run(['./fix_touchscreen.sh']);
