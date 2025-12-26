#!/bin/bash

DB_NAME="$1"
META_DIR="db_storage/$DB_NAME/tables_meta"

# Validate database name
if [[ -z "$DB_NAME" ]]; then
    echo "ERROR: Database name is required"
    exit 1
fi

# Check if tables_meta directory exists
if [[ ! -d "$META_DIR" ]]; then
    echo "No tables directory found for database '$DB_NAME'"
    exit 1
fi

echo "Tables in database '$DB_NAME':"

found=0
for file in "$META_DIR"/*.meta; do
    [[ -e "$file" ]] || continue
    basename "$file" .meta
    found=1
done

if [[ $found -eq 0 ]]; then
    echo "No tables found."
fi
