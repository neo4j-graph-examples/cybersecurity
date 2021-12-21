//Attack Path 1 - Materialize
MATCH (crownJewel {objectid:'S-1-5-21-883232822-274137685-4173207997-512'})
WITH id(crownJewel) AS crownJewelId

MATCH (n) WHERE n.highvalue IS NULL
WITH id(n) AS sourceId, crownJewelId

CALL gds.shortestPath.dijkstra.stream("attackPaths", {
    sourceNode: sourceId, 
    targetNode: crownJewelId
}) YIELD sourceNode, targetNode, nodeIds

WITH nodeIds
UNWIND apoc.coll.pairsMin(gds.util.asNodes(nodeIds)) AS pair
WITH pair[0] AS a, pair[1] AS b
MERGE (a)-[r:ATTACK_PATH]->(b)
RETURN count(r);