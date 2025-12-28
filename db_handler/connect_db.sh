#!/bin/bash

source ./utils/validations.sh
DB_NAME="$1"
DB_PATH="db_storage/$DB_NAME"

is_non_empty "$DB_NAME"
is_db_exists "$DB_NAME"

echo "Connected to database '$DB_NAME'"
chmod +x ./table_menu.sh
./table_menu.sh "$DB_NAME"

