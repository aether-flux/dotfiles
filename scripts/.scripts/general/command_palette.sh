#!/bin/bash

choice=$(printf "%s\n" \
  "Wisdom of the Silver Age" \
  "Enter a Pagoda" \
  "Open Artefacts" \
  "Open Scrolls" \
  "Screenshot (fullscreen)" \
  "Screenshot (selection)" \
  "Restart" | rofi -dmenu -i -p "Command Palette" -theme ~/.config/rofi/launchers/project/command_palette.rasi)

case $choice in
  "Screenshot (fullscreen)")
    grim ~/Pictures/Screenshots/$(date '+%y%m%d_%H-%M-%S').png && notify-send 'Screenshot Captured' 'Screenshot successfully captured and stored in ~/Pictures/Screenshots' ;;
  "Screenshot (selection)")
    grim -g "$(slurp)" ~/Pictures/Screenshots/$(date '+%y%m%d_%H-%M-%S').png && notify-send 'Screenshot Captured' 'Screenshot successfully captured and stored in ~/Pictures/Screenshots' ;;
  "Restart")
    ~/.scripts/general/restarter.sh ;;
  "Wisdom of the Silver Age")
    ~/.scripts/general/msgpopup.sh ;;
  "Open Artefacts")
    ~/.config/rofi/launchers/type-7/launcher.sh ;;
  "Open Scrolls")
    ~/.scripts/general/opener.sh ;;
  "Enter a Pagoda")
    kitty -e ~/.scripts/zsh/project_opener.sh ;;
esac

