#!/bin/bash

msg=$(fortune)

dunstify -u low "Remnants of Wisdom" "$msg"
