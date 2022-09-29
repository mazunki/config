#!/bin/zsh

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

