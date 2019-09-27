
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

complete -cf sudo
bind "set completion-ignore-case on"
