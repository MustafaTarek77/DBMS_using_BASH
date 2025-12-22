#!/bin/bash

DB_NAME="$1"
DB_PATH="db_storage/$DB_NAME"
CATALOG="catalog/databases.meta"

if [[ -z "$DB_NAME" ]]; then
    echo "Error: Database name is required"
    exit 1
fi

if [[ ! "$DB_NAME" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
    echo "ERROR: Invalid database name"
    exit 1
fi

if [[ -d "$DB_PATH" ]]; then
    echo "ERROR: Database already exists"
    exit 1
fi

mkdir -p "$DB_PATH/tables" || {
    echo "ERROR: Failed to create database directory"
    exit 1
}

cat > "$DB_PATH/db.meta" <<EOF
name=$DB_NAME
created_at=$(date +"%Y-%m-%d %H:%M:%S")
EOF

echo "$DB_NAME" >> "$CATALOG"

echo "Database '$DB_NAME' created successfully"
