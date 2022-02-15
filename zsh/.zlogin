#!/bin/zsh
# Read after zshrc, in login shells

source /home/mazunki/.config/xdg_paths
source /home/mazunki/.config/environment
[ "$(tty)" = "/dev/tty1" ] && doas rc-service mazunki-s6 start

