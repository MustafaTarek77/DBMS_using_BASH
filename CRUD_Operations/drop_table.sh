#!/bin/bash

read -p "Enter table name to drop: " table

dataFile="$HOME/Desktop/DBMS/Tables/Data/$table.data"
metaFile="$HOME/Desktop/DBMS/Tables/Metadata/$table.meta"

# Check if table exists
if [[ ! -f "$metaFile" ]]; then
    echo "Table '$table' does not exist."
    exit 1
fi

# Delete files
rm -f "$metaFile" "$dataFile"

echo "Table '$table' deleted successfully."
