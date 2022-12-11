#!/bin/zsh
# Read on every interactive session

echo "Sourcing zshrc"
source /home/mazunki/.config/xdg_paths
source /home/mazunki/.config/environment

export ZSH_PLUGIN_HOME=${XDG_DATA_HOME}/zsh/plugins

source ${ZDOTDIR}/history.zsh
source ${ZDOTDIR}/autocomplete.zsh
source ${ZDOTDIR}/opts.zsh
source ${ZDOTDIR}/bindings.zsh
source ${ZDOTDIR}/conda.zsh
source ${ZDOTDIR}/prompt.zsh
source ${ZDOTDIR}/.zshexit

eval "$(dircolors -b ${XDG_CONFIG_HOME}/dircolors)"

# source /home/mazunki/.config/wl-environment


alias luamake=/home/mazunki/.local/src/proj/lua-lsp/luamake/luamake

