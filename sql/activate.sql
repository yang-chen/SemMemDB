CREATE OR REPLACE FUNCTION semmemdb.activate()
RETURNS TABLE(node INT, s DOUBLE PRECISION) AS $$
BEGIN
  RETURN QUERY
  WITH Spreading AS (
    SELECT assoc.node2 AS node, SUM(query.w*assoc.s) AS s
    FROM semmemdb.query JOIN semmemdb.assoc
    ON query.node = assoc.node1
    GROUP BY assoc.node2
  ), Base AS (
    SELECT history.node AS node, log(SUM(power(10-t,-0.5))) as b
    FROM Spreading JOIN semmemdb.history
    ON Spreading.node = history.node
    GROUP BY history.node
  )
  SELECT Spreading.node AS node, Spreading.s+COALESCE(Base.b,0) AS A
  FROM Spreading LEFT JOIN Base ON Spreading.node = Base.node;
END;
$$ LANGUAGE plpgsql;
