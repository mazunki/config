#!/bin/zsh

ZDOTDIR=${ZDOTDIR:-$confdir/zsh}
function zshloadplugs() {
	verbose=1
	source $ZDOTDIR/$1.zsh && [ $verbose -eq "1" ] && echo "Loaded $1.zsh" || return 0
}


function zshreloadconf() {
	verbose=1
	source ${XDG_CONFIG_HOME:-$HOME/.config}/$1 && [ $verbose -eq "1" ] && echo "Loaded $1" || return 0
}

zshreloadconf aliases
zshreloadconf environment

zshloadplugs history
zshloadplugs autocomplete
zshloadplugs opts
zshloadplugs bindings
zshloadplugs cdalias

export ZSH_PLUGIN_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins
source ${ZSH_PLUGIN_HOME}/zsh-syntax-highlighting

zshloadplugs prompt  # depends on zsh-snytax-highlighting

eval "$(dircolors -b ${XDG_CONFIG_HOME:-$HOME/.config}/dircolors)"
