#!/bin/zsh

if [ -z "$TMUX" ]; then
	if [ "$(command -v tmux)" != "" ]; then
		exec tmux
	fi
fi

