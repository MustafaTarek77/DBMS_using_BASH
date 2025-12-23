#!/bin/bash

read -p "Enter Table Name: " table

dataFile="db_storage/test/tables_data/$table.data"
metaFile="db_storage/test/tables_meta/$table.meta"

# Check if table already exists
if [[ -f "$metaFile" ]]; then
    echo "Table already exists"
    exit 1
fi

read -p "Number of columns: " cols
if [[ ! "$cols" =~ ^[0-9]+$ ]]; then
    echo "Error, enter a valid number"
    exit 1
fi

schema=""
types=""
pk=""

for ((i=1; i<=cols; i++)); do
    read -p "Column $i name: " col

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
