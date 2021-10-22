#!/bin/zsh
# printcolors is nice

autoload -Uz add-zsh-hook vcs_info
setopt PROMPT_SUBST

function check_if_git_behind() {
	git status -sb 2> /dev/null | grep -s 'behind' 2>&1 > /dev/null
	if [ "$?" -ne "0" ]; then
		GIT_BEHIND_STR=''
	else
		GIT_BEHIND_STR="%F{124}●%f"
	fi
	RPROMPT="$GIT_BEHIND_STR"
}
function format_exit_code() {
	if [[ "$?" == "0" ]]; then
		exit_code_str=''
	else
		exit_code_str="[%F{196}$?%f] "
	fi
}
function format_exit_code() {
	if [ -z "$SSH_TTY" ]; then
		hostname_str='@local'
	else
		hostname_str="%F{196}%m%f"
	fi
}
typeset -a precmd_functions
precmd_functions+=(check_if_git_behind)
precmd_functions+=(format_exit_code)
precmd_functions+=(format_hostname)


add-zsh-hook precmd vcs_info
# %b is branch, %u is unstagedstr, %c is staged
zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:*' unstagedstr '%F{208}●%f'
#zstyle ':vcs_info:*' stagedstr '%F{034}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{196}'
zstyle ':vcs_info:*' stagedstr '%F{226}'
zstyle ':vcs_info:*' behindstr '%F{124}!!%f'

zstyle ':vcs_info:git:*' formats       '(%F{046}%c%u%b%f%f) '
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c) '

export NEWLINE=$'\n'
rightarrow=$(echo -en '\u27f6')
export PROMPT='$exit_code_str${vcs_info_msg_0_}%F{69}%~%f $hostname_str${NEWLINE}'
