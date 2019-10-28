#!/bin/bash

# get desired system info and make it safe to parse as JSON

battery_info=$(pmset -g batt | tr "\n" ";")

wifi_info=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo | tr "\n" ";" | sed -e "s/ //g")

echo $(echo "{
  \"battery_info\": \"$battery_info\",
  \"wifi_info\": \"$wifi_info\",
  \"date\": \"$(date "+%H:%M:%S %d-%m-%Y")\"
}" | tr "\n" " ")