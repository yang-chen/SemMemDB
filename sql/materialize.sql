-- create materizlied views
CREATE TABLE semmemdb.links_table AS
SELECT sub AS node, COUNT(*) AS l
FROM semmemdb.relationships
GROUP BY sub;

CREATE TABLE semmemdb.assoc_table AS
SELECT sub AS node1, obj AS node2, 2-ln((1+links_table.l)/COUNT(*)) AS s
FROM semmemdb.relationships JOIN semmemdb.links_table
ON relationships.sub = links_table.node
GROUP BY sub, obj, links_table.l;

-- redirect the views
CREATE OR REPLACE VIEW semmemdb.links AS
SELECT * FROM semmemdb.links_table;

CREATE OR REPLACE VIEW semmemdb.assoc AS
SELECT * FROM semmemdb.assoc_table;

-- index on materizlied views
CREATE INDEX assoc_node1_index ON semmemdb.assoc_table (node1);
CREATE INDEX assoc_node2_index ON semmemdb.assoc_table (node2);
