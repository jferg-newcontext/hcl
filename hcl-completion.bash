#!/usr/bin/env bash

HCLPATH='/home/jferg/.rvm/gems/ruby-2.5.5/bin/hcl'

_dothis_completions()
{
	if [ "${#COMP_WORDS[@]}" = "2" ]; then
		COMPREPLY=($(compgen -W "tasks alias unalias aliases start note stop log resume cancel oops nvm show config status" "${COMP_WORDS[1]}"))
	elif [ "${#COMP_WORDS[@]}" = "3" ]; then
		case "${COMP_WORDS[1]}" in
			"unalias" | "log" | "start" )
				ALIASES=$($HCLPATH aliases | sed s/,//g)
				COMPREPLY=($(compgen -W "$ALIASES" "${COMP_WORDS[2]}"))
			;;
			"tasks" | "aliases" | "cancel" | "oops" | "nvm" | "config" | "status" | "note" | "stop" ) 
				COMPREPLY=''
			;; 
			"show" )
				TODAY=$(date +"%Y/%m/%d")
				PREV_MONTH=$(for i in {1..31}; do echo $(date -I -d "$TODAY -$i days"); done)
				DATES="today yesterday monday tuesday wednesday thursday friday saturday"
				COMPREPLY=($(compgen -W "$DATES $PREV_MONTH" "${COMP_WORDS[2]}"))
			;;
			*)
				COMPREPLY=''
			;;

		esac
	fi
}

complete -F _dothis_completions hcl

