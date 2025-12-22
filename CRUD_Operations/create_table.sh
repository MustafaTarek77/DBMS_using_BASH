#!/bin/bash

read -p "Enter Table Name: " table

dataFile="$HOME/Desktop/DBMS/Tables/Data/$table.data"
metaFile="$HOME/Desktop/DBMS/Tables/Metadata/$table.meta"

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
    read -p "Datatype (int/string): " type

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
