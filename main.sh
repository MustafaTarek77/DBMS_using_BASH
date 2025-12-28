#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
NC="\033[0m"

# run initialization script
chmod +x ./init.sh
./init.sh

while true; do
    clear
    echo -e "${CYAN}==============================${NC}"
    echo -e "${GREEN}      DATABASE MANAGER        ${NC}"
    echo -e "${CYAN}==============================${NC}"
    echo -e "${YELLOW}1) Create Database${NC}"
    echo -e "${YELLOW}2) List Databases${NC}"
    echo -e "${YELLOW}3) Connect to a Database${NC}"
    echo -e "${YELLOW}4) Drop Database${NC}"
    echo -e "${RED}5) Exit${NC}"
    echo -e "${CYAN}------------------------------${NC}"

    read -p "Choose [1-5]: " choice

    case $choice in
        1)
            read -p "Enter Database Name: " db_name
            ./db_handler/create_db.sh "$db_name"
            read -p "Press Enter to continue..."
            ;;
        2)
            ./db_handler/list_db.sh
            read -p "Press Enter to continue..."
            ;;
        3)
            read -p "Enter Database Name to connect: " db_name
            ./db_handler/connect_db.sh "$db_name"
            ;;
        4)
            read -p "Enter Database Name to drop: " db_name
            ./db_handler/drop_db.sh "$db_name"
            read -p "Press Enter to continue..."
            ;;
        5)
            echo -e "${RED}Exiting...${NC}"
            break
            ;;
        *)
            echo -e "${RED}Invalid option, please try again.${NC}"
            read -p "Press Enter to continue..."
            ;;
    esac
done
