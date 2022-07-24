#!/bin/zsh

export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export HISTSIZE=2147483647  # /usr/include/limits.h assuming 32bit. should be nuf lolol
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

