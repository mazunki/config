GIT_BRANCH() {
  git branch 2>/dev/null | grep '^*' | colrm 1 2
}


use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.	
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM

match_lhs=""
[[ -f ~/gits/mybash/dotfiles/.dircolors   ]] && match_lhs="${match_lhs}$(<~/gits/mybash/dotfiles/.dircolors)"
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

RESTORE=$(echo -en '\001\033[0m\002')
RED=$(echo -en '\001\033[00;31m\002')
GREEN=$(echo -en '\001\033[00;32m\002')
YELLOW=$(echo -en '\001\033[00;33m\002')
BLUE=$(echo -en '\001\033[00;34m\002')
MAGENTA=$(echo -en '\001\033[00;35m\002')
PURPLE=$(echo -en '\001\033[00;35m\002')
CYAN=$(echo -en '\001\033[00;36m\002')
LIGHTGRAY=$(echo -en '\001\033[00;37m\002')
LRED=$(echo -en '\001\033[01;31m\002')
LGREEN=$(echo -en '\001\033[01;32m\002')
LYELLOW=$(echo -en '\001\033[01;33m\002')
LBLUE=$(echo -en '\001\033[01;34m\002')
LMAGENTA=$(echo -en '\001\033[01;35m\002')
LPURPLE=$(echo -en '\001\033[01;35m\002')
LCYAN=$(echo -en '\001\033[01;36m\002')
WHITE=$(echo -en '\001\033[01;37m\002')


if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f ~/gits/mybash/dotfiles/.dircolors ]] ; then
			eval $(dircolors -b ~/gits/mybash/dotfiles/.dircolors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ $(hostname) =~ "mazunki" ]]; then
		# echo "I am home!";
		if [[ ${EUID} == 0 ]]; then
			PS1='\$(GIT_BRANCH)${LRED}[$(whoami)${LRED} \W\${LRED}]\#${RESTORE} '
		else
			PS1='\${GIT_BRANCH}${LGREEN}[~:${WHITE}\W${LGREEN}] >${RESTORE} '
		fi

	else
		if [[ ${EUID} == 0 ]] ; then
			PS1='${LGREEN}[$(whoami)${LRED}]\$${RESTORE} '
		else
			PS1='${LGREEN}[\u@\h${WHITE} \W${LGREEN}]\$${RESTORE} '
		fi
	fi



else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1