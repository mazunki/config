#!/bin/zsh
# Read on every interactive session

source ${ZDOTDIR}/history.zsh
source ${ZDOTDIR}/autocomplete.zsh
source ${ZDOTDIR}/opts.zsh
source ${ZDOTDIR}/bindings.zsh
#source ${ZDOTDIR}/cdalias.zsh

#export ZSH_PLUGIN_HOME=${XDG_DATA_HOME}/zsh/plugins
#source ${ZSH_PLUGIN_HOME}/zsh-syntax-highlighting
source ${ZDOTDIR}/plugins/zsh-vimode-visual/zsh-vimode-visual.zsh
zle_highlight=(region:br=yellow)

source ${ZDOTDIR}/prompt.zsh  # depends on zsh-syntax-highlighting
zle-line-pre-redraw() {
  [[ $KEYMAP != vicmd ]] && return
  local new="$RPS1"
  if (( REGION_ACTIVE )); then
    new="(VIS)"
  else
    new="(CMD)"
  fi
  if [[ $new != $RPS1 ]]; then
   RPS1="$new"
   zle .reset-prompt
  fi
}
zle -N zle-line-pre-redraw

eval "$(dircolors -b ${XDG_CONFIG_HOME}/dircolors)"

