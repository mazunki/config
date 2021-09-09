#!/bin/zsh
bindkey "^K" kill-whole-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^?' backward-delete-char
bindkey "${terminfo[kdch1]}" delete-char
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey '^A' beginning-of-line
bindkey '\e[F' end-of-line

