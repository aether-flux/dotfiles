#!/bin/bash

# source ~/.zshrc
#
# cd ~/Projects
# selected_dir=$(find . -maxdepth 1 -type d | sed 's|^\./||' | fzf)
# fullpath="$HOME/Projects/$selected_dir"
#
# if [[ -n $selected_dir ]]; then
#   tmux new-session -s "$selected_dir" -n "Code" -c "$fullpath" \; \
#     split-window -c "$fullpath" \; \
#     attach-session -t "$selected_dir"
# fi

project_list=$(find ~/Projects -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)

selected=$(echo "$project_list" | rofi -dmenu -i -p "Launch project: " -theme ~/.config/rofi/launchers/project/config.rasi)

if [[ -n "$selected" ]]; then
  fullpath="$HOME/Projects/$selected"
  tmux new-session -s "$selected" -n "Code" -c "$fullpath" \; \
    split-window -c "$fullpath" \; \
    attach-session -t "$selected"
fi

