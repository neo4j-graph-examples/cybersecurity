//Attack Path 4 - User Similarity

CALL gds.nodeSimilarity.stream({
    nodeQuery: 'MATCH (n) WHERE n:User OR n:Computer RETURN id(n) AS id',
    relationshipQuery: '
        CALL {
            MATCH (u:User)-[:MEMBER_OF*1..]->(:Group)-[:CAN_RDP]->(c:Computer)
            RETURN u, c
            UNION
            MATCH (u:User)-[:CAN_RDP]->(c:Computer)
            RETURN u, c
        }
        RETURN id(u) AS source, id(c) AS target
    ',
    similarityCutoff: 0.3
}) YIELD node1, node2, similarity
WITH gds.util.asNode(node1).name AS user, gds.util.asNode(node2).name AS other, similarity
WITH user, {score: similarity, name: other} AS result
WITH user, collect(result) AS results
RETURN user, results ORDER BY size(results) DESC;