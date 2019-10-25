#!/usr/bin/env bash
target_space_index=$1

current_window_id=$($HOME/.skhdrc-scripts/get_current_window_id.sh)
current_space_index=$($HOME/.skhdrc-scripts/get_current_space_index.sh)

# doesn't do anything if target space is current
[ target_space_index == current_space_index ] && exit

# move the window
yabai -m window --space $target_space_index

# check if the move left the current space empty, if so follow the window and destroy the now empty space
[ $($HOME/.skhdrc-scripts/get_window_ids_in_space.sh $current_space_index | wc -l) == 0 ] && \
  yabai -m space --focus $target_space_index && \
  yabai -m space $current_space_index --destroy
