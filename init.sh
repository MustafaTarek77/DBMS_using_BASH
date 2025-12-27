#!/bin/bash

mkdir -p db_storage
mkdir -p db_handler
mkdir -p table_handler
touch databases.meta


for script in \
    "db_handler/create_db.sh" \
    "db_handler/list_db.sh" \
    "db_handler/connect_db.sh" \
    "db_handler/drop_db.sh" \
    "table_handler/create_table.sh" \
    "table_handler/list_tables.sh" \
    "table_handler/drop_table.sh" \
    "record_handler/insert.sh" \
    "record_handler/select.sh" \
    "record_handler/delete.sh" \
    "record_handler/update.sh";
do
    file="./$script"

    if [[ ! -f "$file" ]]; then
        echo "ERROR: Missing handler: $file"
        exit 1
    fi

    if [[ ! -x "$file" ]]; then
        chmod +x "$file"
    fi
done


echo "Database Engine initialized successfully ✅"


