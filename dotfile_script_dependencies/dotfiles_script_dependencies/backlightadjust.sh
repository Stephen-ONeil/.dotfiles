#!/bin/bash

if [[ $1 = '+' ]]; then
  adjustment_factor=".1"
elif [[ $1 = '-' ]]; then
  adjustment_factor="-.1"
else 
  echo "Error: backlightadjust.sh requires one argument, a value of eith  + (to increase brightness) or - (to decrease brightness)"
  exit 1
fi  


max_brightness=$(cat /sys/class/backlight/*/max_brightness)
min_brightness=$(bc <<< "scale=0; 0.1 * $max_brightness / 1")
current_brightness=$(cat /sys/class/backlight/*/brightness)

adjusted_brightness=$(bc <<< "scale=0; ($current_brightness + ($adjustment_factor * $max_brightness)) / 1")

if [[ adjusted_brightness -gt max_brightness ]]; then
  new_brightness=$max_brightness
elif [[ adjusted_brightness -lt min_brightness ]]; then
  new_brightness=$min_brightness
else
  new_brightness=$adjusted_brightness
fi

echo $new_brightness > /sys/class/backlight/intel_backlight/brightness
