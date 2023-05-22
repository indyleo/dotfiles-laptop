#!/bin/env bash

# Killing Of Programs
killall -q sxhkd &
killall -q greenclip &

# Starting Programs
picom --experimental-backends &
sxhkd &
lxpolkit &
sleep 1 && greenclip daemon &

# Wallpaper
# find ~/Pictures/Wallpapers/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
xwallpaper --stretch ~/Pictures/Wallpapers/3xsraffkwi1a1.png &
