#!/bin/sh

BATTERY=$(pmset -g batt)

SOURCE=$(echo "$BATTERY" | grep -oE "'.*?'" | sed -E "s/'(.*) Power'/\1/")
if [[ "$SOURCE" == 'AC' ]]; then
    ICON="+"
    TIME_REMAINING=""
else
    ICON="-"
    TIME_REMAINING=$(echo "$BATTERY" | grep -oE '[^ ]* remaining')
fi

PERCENT=$(echo "$BATTERY" | grep -oE '\d*%' | tr -d '%')
if [[ "$PERCENT" -lt 20 ]]; then
    status_style="color: red"
else
    status_style=""
fi
PERCENT_DISPLAY="<span style='$status_style'>$PERCENT</span>%"

echo "${ICON} ${PERCENT_DISPLAY} ${TIME_REMAINING}"