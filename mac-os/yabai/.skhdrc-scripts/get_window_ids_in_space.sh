#!/bin/bash
yabai -m query --windows --space $1 | jq -r 'map(."id")' | tr -d "\[\], " | sed '/^[[:space:]]*$/d'