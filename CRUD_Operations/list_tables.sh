#!/bin/bash

meta_dir="../Tables/Metadata"

# Check if directory exists
if [[ ! -d "$meta_dir" ]]; then
    echo "No tables directory found!"
    exit 1
fi

# List tables
found=0
for file in "$meta_dir"/*.meta; do
    [[ -e "$file" ]] || continue
    basename "$file" .meta
    found=1
done

if [[ $found -eq 0 ]]; then
    echo "No tables found."
fi
