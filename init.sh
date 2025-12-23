#!/bin/bash


mkdir -p db_storage
mkdir -p db_handler
mkdir -p catalog
touch catalog/databases.meta


for script in "create_db.sh" "list_db.sh" "connect_db.sh" "drop_db.sh"; do
	file="./db_handler/$script"

    if [[ ! -f "$file" ]]; then
        echo "ERROR: Missing handler: $file"
        exit 1
    fi

    if [[ ! -x "$file" ]]; then
        chmod +x "$file"
    fi
done

echo "Database Engine initialized successfully ✅"


