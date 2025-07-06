#!/bin/zsh

selected=$(find $HOME -type f 2> /dev/null | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')

if [[ -n $selected ]]; then
  nvim "$selected"
fi
