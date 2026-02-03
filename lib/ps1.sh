#!/bin/bash
set_ps1(){
	PS1="DBMS > "
}

set_db_ps1(){
	local db_name="$1"
	PS1="DBMS[$db_name] > "
}

reset_ps1(){
	PS1="$DEFAULT_PS1"
}
