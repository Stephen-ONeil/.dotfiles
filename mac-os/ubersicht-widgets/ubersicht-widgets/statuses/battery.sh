#!/bin/sh

BATTERY=$(pmset -g batt)

PERCENT=$(echo "$BATTERY" | grep -oE '\d*%' | tr -d '%')
PERCENT_DISPLAY="$PERCENT%"

SOURCE=$(echo "$BATTERY" | grep -oE "'.*?'" | sed -E "s/'(.*) Power'/\1/")
if [[ "$SOURCE" == 'AC' ]]; then
    AC_INDICATOR="+"
    TIME_REMAINING=" "

    if [[ "$PERCENT" -ge 85 ]]; then
        status_class="good"
    fi
else
    AC_INDICATOR="-"
    TIME_REMAINING=", $(echo "$BATTERY" | grep -oE '[^ ]* remaining' | tr -d [remaining])"

    if [[ "$PERCENT" -le 20 ]]; then
        status_class="bad"
    elif [[ "$PERCENT" -le 30 ]]; then
        status_class="degraded"
    fi
fi

echo "<span class='$status_class'>[ ${AC_INDICATOR}${PERCENT_DISPLAY}${TIME_REMAINING} ]</span>"
