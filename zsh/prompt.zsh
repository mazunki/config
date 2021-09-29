#!/bin/zsh
# printcolors is nice

autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst

function check_if_git_behind() {
	git status -sb 2> /dev/null | grep -s 'behind' 2>&1 > /dev/null
	if [ "$?" -ne "0" ]; then
		GIT_BEHIND_STR=''
	else
		GIT_BEHIND_STR="%F{124}●%f"
	fi
	RPROMPT="$GIT_BEHIND_STR"
}
typeset -a precmd_functions
precmd_functions+=(check_if_git_behind)


add-zsh-hook precmd vcs_info
# %b is branch, %u is unstagedstr, %c is staged
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{208}●%f'
zstyle ':vcs_info:*' stagedstr '%F{034}●%f'
zstyle ':vcs_info:*' behindstr '%F{124}%f'

zstyle ':vcs_info:git:*' formats       '(%b%u%c) '
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c) '

export NEWLINE=$'\n'
rightarrow=$(echo -en '\u27f6')
export PROMPT2="%F{239}${rightarrow}%f"
export PROMPT='${vcs_info_msg_0_}%B%F{69}%~%f%b${NEWLINE}'
export RPROMPT='%F{95}[%?]%f %F{126}%m%f'
