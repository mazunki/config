#!/bin/zsh

export HISTFILE="${XDG_STATE_HOME:?history.zsh: no state home found}/zsh/history"
export HISTSIZE=2147483647  # /usr/include/limits.h assuming 32bit. should be nuf lolol
export SAVEHIST="${HISTSIZE}"
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

mkdir -p "${HISTFILE%/*}"
touch "${HISTFILE%/*}"/{dirs,history}

# loads push/popd history through the xdg_state_home/zsh/dirs file
if [ -e "${XDG_STATE_HOME:-$HOME/.local/state}/zsh/dirs" ]; then
	dirs "$(uniq "${XDG_STATE_HOME:-$HOME/.local/state}/zsh/dirs")" >&-
fi 

