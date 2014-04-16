CREATE SCHEMA semmemdb;

-- create tables
CREATE TABLE semmemdb.entities (id INT PRIMARY KEY, name TEXT);
CREATE TABLE semmemdb.relations (id INT PRIMARY KEY, name TEXT);

CREATE TABLE semmemdb.relationships (sub INT, prop INT, obj INT);
CREATE TABLE semmemdb.attributes (sub INT, prop INT, att TEXT);
CREATE TABLE semmemdb.history (node INT, t DOUBLE PRECISION);

CREATE TABLE semmemdb.query (node INT, w DOUBLE PRECISION);

-- views (may be materialized in materialize.sql)
CREATE VIEW semmemdb.links AS
SELECT sub AS node, COUNT(*) AS l
FROM semmemdb.relationships
GROUP BY sub;

CREATE VIEW semmemdb.assoc AS
SELECT sub AS node1, obj AS node2, 2-ln((1+links.l)/COUNT(*)) AS s
FROM semmemdb.relationships JOIN semmemdb.links
ON relationships.sub = links.node
GROUP BY sub, obj, links.l;
