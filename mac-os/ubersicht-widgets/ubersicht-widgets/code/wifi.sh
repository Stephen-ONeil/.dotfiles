#!/bin/bash

INFO="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo)"

if [[ "$INFO" == 'AirPort: Off' ]]; then
    echo "OFF"
elif [[ "$(echo "$INFO" | awk '/state:/ {print $2}')" == 'init' ]]; then
    echo "NONE"
else
    DBM=$(echo "$INFO" | awk '/agrCtlRSSI/ {print $NF}')
    if [[ "$DBM" -le -100 ]]; then
        QUALITY=0
    elif [[ "$DBM" -ge -50 ]]; then
        QUALITY=100
    else
        QUALITY=$(echo "2 * ($DBM + 100)" | bc -l)
    fi
    SSID=$(echo "$INFO" | awk '/[^B]SSID/ {print $NF}')
    echo "$SSID ${QUALITY}%"
fi


