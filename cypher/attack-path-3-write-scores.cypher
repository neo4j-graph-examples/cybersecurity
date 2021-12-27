// Attack Path 3 - Write  Scores
CALL gds.betweenness.write('betweennessGraph', { writeProperty: 'betweenness' })
YIELD centralityDistribution, nodePropertiesWritten