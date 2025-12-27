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
        4) ./table_handler/insert_into_table.sh "$DB_NAME" ;;
        5) ./table_handler/select_from_table.sh "$DB_NAME" ;;
        6) ./table_handler/delete_from_table.sh "$DB_NAME" ;;
        7) ./table_handler/update_table.sh "$DB_NAME" ;;
        8) break ;;
        *) echo "Invalid option" ;;
    esac
done
