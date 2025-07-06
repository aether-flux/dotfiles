#!/bin/bash

OUTPUT="$HOME/Videos/Captures/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"

if pgrep wf-recorder > /dev/null; then
    # wf-recorder is running, so stop it
    pkill wf-recorder
    notify-send "Recording stopped"
else
    # wf-recorder not running, so start recording
    wf-recorder -f "$OUTPUT" &
    notify-send "Recording started"
fi
