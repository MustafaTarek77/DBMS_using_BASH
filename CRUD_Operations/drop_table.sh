#!/bin/bash

read -p "Enter table name to drop: " table

metaFile="../Tables/Metadata/$table.meta"
dataFile="../Tables/Data/$table.data"

# Check if table exists
if [[ ! -f "$metaFile" ]]; then
    echo "Table '$table' does not exist."
    exit 1
fi

# Delete files
rm -f "$metaFile" "$dataFile"

echo "Table '$table' deleted successfully."
