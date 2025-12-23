    #!/bin/bash

    DB_NAME="$1"
    DB_PATH="db_storage/$DB_NAME"
    CATALOG="databases.meta"


    # Check database name provided
    if [[ -z "$DB_NAME" ]]; then
        echo "ERROR: Database name is required"
        exit
    fi

    # Validate database name
    if [[ ! "$DB_NAME" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo "ERROR: Invalid database name"
        exit
    fi

    # Check if database already exists
    if [[ -d "$DB_PATH" ]]; then
        echo "ERROR: Database already exists"
        exit
    fi

    # Create database directories
    mkdir -p "$DB_PATH/tables_meta" "$DB_PATH/tables_data" || {
        echo "ERROR: Failed to create database structure"
        exit
    }

    # Register database in catalog
    echo "$DB_NAME:$(date +"%Y-%m-%d %H:%M:%S"):$USER" >> "$CATALOG"

    echo "Database '$DB_NAME' created successfully"
