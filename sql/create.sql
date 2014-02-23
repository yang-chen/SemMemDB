CREATE SCHEMA dbpedia;

-- create tables
CREATE TABLE dbpedia.entities (id INT PRIMARY KEY, name TEXT);
CREATE TABLE dbpedia.relations (id INT PRIMARY KEY, name TEXT);

CREATE TABLE dbpedia.relationships (sub INT, prop INT, obj INT);
CREATE TABLE dbpedia.attributes (sub INT, prop INT, att TEXT);
CREATE TABLE dbpedia.history (node INT, t DOUBLE PRECISION);

CREATE TABLE dbpedia.query (node INT, w DOUBLE PRECISION);

-- import csv 
COPY dbpedia.entities FROM '/home/yang/semmemdb/csv/entities.csv' DELIMITERS ',' CSV;
COPY dbpedia.relations FROM '/home/yang/semmemdb/csv/relations.csv' DELIMITERS ',' CSV;
COPY dbpedia.relationships FROM '/home/yang/semmemdb/csv/relationships.csv' DELIMITERS ',' CSV;
COPY dbpedia.attributes FROM '/home/yang/semmemdb/csv/attributes.csv' DELIMITERS ',' CSV;
-- COPY dbpedia.history FROM '/home/yang/semmemdb/csv/history.csv' DELIMITERS ',' CSV;

-- materialized views
CREATE TABLE dbpedia.links AS
SELECT sub AS node, COUNT(*) AS l
FROM dbpedia.relationships
GROUP BY sub;

CREATE TABLE dbpedia.assoc AS
SELECT sub AS node1, obj AS node2, 2-ln((1+links.l)/COUNT(*)) AS s
FROM dbpedia.relationships JOIN dbpedia.links
ON relationships.sub = links.node
GROUP BY sub, obj, links.l;

-- indexes
CREATE INDEX sub_index ON dbpedia.relationships (sub);
CREATE INDEX obj_index ON dbpedia.relationships (obj);
CREATE INDEX node1_index ON dbpedia.assoc (node1);
CREATE INDEX node2_index ON dbpedia.assoc (node2);
CREATE INDEX hist_index ON dbpedia.history (node);
