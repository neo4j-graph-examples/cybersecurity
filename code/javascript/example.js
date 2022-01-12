// npm install --save neo4j-driver
// node example.js
const neo4j = require('neo4j-driver');
const driver = neo4j.driver('neo4j://<HOST>:<BOLTPORT>',
                  neo4j.auth.basic('<USERNAME>', '<PASSWORD>'), 
                  {/* encrypted: 'ENCRYPTION_OFF' */});

const query =
  `
  MATCH (u:User {name: 'HilaryOlivia226@TestCompany.Local'})-[:CAN_RDP]->(r) RETURN r.name as computer
  `;

const params = {"name": "HilaryOlivia226@TestCompany.Local"};

const session = driver.session({database:"neo4j"});

session.run(query, params)
  .then((result) => {
    result.records.forEach((record) => {
        console.log(record.get('computer'));
    });
    session.close();
    driver.close();
  })
  .catch((error) => {
    console.error(error);
  });
