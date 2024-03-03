#!/bin/zsh
# .zshrc

typeset -a subconfs
subconfs=( 'prompt' 'bindings' 'autocomplete' )
for subconf in ${subconfs[@]}; do
	source "${ZDOTDIR}/${subconf}.zsh"
done

