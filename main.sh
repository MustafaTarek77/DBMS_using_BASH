#!/bin/bash

chmod +x ./init.sh
./init.sh

options=("Create Database" "List Databases" "Connect to a Database" "Drop Database" "Exit")

while true; do
    echo ""
    echo "Select an option:"
    for i in "${!options[@]}"; do
        idx=$((i+1))
        printf "%2d) %s\n" "$idx" "${options[$i]}"
    done

    read -p "Enter your choice (1-${#options[@]}): " choice

    case $choice in
        1)
            read -p "Enter Database Name: " db_name
            ./db_handler/create_db.sh "$db_name"
	        ;;
        2)
            ./db_handler/list_db.sh
            ;;
        3)
            read -p "Enter Database Name to connect: " db_name
            ./db_handler/connect_db.sh "$db_name"
            ;;
        4)
            read -p "Enter Database Name to drop: " db_name
            ./db_handler/drop_db.sh "$db_name"
            ;;
        5)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac
done

