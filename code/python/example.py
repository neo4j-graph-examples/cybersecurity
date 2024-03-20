# pip3 install neo4j
# python3 example.py

from neo4j import GraphDatabase, basic_auth

cypher_query = '''
MATCH (u:User {name: $name})-[:CAN_RDP]->(r) RETURN r.name as computer
'''

with GraphDatabase.driver(
    "neo4j://<HOST>:<BOLTPORT>",
    auth=("<USERNAME>", "<PASSWORD>")
) as driver:
    result = driver.execute_query(
        cypher_query,
        name="HilaryOlivia226@TestCompany.Local",
        database_="neo4j")
    for record in result.records:
        print(record['computer'])
