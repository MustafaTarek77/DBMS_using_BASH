#!/bin/bash

DBS_META="databases.meta"

if [[ ! -f "$DBS_META" ]]; then
    echo "NO file with that name exists!"
    exit 0
fi

if [[ ! -s "$DBS_META" ]]; then
    echo "No databases found."
    exit 0
fi

awk -F':' '
BEGIN {
    print "No\t\tDatabase\t\tCreated At\t\tOwner"
    print "--------------------------------------------------------------------"
}
{
    print NR "\t\t" $1 "\t\t" $2 "\t\t" $3
}
' "$DBS_META"
