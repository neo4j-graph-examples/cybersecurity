# pip3 install neo4j-driver
# python3 example.py

from neo4j import GraphDatabase, basic_auth

driver = GraphDatabase.driver(
  "neo4j://<HOST>:<BOLTPORT>",
  auth=basic_auth("<USERNAME>", "<PASSWORD>"))

cypher_query = '''
MATCH (u:User {name: 'HilaryOlivia226@TestCompany.Local'})-[:CAN_RDP]->(r) RETURN r.name as computer
'''

with driver.session(database="neo4j") as session:
  results = session.read_transaction(
    lambda tx: tx.run(cypher_query,
                      name="HilaryOlivia226@TestCompany.Local").data())
  for record in results:
    print(record['computer'])

driver.close()
