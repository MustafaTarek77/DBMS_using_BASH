#!/bin/bash

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
NC="\033[0m" # No Color

DB_NAME="$1"
DB_PATH="db_storage/$DB_NAME"

while true; do
    clear
    echo -e "${CYAN}==============================${NC}"
    echo -e "${GREEN}      DATABASE: $DB_NAME       ${NC}"
    echo -e "${CYAN}==============================${NC}"
    echo -e "${YELLOW}1) Create Table${NC}"
    echo -e "${YELLOW}2) List Tables${NC}"
    echo -e "${YELLOW}3) Drop Table${NC}"
    echo -e "${YELLOW}4) Insert Into Table${NC}"
    echo -e "${YELLOW}5) Select From Table${NC}"
    echo -e "${YELLOW}6) Delete From Table${NC}"
    echo -e "${YELLOW}7) Update Table${NC}"
    echo -e "${RED}8) Back to Main Menu${NC}"
    echo -e "${CYAN}------------------------------${NC}"

    read -p "[$DB_NAME] Enter your choice: " choice

    case $choice in
        1)
            ./table_handler/create_table.sh "$DB_NAME"
            read -p"Press Enter to continue..."
            ;;
        2)
            ./table_handler/list_tables.sh "$DB_NAME"
            echo ""
            read -p"Press Enter to continue..."
            ;;
        3)
            ./table_handler/drop_table.sh "$DB_NAME"
            read -p "Press Enter to continue..."
            ;;
        4)
            ./record_handler/insert.sh "$DB_NAME"
            read -p "Press Enter to continue..."
            ;;
        5)
            ./record_handler/select.sh "$DB_NAME"
            read -p "Press Enter to continue..."
            ;;
        6)
            ./record_handler/delete.sh "$DB_NAME"
            read -p "Press Enter to continue..."
            ;;
        7)
            ./record_handler/update.sh "$DB_NAME"
            read -p "Press Enter to continue..."
            ;;
        8)
            echo -e "${RED}Returning to Main Menu...${NC}"
            break
            ;;
        *)
            echo -e "${RED}Invalid option, please try again.${NC}"
            read -p "Press Enter to continue..."
            ;;
    esac
done
