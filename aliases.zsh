#!/bin/zsh
hi () {
	emulate -L zsh

	argv=(${argv:/-s/-S})
	argv=(${argv:/-l/-S})

	autoload -U colors && colors
	for file do
		echoti setaf 247
		printf "%*s\n" "$(( ${COLUMNS:-$(tput cols)} - 6))" '' | sed 's/ /▁/g'
		printf '%s %s\n' '▏' "${file}"
		printf "%*s\n" "$(( ${COLUMNS:-$(tput cols)} - 6))" '' | sed 's/ /▔/g'
		highlight -O truecolor --force --stdout "$file"
	done
}

# cd() {
# 	if [ $# -eq 0 ]; then builtin cd; fi
# 
# 	if [ $# -eq 2 ] && [ "$1" = "-e" ]; then
# 		set -- "$(equery w "$2")"
# 	fi
# 
# 	if [ $# -eq 1 ] && test -f "${@[-1]}"; then
# 		set -- "${@[-1]:h}"
# 	fi
# 
# 	builtin cd "${@}"
# }

# vim: ts=4 sts=4 sw=4 noexpandtab

