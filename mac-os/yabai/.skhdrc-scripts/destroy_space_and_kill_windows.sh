#!/bin/bash
current_space_index=$($HOME/.skhdrc-scripts/get_current_space_index.sh)

for window_id in $(yabai -m query --windows --space $current_space_index | jq -r 'map(."id")' | tr -d "\[\], ");
do
  yabai -m window $window_id --close;
done;

yabai -m space $current_space_index --destroy;