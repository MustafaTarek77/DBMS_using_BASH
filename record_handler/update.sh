#!/bin/bash

DB_NAME="$1"
read -p "Enter table name: " table

dataFile="db_storage/$DB_NAME/tables_data/$table.data"
metaFile="db_storage/$DB_NAME/tables_meta/$table.meta"

if [[ ! -f "$metaFile" ]]; then
    echo "Table '$table' does not exist."
    exit 1
fi

# --- Filter (WHERE) ---
read -p "Enter column name to filter by (WHERE): " filter_field

# Get filter column index
filter_idx=$(awk -F: -v col="$filter_field" 'NR==1 {for(i=1;i<=NF;i++) if($i==col) print i}' "$metaFile")

if [[ -z "$filter_idx" ]]; then
    echo "Column does not exist"
    exit 1
fi

read -p "Enter value to match: " filter_value

# Validate datatype
filter_type=$(awk -F: -v idx="$filter_idx" 'NR==2 {print $idx}' "$metaFile")
if [[ "$filter_type" == "int" && ! "$filter_value" =~ ^[0-9]+$ ]]; then
    echo "Invalid value: expected integer"
    exit 1
fi

# Check if records exist
exists=$(awk -F"|" -v idx="$filter_idx" -v val="$filter_value" '$idx==val{c++} END{print c}' "$dataFile")
if [[ "$exists" -eq 0 ]]; then
    echo "No matching records found"
    exit 1
fi

# --- Update target ---
read -p "Enter column name to update: " update_field

# Get update column index
update_idx=$(awk -F: -v col="$update_field" 'NR==1 {for(i=1;i<=NF;i++) if($i==col) print i}' "$metaFile")

if [[ -z "$update_idx" ]]; then
    echo "Column does not exist"
    exit 1
fi

read -p "Enter new value: " new_value

# Validate datatype
update_type=$(awk -F: -v idx="$update_idx" 'NR==2 {print $idx}' "$metaFile")
if [[ "$update_type" == "int" && ! "$new_value" =~ ^[0-9]+$ ]]; then
    echo "Invalid value: expected integer"
    exit 1
fi

# Perform update
awk -F"|" -v fidx="$filter_idx" -v fval="$filter_value" -v uidx="$update_idx" -v uval="$new_value" '
BEGIN{OFS="|"}
{
    if($fidx==fval) $uidx=uval
    print
}' "$dataFile" > /tmp/tmpfile && mv /tmp/tmpfile "$dataFile"

echo "$exists record(s) updated successfully"
