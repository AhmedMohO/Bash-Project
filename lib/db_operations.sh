list_databases() {
    echo "===== List of Databases ====="
    db_count=$(find "$DB_DIR" -maxdepth 1 -type d ! -path "$DB_DIR" | wc -l)
    if [[ "$db_count" -eq 0 ]]; then
        echo "No databases found"
        return 1
    fi

    find "$DB_DIR" -maxdepth 1 -type d ! -path "$DB_DIR" | while read db; do
        db_name=$(basename "$db")
        echo "- $db_name"
    done
}

drop_database() {
    if ! list_databases 
    then
   	 return
    fi
    while true; do
	read -p "Enter database name you want to drop: " db_name
	if [[ "${db_name,,}" == "exit" ]]; then
            echo "Exiting database deletion."	
	    return
	fi
    	db_path="$DB_DIR/$db_name"
    	if [[ ! -d "$db_path" ]]; then
        	echo "Database $db_name does not exist"
        	continue
    	fi

    	read -p "Are you sure you want to drop database $db_name? [Y/N]: " confirm
    	if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        	echo "Deletion cancelled"
        	return
    	fi

    	rm -rf "$db_path" || {
        	echo "Failed to delete $db_name check permissions"
        	return
    	}
    	echo "Database $db_name dropped successfully"
    	break
    done
}

create_database() {
    while true
    do
        read -p "Enter database name: " db_name
        db_name="${db_name// /}"
        if [[ -z "$db_name" ]]; then
            echo "Database name cannot be empty"
            continue
        fi

        if [[ ! "$db_name" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
            echo "Must start with a letter and contain only letters, numbers, or underscores"
            continue
        fi

        db_path="$DB_DIR/$db_name"
        if [[ -e "$db_path" ]]; then
            echo "A database or file named $db_name already exists"
            continue
        fi

        mkdir -p "$db_path" || {
            echo "Failed to create database '$db_name' check permissions"
            continue
        }

        echo "Database $db_name created successfully"
        break
    done
}



