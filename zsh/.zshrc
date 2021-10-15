#!/bin/zsh
# Read on every interactive session

source ${ZDOTDIR}/history.zsh
source ${ZDOTDIR}/autocomplete.zsh
source ${ZDOTDIR}/opts.zsh
source ${ZDOTDIR}/bindings.zsh
#source ${ZDOTDIR}/cdalias.zsh

#export ZSH_PLUGIN_HOME=${XDG_DATA_HOME}/zsh/plugins
#source ${ZSH_PLUGIN_HOME}/zsh-syntax-highlighting

source ${ZDOTDIR}/prompt.zsh  # depends on zsh-syntax-highlighting

eval "$(dircolors -b ${XDG_CONFIG_HOME}/dircolors)"

