#!/bin/zsh

export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export HISTZIE=2000
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
