#!/bin/zsh
export NEWLINE=$'\n'
rightarrow=$(echo -en '\u27f6')
export PROMPT2="%F{239} ${rightarrow}  %f"
export PROMPT="%F{95}[%?]%f %F{28}%n%f@%F{126}%m%f:%B%F{69}%~%f%b${NEWLINE}${PROMPT2}"

