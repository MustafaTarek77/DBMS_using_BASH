#!/bin/bash

DB_NAME="$1"
DB_PATH="db_storage/$DB_NAME"


if [[ -z "$DB_NAME" ]]; then
    echo "ERROR: Database name is required."
    exit 1
fi

read -p "Enter table name to select from: " TABLE

META_FILE="$DB_PATH/tables_meta/$TABLE.meta"
DATA_FILE="$DB_PATH/tables_data/$TABLE.data"


if [[ ! -f "$META_FILE" || ! -f "$DATA_FILE" ]]; then
    echo "ERROR: Table '$TABLE' does not exist."
    exit 1
fi


echo "Available columns:"
awk -F: 'NR==1{for(i=1;i<=NF;i++) print i": "$i}' "$META_FILE"

while true; do
    read -p "Do you want to select all columns? (y/n): " ALL_COLS

    if [[ "$ALL_COLS" =~ ^[Yy]$ ]]; then
        break

    elif [[ "$ALL_COLS" =~ ^[Nn]$ ]]; then
        cols_num=$(awk -F: 'NR==1{print NF}' "$META_FILE")
        read -p "Enter column numbers separated by space (e.g., 1 3 4): " COLS

        for col in $COLS; do
            if ! [[ "$col" =~ ^[0-9]+$ ]] || (( col < 1 || col > cols_num )); then
                echo "ERROR: Invalid column number '$col'."
                continue 2
            fi
        done
        break
    else
        echo "Enter y or n only."
    fi
done

# where condition
read -p "Do you want to add a WHERE condition? (y/n): " WHERE

if [[ "$WHERE" =~ ^[Yy]$ ]]; then
    read -p "Enter column number for condition: " WHERE_COL
    read -p "Enter value to match: " WHERE_VAL
else
    WHERE_COL=""
    WHERE_VAL=""
fi



SEP="\t\t"

## show header 
awk -F: -v cols="$COLS" -v all="$ALL_COLS" -v OFS="$SEP" '
BEGIN { split(cols, sel, " ") }
NR==1 {
    # If selecting ALL columns
    if (all ~ /^[Yy]$/) {
        $1=$1  # This forces awk to rebuild the line using the new OFS tabs
        print $0
    } 
    # If selecting SPECIFIC columns
    else {
        line=""
        for (i=1; i<=length(sel); i++) {
            # Append value to line. Add separator only if it is NOT the first item.
            val = $(sel[i])
            if (i==1) line = val
            else      line = line OFS val
        }
        print line
    }
    exit # Stop immediately after the first row
}' "$META_FILE"

echo "----------------------------------------"

## show data
awk -F"|" -v cols="$COLS" -v all="$ALL_COLS" -v wcol="$WHERE_COL" -v wval="$WHERE_VAL" -v OFS="$SEP" '
BEGIN { split(cols, sel, " ") }

# Filter (WHERE)
wcol != "" && $wcol != wval { next }

# Print (SELECT)
{
    if (all ~ /^[Yy]$/) {
        $1=$1  # Rebuild line with tabs
        print $0
    } else {
        line=""
        for (i=1; i<=length(sel); i++) {
            val = $(sel[i])
            if (i==1) line = val
            else      line = line OFS val
        }
        print line
    }
}' "$DATA_FILE"