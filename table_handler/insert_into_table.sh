#!/bin/bash


read -p "Enter table name: " TABLE

## $1 is DB_NAME
META_FILE="db_storage/$1/tables_meta/$TABLE.meta"
DATA_FILE="db_storage/$1/tables_data/$TABLE.data"


if [[ ! -f "$META_FILE" || ! -f "$DATA_FILE" ]]; then
    echo "ERROR: Table '$TABLE' does not exist."
    exit 1
fi


## Read meta data
columns=($(awk -F: 'NR==1 {for(i=1;i<=NF;i++) print $i}' "$META_FILE"))
types=($(awk -F: 'NR==2 {for(i=1;i<=NF;i++) print $i}' "$META_FILE"))
PK_COL=$(awk -F'=' 'NR==3 {print $2}' "$META_FILE")


## Get PK col
pk_index=-1
for i in "${!columns[@]}"; do
    if [[ "${columns[$i]}" == "$PK_COL" ]]; then
        pk_index=$i
        break
    fi
done

echo -n "Table => $TABLE ("

for i in "${!columns[@]}"; do
    if [[ $i -eq $pk_index ]]; then
        echo -n "${columns[$i]}:${types[$i]}:PK"
    else
        echo -n "${columns[$i]}:${types[$i]}"
    fi
    [[ $i -lt $((${#columns[@]} - 1)) ]] && echo -n ", "
done
echo ")"
echo ## prints empty line


values=()

for i in "${!columns[@]}"; do
    while true; do
        read -p "Enter value for ${columns[$i]} (${types[$i]}): " value

        if [[ "${types[$i]}" == "int" && ! "$value" =~ ^[0-9]+$ ]]; then
            echo "ERROR: Must be an integer."
            continue
        fi

        if [[ "${types[$i]}" == "string" && -z "$value" ]]; then
            echo "ERROR: String cannot be empty."
            continue
        fi

        # PK VALIDATION
        if cut -d'|' -f1 "$DATA_FILE" | grep "$value"; then
            echo "ERROR: Primary key already exists."
            continue
        fi

        values+=("$value")
        break
    done
done


record=$(IFS='|'; echo "${values[*]}")
echo "$record" >> "$DATA_FILE"

echo
echo "✅ Record inserted successfully into '$TABLE'"
echo "============================================="