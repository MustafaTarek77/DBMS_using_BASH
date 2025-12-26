#!/bin/bash

DB_NAME="$1"
DB_PATH="db_storage/$DB_NAME"

if [[ -z "$DB_NAME" ]]; then
    echo "ERROR: Database name is required"
    exit 1
fi

if [[ ! -d "$DB_PATH" ]]; then
    echo "ERROR: Database '$DB_NAME' does not exist"
    exit 1
fi


echo "Connected to database '$DB_NAME'"
chmod +x ./table_menu.sh
./table_menu.sh "$DB_NAME"





