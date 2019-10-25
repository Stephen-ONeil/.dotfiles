#!/bin/bash
current_space_index=$($HOME/.skhdrc-scripts/get_current_space_index.sh)

for window_id in $($HOME/.skhdrc-scripts/get_window_ids_in_space.sh $current_space_index);
do
  yabai -m window $window_id --close;
done;

yabai -m space $current_space_index --destroy;