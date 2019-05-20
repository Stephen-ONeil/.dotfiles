#!/bin/bash

ac_status=(acpi -a)

if [[ $ac_status == *"on-line"* ]]
then
  status_icon="+" #"\xF0\x9F\x9a4\x8C"
else
  status_icon="-" #"\xE2\x9A\xA1"
fi

echo -e "$status_icon `cat /sys/class/power_supply/BAT0/capacity`%"
