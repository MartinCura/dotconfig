#!/bin/bash
#gcalcli agenda --military 00:00 23:59 | head -2 | tail -1 | sed 's/^[^0-9]*[0-9]*//' | cut -d' ' -f3- | grep -v Traceback | grep -v "\bF\b"
gcalcli agenda --military $(date +%H:%M) $(date +%H:%M -d "+30 minutes") \
	| head -2 | tail -1 | sed 's/^[^0-9]*[0-9]*//' | cut -d' ' -f3- \
	| grep -v Traceback | grep -v "\bF\b"
