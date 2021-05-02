#!/bin/sh

export bg=$(xrdb $XDG_CONFIG_HOME/x11/xresources -query all | grep background | awk '{print $2}')
export fg=$(xrdb $XDG_CONFIG_HOME/x11/xresources -query all | grep foreground | awk '{print $2}')

dunst -lb "$bg" -nb "$bg" -cb "$bg" -lf "$fg" -bf "$fg" -cf "$fg" -nf "$fg" -fn "Fira Code 8" -s -geometry "320x80-8+44" -format "<b>%s</b>\n%b" -separator_height 1 -key "ctrl+space" -all_key "space" -padding 24 -horizontal_padding 24
