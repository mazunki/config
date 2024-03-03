#!/bin/zsh
# echo "Sourcing bindings"
bindkey "^k" kill-whole-line
bindkey '^h' backward-word
bindkey '^l' forward-word

bindkey '^?' backward-delete-char
bindkey "${terminfo[kdch1]}" delete-char

# these are necessary because vi mode overrides them in normal mode
bindkey '^R' history-incremental-search-backward 
bindkey '^S' history-incremental-search-forward

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

bindkey '^[[1;5D' backward-word # ctrl+left
bindkey '^[[1;5C' forward-word # ctrl+right

# start by killing line, in case it wasn't empty
bindkey -s '^[[1;5B' "^kcd -\n"  # ctrl+down
bindkey -s '^[[1;5A' "^kcd ..\n"  # ctrl+up

#
# vi mode :)
# 
autoload -z edit-command-line
zle -N edit-command-line

bindkey -M vicmd 'v' edit-command-line  # open $EDITOR to edit. :wq to complete
bindkey -M vicmd "${terminfo[kdch1]}" delete-char  # makes <del> button act like x
bindkey -M vicmd "/" history-search-backward  # searches whatever you had typed in insert mode in the history
bindkey -M vicmd -s "!" 'I$(^[[1;A)^[[1;0'  # turns the whole line into a $(...), putting the cursor at the beginning of the line

copy-line() {
	printf "%s" "$BUFFER" | wl-copy -t text/plain
}
paste-post() {
	RBUFFER+="$(wl-paste)"
}
paste-pre() {
	LBUFFER+="$(wl-paste)"
}

zle -N copy-line
zle -N paste-post
zle -N paste-pre

bindkey -M vicmd 'y' copy-line
bindkey -M vicmd 'P' paste-pre
bindkey -M vicmd 'p' paste-post


