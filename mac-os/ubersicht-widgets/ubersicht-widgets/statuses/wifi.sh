#!/bin/bash

INFO="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo)"

if [[ "$INFO" == 'AirPort: Off' ]]; then
    status="off"
    status_class="bad"
elif [[ "$(echo "$INFO" | awk '/state:/ {print $2}')" == 'init' ]]; then
    status="disconnected"
    status_class="bad"
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
    
    status="${QUALITY}% at $SSID"
    if [[ $QUALITY -le 60 ]]; then
        status_class="degraded"
    elif [[ $QUALITY -le 30 ]]; then
        status_class="bad"
    else
        status_class="good"
    fi
fi

echo "<span class='$status_class'>( $status )</span>"
