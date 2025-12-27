#!/bin/bash

read -p "Enter table name to drop: " table

DB_NAME="$1"
dataFile="db_storage/$DB_NAME/tables_data/$table.data"
metaFile="db_storage/$DB_NAME/tables_meta/$table.meta"
echo $metaFile


# Check if table exists
if [[ ! -f "$metaFile" ]]; then
    echo "Table '$table' does not exist."
    exit 1
fi

# Delete files
rm -f "$metaFile" "$dataFile"

echo "Table '$table' deleted successfully."
