# Bash DBMS (Shell Script)

A simple command-line Database Management System (DBMS) implemented in Bash.
This project provides a menu-driven CLI app for creating and managing databases
and tables on disk using plain directories and files.

---

## Features

- **Main menu** operations:
  - Create Database
  - List Databases
  - Connect to Database
  - Drop Database
- **Within a connected database:**
  - Create Table (with columns, datatypes, and primary key)
  - List Tables
  - Drop Table
  - Insert into Table (validates datatypes and primary key)
  - Select from Table (prints rows in a readable table format)
  - Delete from Table
  - Update Table (validates datatypes and primary key constraints)

## How to run

1. Make sure scripts are executable:

   ```bash
   chmod +x *.sh table_handler/*.sh db_handler/*.sh record_handler/*.sh
   ```

2. Start the app:

   ```bash
   ./main.sh
   ```

3. Follow the interactive menu to create databases and tables, insert/select/update/delete records.

4. Inspect `db_storage/` to see how databases and tables are stored.


## Contributing
- Mustafa Tarek 
- Sherif Mohammed
