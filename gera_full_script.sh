#!/bin/sh

cat drop_tables.sql > script_completo.sql
cat create_tables_final.sql >> script_completo.sql
cat insert_into.sql >> script_completo.sql
cat ./views/*.sql >> script_completo.sql
cat ./functions/*.sql >> script_completo.sql
cat ./triggers/*.sql >> script_completo.sql
