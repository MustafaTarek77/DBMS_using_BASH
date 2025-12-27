#!/bin/bash

DB_NAME="$1"
DB_PATH="db_storage/$DB_NAME"

PS3="[$DB_NAME] Enter your choice: "

select choice in \
    "Create Table" \
    "List Tables" \
    "Drop Table" \
    "Insert Into Table" \
    "Select From Table" \
    "Delete From Table" \
    "Update Table" \
    "Back to Main Menu"
do
    case $REPLY in
        1) ./table_handler/create_table.sh "$DB_NAME" ;;
        2) ./table_handler/list_tables.sh "$DB_NAME" ;;
        3) ./table_handler/drop_table.sh "$DB_NAME" ;;
        4) ./record_handler/insert.sh "$DB_NAME" ;;
        5) ./record_handler/select.sh "$DB_NAME" ;;
        6) ./record_handler/delete.sh "$DB_NAME" ;;
        7) ./record_handler/update.sh "$DB_NAME" ;;
        8) break ;;
        *) echo "Invalid option" ;;
    esac
done
