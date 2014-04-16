-- load data
COPY semmemdb.entities FROM '/home/yang/semmemdb/csv/entities.csv' DELIMITERS ',' CSV;
COPY semmemdb.relations FROM '/home/yang/semmemdb/csv/relations.csv' DELIMITERS ',' CSV;
COPY semmemdb.relationships FROM '/home/yang/semmemdb/csv/relationships.csv' DELIMITERS ',' CSV;
COPY semmemdb.attributes FROM '/home/yang/semmemdb/csv/attributes.csv' DELIMITERS ',' CSV;
COPY semmemdb.history FROM '/home/yang/semmemdb/csv/history.csv' DELIMITERS ',' CSV;

-- create indexes
CREATE INDEX sub_index ON semmemdb.relationships (sub);
CREATE INDEX obj_index ON semmemdb.relationships (obj);
CREATE INDEX hist_index ON semmemdb.history (node);
