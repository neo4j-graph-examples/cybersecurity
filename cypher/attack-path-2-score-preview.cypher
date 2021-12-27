// Attack Path 2 - Score Preview
CALL gds.graph.create('betweennessGraph', 'Base', 'ATTACK_PATH')

CALL gds.betweenness.write.estimate('betweennessGraph', { writeProperty: 'betweenness' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory

CALL gds.betweenness.stream('betweennessGraph')
YIELD nodeId, score
WITH gds.util.asNode(nodeId) AS n, score
RETURN n.name, collect(labels(n)), score order by score desc limit 100