SemMemDB: In-Database Knowledge Activation
------------------------------------------

Semantic memory techniques are currently facing significant scalability
challenges due to the growth of problem complexity and data size. In this
paper, we present SemMemDB, an in-database module for semantic memories. This
module defines a novel relational model for semantic memories and an efficient
SQL-based spreading activation algorithm. We provide an intuitive, easy-to-use
API for the users to run retrieval tasks. SemMemDB is the first in-database
query engine for semantic memories. The benefits of our in-database approach
includes: 1) Databases have mature query engine and optimizer that generates
efficient execution plans; 2) Databases provide massive storage that supports
large amount of data; 3) SQL is one of the industry standards used widely in
various systems and frameworks. We provide extensive evaluation on DBPedia, a
web-scale knowledge base constructed from Wikipedia articles. Experiment
results show our system runs over 500 times faster than previous works.

**IMPORTANT:** SemMemDB is still early release and under active research.

###Prerequisites
 * Linux
 * Python 2.7
 * PostgreSQL 9.2

###Installation Guide
**Project directories:**
```
- PROJECT_DIR
+- data
+- csv
+- example
+- paper
+- scripts
+- sql
```

**Installation steps:**

 * Download the DBPedia data into `data` directory.
 * Run PostgreSQL server, create a database, say semmemdb:
```
$ postgres -D ${DATA_PATH} &
$ createdb semmemdb
```
 * In `example/setup.sh`, fill in the project path and database name:
```
PROJECT_DIR=/path/to/project
DB_NAME=semmemdb
```
 * Run `setup.sh`:
```
$ ${PROJECT_DIR}/example/setup.sh
```
This completes the installation.

To run an example, login into PostgreSQL, populate the `query` table, and call `activate()` procedure:
```
$ psql semmemdb
psql (9.2.3)
Type "help" for help.

semmemdb=# SELECT * FROM semmemdb.activate() LIMIT 10;
 node |         s          
------+--------------------
    2 | -0.363317136968319
    3 | -0.594135148094781
    4 | -0.594135148094781
    5 | -0.594135148094781
    6 | -0.594135148094781
    7 | -0.594135148094781
    8 | -0.594135148094781
    9 | -0.594135148094781
   10 | -0.594135148094781
   11 | -0.594135148094781
```

The name of nodes are stored in the `semmemdb.entities` table.
