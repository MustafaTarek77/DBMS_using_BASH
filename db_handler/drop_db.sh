#!/bin/bash

YELLOW="\033[1;33m"
NC="\033[0m" # No Color

source ./utils/validations.sh

DB_NAME="$1"
DBS_META="databases.meta"
DB_PATH="db_storage/$DB_NAME"

is_non_empty "$DB_NAME"
is_db_exists "$DB_NAME"

sed -i "/^$DB_NAME:/d" "$DBS_META"


if [[ -d "$DB_PATH" ]]; then
    rm -rf "$DB_PATH"
fi

echo
echo "-------------------------------------------"
echo -e "Database ${YELLOW}'$DB_NAME'${NC} dropped successfully"
echo "-------------------------------------------"
echo