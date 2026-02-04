#!/bin/bash

init_env(){
	if [[ -d "$DB_DIR" ]]
	then
		return 0
	fi
	if [[ ! -e "$DB_DIR" ]]
	then
		mkdir -p "$DB_DIR" || {
           		echo "Failed to create database directory $DB_DIR"
            		echo "Check permissions"
           	 	exit 1
        	}
        	return 0
	fi
	echo "A file named $DB_DIR already exists and it isn't a directory"
	while true
	do
        	echo "How would you like to proceed?"
        	echo "1) Abort"
        	echo "2) Delete the existing file and create the directory"
        	echo "3) Move the existing file to another location"
        	read -p "Enter choice [1-3]: " choice

        case "$choice" in
            1)
                echo "Aborted"
                exit 1
                ;;

            2)
                rm -f "$DB_DIR" || {
                echo "Error Failed to delete $DB_DIR"
                     exit 1
                }
                mkdir -p "$DB_DIR" || {
                     echo "Failed to create directory after deletion"
                     exit 1
                }
                echo "Directory $DB_DIR created successfully"
                return 0
		;;
            3)
                read -p "Enter destination path to move the file to: " dest
                if [ -z "$dest" ]; then
                    echo "Invalid path"
                    continue
                fi

                mv "$DB_DIR" "$dest" || {
                    echo "Failed to move file try another path"
                    continue
                }

                mkdir -p "$DB_DIR" || {
                    echo "Failed to create directory after move"
                    exit 1
                }

                echo "File moved successfully"
                echo "Directory $DB_DIR created"
                return 0
                ;;

            *)
                echo "Invalid choice"
                ;;
        esac
    done
}
