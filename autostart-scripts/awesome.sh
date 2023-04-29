#!/bin/env bash

# Killing Of Programs
killall -q picom & 
killall -q mpd & 
killall -q sxhkd &
killall -q solaar &
killall -q greenclip &

# Starting Programs
sleep 1 && picom &
lxpolkit &
sxhkd &
mpd &
greenclip daemon &
solaar -w hide &

# Wallpapers
# find ~/Pictures/Wallpapers/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# ~/.fehbg &
 feh --randomize --bg-fill ~/Pictures/Wallpapers/ &
# nitrogen --restore &
# nitrogen --random ~/Pictures/Wallpapers/ &

