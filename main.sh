#!/bin/bash

chmod +x ./init.sh
./init.sh

PS3="Enter your choice: "

select choice in "Create Database" "List Databases" "Connect to a Database" "Drop Database" "Exit"
do
    case $REPLY in
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

