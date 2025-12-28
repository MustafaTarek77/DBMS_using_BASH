#! /bin/bash

is_valid_name() {
    if [[ ! "$1" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo "ERROR: Invalid Name"
        exit
    fi
}
is_non_empty() {
    if [[ -z "$1" ]]; then
        echo "ERROR: Name is required"
        exit
    fi
}
is_db_exists() {
    if [[ -d "db_storage/$1" ]]; then
        echo "ERROR: Database '$1' already exists"
        exit
    fi
}

is_db_does_not_exist() {
    if [[ ! -d "db_storage/$1" ]]; then
        echo "ERROR: Database '$1' does not exist"
        exit
    fi
}
