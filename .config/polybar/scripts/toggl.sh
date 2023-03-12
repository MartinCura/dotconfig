#!/bin/bash

# TOGGL_API_TOKEN should be set in i3blocks config.
source ~/.config/polybar/scripts/.env

CURRENT_ENTRY=$(curl -su $TOGGL_API_TOKEN:api_token -X GET https://api.track.toggl.com/api/v8/time_entries/current)

if [[ $(echo $CURRENT_ENTRY | jq -r ".data") == "null" ]]; then
    #echo ":timer_clock: No entry"
    echo ""
else
    NAME=$(echo $CURRENT_ENTRY | jq -r ".data.description")
    TIME_START=$(echo $CURRENT_ENTRY | jq -r ".data.start")
    TIME_DURATION=$(datediff $TIME_START $(date +"%Y-%m-%dT%H:%M:%S%Z") -f "%Hh %Mm")
    echo "[ $NAME $TIME_DURATION ]"
fi
