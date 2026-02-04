validate_db_name() {
    	local name="$1"
    	if [[ -z "$name" ]]; then
       		echo "Database name cannot be empty"
        	return 1
    	fi
   	if [[ "$name" =~ [[:space:]] ]]; then
        	echo "Database name cannot contain spaces"
        	return 1
    	fi

    	if [[ ! "$name" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
        	echo "Wrong database name. It must start with a letter and contain only letters, numbers, underscores"
        	return 1
    	fi	

	return 0
}

validate_no_spaces() {
	local name="$1"
    	if [[ "$name" =~ [[:space:]] ]]; then
        	echo "Name cannot contain spaces"
        	return 1
    	fi

    	return 0
}
