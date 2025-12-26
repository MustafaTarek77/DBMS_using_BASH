#!/bin/bash

DB_NAME="$1"
DB_PATH="db_storage/$DB_NAME"

PS3="[$DB_NAME] Enter your choice: "

select choice in \
    "Create Table" \
    "List Tables" \
    "Drop Table" \
    "Insert Row" \
    "Select Data" \
    "Back to Main Menu"
do
    case $REPLY in
        1) ./table_handler/create_table.sh "$DB_NAME" ;;
        2) ./table_handler/list_tables.sh "$DB_NAME" ;;
        3) ./table_handler/drop_table.sh "$DB_NAME" ;;
        4) ./table_handler/insert_row.sh "$DB_NAME" ;;
        5) ./table_handler/select_data.sh "$DB_NAME" ;;
        6) break ;;
        *) echo "Invalid option" ;;
    esac
done
