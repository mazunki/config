#!/bin/zsh

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
function format_hostname() {
	if [ -z "$SSH_TTY" ]; then
		hostname_str=''
	else
		hostname_str="@ %F{127}%m%f"
	fi
}
function format_exit_code() {
	_exit_code_last_cmd=$?
	if [[ "${_was_empty}" == "1" ]]; then
		exit_code_str=''
		unset _was_empty
	elif [[ "${_exit_code_last_cmd}" == 0 ]]; then
		exit_code_str=''
	else
		exit_code_str="[%F{196}${_exit_code_last_cmd}%f] "
		return
		case "${_exit_code_last_cmd}" in
			1)
				_exit_code_last_cmd='error' ;;
			2)
				_exit_code_last_cmd='invalid' ;;
			126)
				_exit_code_last_cmd='noexec' ;;
			127)
				_exit_code_last_cmd='not found' ;;
			130)
				_exit_code_last_cmd='^C' ;;
			143)
				_exit_code_last_cmd='󰚌' ;;
		esac
		exit_code_str="[%F{196}${_exit_code_last_cmd}%f] "
	fi
}
function reset_exitcode_on_empty() {
	if [[ -z "$BUFFER" ]]; then
		_was_empty=1
	fi

	zle .accept-line
}
zle -N accept-line reset_exitcode_on_empty
add-zsh-hook precmd format_exit_code

add-zsh-hook precmd format_hostname
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
# if test "${PS1}" != ""; then
	#export PS1="${PS1}"
# elif test "${PROMPT}" = ""; then
# else
	export PROMPT='$exit_code_str${vcs_info_msg_0_}%F{69}%~%f $hostname_str${NEWLINE}'
#fi
zle_highlight=(default:bold,fg=127)

precmd() {
	print -Pn "\e]2;%~\a"
}

# function zle-keymap-select zle-line-init
# {
#     case $KEYMAP in
#         vicmd) printf "\e[1 q" ;;  	# block cursor
#         viins|main) printf "\e[5 q" ;;  # line cursor
#     esac
# 
#     zle reset-prompt
#     zle -R
# }
# 
# function zle-line-finish
# {
#     print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
# }
# 
# zle -N zle-line-init
# zle -N zle-line-finish
# zle -N zle-keymap-select


