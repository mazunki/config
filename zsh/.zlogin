#!/bin/zsh

# if [ -z "$TMUX" ]; then
# 	test -n "${SSH_TTY}" && return
# 	if [ "$(command -v tmux)" != "" ]; then
# 		exec tmux new -s login
# 	fi
# fi


sshfs -o follow_symlinks kitten:/srv/users/mazunki ~/@kitten &

