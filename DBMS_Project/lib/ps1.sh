#!/bin/bash
set_ps1(){
	if [[ -n "$CONNECTED_DB" ]]; then
        	PS1="DBMS[$CONNECTED_DB] > "
    	else
        	PS1="$DEFAULT_PS1"
    	fi
}

reset_ps1(){
	PS1="$DEFAULT_PS1"
}
