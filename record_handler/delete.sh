#!/bin/bash

DB_NAME="$1"
read -p "Enter table name: " table

dataFile="db_storage/$DB_NAME/tables_data/$table.data"
metaFile="db_storage/$DB_NAME/tables_meta/$table.meta"

if [[ ! -f "$metaFile" ]]; then
    echo "Table '$table' does not exist."
    exit 1
fi

read -p "Enter column name to delete by: " field

# Get column index
col_index=$(awk -F: -v col="$field" '
NR==1 {
    for (i=1; i<=NF; i++)
        if ($i == col) print i
}' "$metaFile")

if [[ -z "$col_index" ]]; then
    echo "Column does not exist"
    exit 1
fi

read -p "Enter value to match: " value

# Get datatype
col_type=$(awk -F: -v idx="$col_index" 'NR==2 {print $idx}' "$metaFile")

# Datatype validation
if [[ "$col_type" == "int" && ! "$value" =~ ^[0-9]+$ ]]; then
    echo "Invalid value: expected integer"
    exit 1
fi

# Check record exists
exists=$(awk -F"|" -v idx="$col_index" -v val="$value" '$idx==val {c++} END{print c}' "$dataFile")

if [[ "$exists" -eq 0 ]]; then
    echo "No matching records found"
    exit 1
fi

# Delete records
awk -F"|" -v idx="$col_index" -v val="$value" '$idx != val' "$dataFile" > /tmp/tmpfile && mv /tmp/tmpfile "$dataFile"

echo "$exists record(s) deleted successfully"
