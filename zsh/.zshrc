#!/bin/zsh
# Read on every interactive session

# source /home/mazunki/.config/xdg_paths
# source /home/mazunki/.config/environment
echo "Sourcing zshrc"

source ${ZDOTDIR}/history.zsh
source ${ZDOTDIR}/autocomplete.zsh
source ${ZDOTDIR}/opts.zsh
source ${ZDOTDIR}/bindings.zsh
#source ${ZDOTDIR}/cdalias.zsh
setopt auto_pushd

if [ -e "${XDG_STATE_HOME:-$HOME/.local/state}/zsh/dirs" ]; then
	dirs $(uniq "${XDG_STATE_HOME:-$HOME/.local/state}/zsh/dirs")
fi 

source ${ZDOTDIR}/.zshexit

#export ZSH_PLUGIN_HOME=${XDG_DATA_HOME}/zsh/plugins
#source ${ZSH_PLUGIN_HOME}/zsh-syntax-highlighting

source ${ZDOTDIR}/prompt.zsh  # depends on zsh-syntax-highlighting

eval "$(dircolors -b ${XDG_CONFIG_HOME}/dircolors)"

# source /home/mazunki/.config/wl-environment

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mazunki/.local/share/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mazunki/.local/share/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mazunki/.local/share/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mazunki/.local/share/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

