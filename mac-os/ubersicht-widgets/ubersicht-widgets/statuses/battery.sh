#!/bin/sh

battery=$(pmset -g batt)

percent=$(echo "$battery" | grep -oE '\d*%' | tr -d '%')
percent_display="$percent%"

source=$(echo "$battery" | grep -oE "'.*?'" | sed -E "s/'(.*) Power'/\1/")
if [[ "$source" == 'AC' ]]; then
  ac_indicator="+"

  if [[ "$percent" -ge 85 ]]; then
    status_class="good"
  fi
else
  ac_indicator="-"

  if [[ "$percent" -le 20 ]]; then
    status_class="bad"
  elif [[ "$percent" -le 30 ]]; then
    status_class="degraded"
  fi
fi

# either time remaining to full charge or time remaining on current charge. Also often 0:00 or not available 
time_remaining="$(echo "$battery" | grep -oE '[^ ]* remaining' | tr -d [" "remaining])"
if [[ $time_remaining == "" || $time_remaining == "0:00" ]]; then
  time_remaining_display="no estimate"
else
  time_remaining_display=$time_remaining
fi

echo "<span class='$status_class'>[ ${ac_indicator}${percent_display}, ${time_remaining_display} ]</span>"
