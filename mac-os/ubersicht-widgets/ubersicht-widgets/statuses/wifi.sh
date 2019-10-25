#!/bin/bash

info="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo)"

if [[ "$info" == 'AirPort: Off' ]]; then
  status="off"
  status_class="bad"
elif [[ "$(echo "$info" | awk '/state:/ {print $2}')" == 'init' ]]; then
  status="disconnected"
  status_class="bad"
else
  dbm=$(echo "$info" | awk '/agrCtlRSSI/ {print $NF}')
  if [[ "$dbm" -le -100 ]]; then
    quality=0
  elif [[ "$dbm" -ge -50 ]]; then
    quality=100
  else
    quality=$(echo "2 * ($dbm + 100)" | bc -l)
  fi
  ssid=$(echo "$info" | awk '/[^B]SSID/ {print $NF}')
  
  status="${quality}% at $ssid"
  if [[ $quality -le 60 ]]; then
    status_class="degraded"
  elif [[ $quality -le 30 ]]; then
    status_class="bad"
  else
    status_class="good"
  fi
fi

echo "<span class='$status_class'>( $status )</span>"
