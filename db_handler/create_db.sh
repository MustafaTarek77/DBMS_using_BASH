#!/bin/bash

YELLOW="\033[1;33m"
NC="\033[0m" # No Color

source ./utils/validations.sh

DB_NAME="$1"
DB_PATH="db_storage/$DB_NAME"
CATALOG="databases.meta"


is_non_empty "$DB_NAME"
is_valid_name "$DB_NAME"

is_db_does_not_exist "$DB_NAME"

# Create database directories
mkdir -p "$DB_PATH/tables_meta" "$DB_PATH/tables_data" || {
    echo "ERROR: Failed to create database structure"
    exit
}

# Register database in catalog
echo "$DB_NAME:$(date +"%Y-%m-%d %H-%M-%S"):$USER" >> "$CATALOG"

echo
echo "-------------------------------------------"
echo -e "Database ${YELLOW}'$DB_NAME'${NC} created successfully"
echo "-------------------------------------------"
echo