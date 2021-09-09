#!/bin/zsh

autoload -U compinit promptinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcatche
setopt COMPLETE_IN_WORD
setopt MENU_COMPLETE
setopt LIST_ROWS_FIRST

