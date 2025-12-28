#!/bin/bash

DB_NAME="$1"
DB_PATH="db_storage/$DB_NAME"

options=("Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back to Main Menu")

while true; do
    echo ""
    echo "[$DB_NAME] Select an option:"
    for i in "${!options[@]}"; do
        idx=$((i+1))
        printf "%2d) %s\n" "$idx" "${options[$i]}"
    done

    read -p "Enter your choice (1-${#options[@]}): " choice

    case $choice in
        1) ./table_handler/create_table.sh "$DB_NAME" ;;
        2) ./table_handler/list_tables.sh "$DB_NAME" ;;
        3) ./table_handler/drop_table.sh "$DB_NAME" ;;
        4) ./record_handler/insert.sh "$DB_NAME" ;;
        5) ./record_handler/select.sh "$DB_NAME" ;;
        6) ./record_handler/delete.sh "$DB_NAME" ;;
        7) ./record_handler/update.sh "$DB_NAME" ;;
        8) break ;;
        *) echo "Invalid option, please try again." ;;
    esac
done
