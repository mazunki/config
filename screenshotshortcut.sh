#!/usr/bin/env bash
###
#   script designed for budgie-screenshot-applet
#   
#   add this .sh file to a shortcut in order to take screenshots easily,
#   as there is no native way to add screenshots to the app
#   
#   automatically restores mouse position immediately
#
#   to use: change the coordinates of mousemove to your own position
#   get coordinates with:
#      xdotool getmouselocation
###


# we want to store our original mouse position
rawoldmouse=$(xdotool getmouselocation)
mouseoldX=$(echo ${rawoldmouse} | sed "s/ screen.*//g" | cut -d" " -f1 | cut -c 3-)
mouseoldY=$(echo ${rawoldmouse} | sed "s/ screen.*//g" | cut -d" " -f2 | cut -c 3-)

# shortcut to screenshot applet
xdotool mousemove 1894 1099 # x, y of your applet icon
xdotool click 1
xdotool mousemove 1844 1232 # x, y of your screenshot to run
xdotool click 1

# back to where mouse was
xdotool mousemove ${mouseoldX} ${mouseoldY}