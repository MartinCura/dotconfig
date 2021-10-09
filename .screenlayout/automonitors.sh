#!/bin/bash
cd $HOME/.screenlayout
exec &>> ./log.txt
python3 ./automonitors.py
