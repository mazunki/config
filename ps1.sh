tuse_color=true

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

export motd='printf "\nWelcome, ${LGREEN}$(whoami)! \n${WHITE} — You are connected to ${LYELLOW}\t$(hostname)${WHITE}.\n — Your IP is \t\t\t${LYELLOW}$(curl -s ipinfo.io/ip).${RESTORE}\n"'

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
			echo ${motd} | sh
			PS1='$(stipledline)[$?]$(GET_BRANCH)${LRED}[$(whoami)${LRED} \W\${LRED}]# ${RESTORE}'
		else
			echo ${motd} | sh
			PS1='$(stipledline)[$?]$(GET_BRANCH)${LGREEN}[~:${WHITE}\W${LGREEN}] >${RESTORE} '
		fi

	else
		if [[ ${EUID} == 0 ]] ; then
			echo $motd | sh
			PS1='${LRED}[\u@\h${WHITE} \W${LRED}]\$${RESTORE} '
		else
			if [[ $(whoami) =~ "mazunki" ]]; then
				echo $motd | sh
				PS1='${LINE}[$?]$(GET_BRANCH)${LGREEN}[~${LYELLOW}@\h${WHITE}:\W${LGREEN}]> ${RESTORE}'
			else
				echo $motd | sh
				PS1='${LINE}[$?]$(GET_BRANCH)${LGREEN}[\u${LYELLOW}@\h${WHITE}:\W${LGREEN}]# ${RESTORE}'
			fi
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

