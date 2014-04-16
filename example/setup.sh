#!/bin/bash

PROJECT_DIR=/home/yang/semmemdb

CSV_DIR=${PROJECT_DIR}/csv
SQL_DIR=${PROJECT_DIR}/sql
SCRIPTS_DIR=${PROJECT_DIR}/scripts

DB_NAME=semmemdb

# Parse and load DBPedia data
echo "Parsing and loading data..."
python ${SCRIPTS_DIR}/Parser.py
psql ${DB_NAME} -f ${SQL_DIR}/create.sql
psql ${DB_NAME} -f ${SQL_DIR}/load.sql
psql ${DB_NAME} -f ${SQL_DIR}/materialize.sql
psql ${DB_NAME} -f ${SQL_DIR}/activate.sql
