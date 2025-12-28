#!/bin/bash

read -p "Enter Table Name: " table

while [[ ! "$table" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; do
    echo "ERROR: Invalid table name"
    read -p "Enter Table Name: " table
done

DB_NAME="$1"
dataFile="db_storage/$DB_NAME/tables_data/$table.data"
metaFile="db_storage/$DB_NAME/tables_meta/$table.meta"

# Check if table already exists
if [[ -f "$metaFile" ]]; then
    echo "Table already exists"
    exit 1
fi

# Prompt for number of columns until a valid positive integer is entered
while true; do
    read -p "Number of columns: " cols
    if [[ "$cols" =~ ^[1-9][0-9]*$ ]]; then
        break
    fi
    echo "Error: enter a valid positive number (>=1)"
done

schema=""
types=""
pk=""

for ((i=1; i<=cols; i++)); do
    # Prompt for a valid, non-duplicate column name
    while true; do
        read -p "Column $i name: " col
        if [[ ! "$col" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
            echo "Invalid column name. Use letters, numbers and underscores, not starting with a digit."
            continue
        fi
        if [[ "$schema" == *"$col:"* ]]; then
            echo "Column '$col' already defined. Choose a different name."
            continue
        fi
        break
    done

    # Loop until user enters a valid datatype
    while true
    do
        read -p "Datatype (int/string): " type
        type=$(echo "$type" | tr '[:upper:]' '[:lower:]')  # convert to lowercase
        if [[ "$type" == "int" || "$type" == "string" ]]; then
            break
        else
            echo "Invalid datatype! Please enter 'int' or 'string'."
        fi
    done

    # Set primary key as first column
    if [[ $i -eq 1 ]]; then
        pk=$col
    fi

    schema+="$col:"
    types+="$type:"
done


# Write metadata
echo "${schema%:}" > "$metaFile"
echo "${types%:}" >> "$metaFile"
echo "PK=$pk" >> "$metaFile"

# Create empty data file
touch "$dataFile"

echo "Table '$table' created successfully"
