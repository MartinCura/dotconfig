#!/bin/bash
while :
do
	sleep 5
	STATUS=$(nmcli device show wlp59s0 | grep STATE | tr -s ' ' | cut -d':' -f2 | cut -d' ' -f2-)
	[[ "$STATUS" != '20 (unavailable)' ]] && continue
	echo 'wifi resetter: status '$STATUS' ! Restarting'
	#sudo /bin/systemctl restart network-manager
	sleep 10
done
