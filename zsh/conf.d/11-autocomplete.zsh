#!/bin/zsh

# loads completiosn
fpath=(~/.local/share/zsh/plugins/zsh-completions/src $fpath)
fpath=(~/.local/share/zsh/completions $fpath)

zmodload zsh/complist

autoload -U compinit promptinit; compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

_comp_options+=(globdots)

# speeding up completion with cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

zstyle ':completion:*' menu select  # autocomplete with navigation
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' fuzzy


# :completion:<function>:<completer>:<command>:<argument>:<tag>
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

setopt COMPLETE_IN_WORD # allows tabbing from the start of the word too
# setopt MENU_COMPLETE  # tab once to get first element, instead of twice
setopt LIST_ROWS_FIRST
setopt AUTO_LIST  # in theory resolves ambiuguous listing, not really sure
setopt GLOB_COMPLETE  # allows for globbing in autocomplete


