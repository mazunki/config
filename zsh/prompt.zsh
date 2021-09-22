#!/bin/zsh

autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst

add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

export NEWLINE=$'\n'
rightarrow=$(echo -en '\u27f6')
export PROMPT2="%F{239} ${rightarrow}  %f"
export PROMPT='%F{95}[%?]%f %F{28}%n%f@%F{126}%m%f:%B%F{69}%~%f%b ${vcs_info_msg_0_} ${NEWLINE}${PROMPT2}'

