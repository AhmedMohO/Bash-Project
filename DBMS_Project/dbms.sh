#!/bin/bash
DB_DIR="./databases"
CONNECTED_DB=""
DEFAULT_PS1="$PS1"

source ./lib/env.sh
source ./lib/ps1.sh
source ./lib/db_operations.sh
source ./lib/validations.sh
init_env
set_ps1

exitClean(){
    reset_ps1
}

trap exitClean EXIT

while true
do
	echo "========================================"
        echo "1) Create Database"
        echo "2) List Database"
        echo "3) Connect To Database"
        echo "4) Drop Database"
        echo "5) Exit"
        read -p "Please Select From The Above: " input
        case "$input" in
                1)
                  	create_database      
                        ;;
                2)
                        list_databases
                        ;;
                3)
                        connect_database
			;;
                4)
                        drop_database
                        ;;
                5)
                        echo "Exiting..."
                        break
                        ;;
                *)
                        echo "Choice Not Found Select Again"
                        ;;
        esac
done


