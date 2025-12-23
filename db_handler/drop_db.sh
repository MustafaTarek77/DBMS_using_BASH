#!/bin/bash

DB_NAME="$1"
DBS_META="databases.meta"
DB_PATH="db_storage/$DB_NAME"

if [[ -z "$DB_NAME" ]]; then
    echo "ERROR: Database name is required"
    exit 1
fi

if ! grep -q "^$DB_NAME:" "$DBS_META"; then
    echo "ERROR: Database '$DB_NAME' does not exist"
    exit 1
fi

sed -i "/^$DB_NAME:/d" "$DBS_META"


if [[ -d "$DB_PATH" ]]; then
    rm -rf "$DB_PATH"
fi


echo "Database '$DB_NAME' dropped successfully"
