#!/bin/zsh

confdir=${XDG_CONFIG_HOME:-$HOME/.config}

source $ZDOTDIR/history.zsh
source $ZDOTDIR/autocomplete.zsh
source $ZDOTDIR/opts.zsh
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/bindings.zsh

source $confdir/aliases
source $confdir/environment

eval "$(dircolors -b $confdir/dircolors)"
