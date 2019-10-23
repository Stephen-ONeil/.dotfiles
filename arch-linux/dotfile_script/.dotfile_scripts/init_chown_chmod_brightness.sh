#!/bin/bash

# To be run at startup by a systemd service, need to give the video group write access to the backlight brightness file for ./backlightadjust.sh to work
sudo chown root:video /sys/class/backlight/*/brightness
sudo chmod 665 /sys/class/backlight/*/brightness 
