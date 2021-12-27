// List active sessions in the network
MATCH p=()-[r:HAS_SESSION]->() RETURN p LIMIT 25

// List all the machines where there are more than one active sessions running from different users
MATCH (u)<-[:HAS_SESSION]-(c)
WITH count(u) as sessionCount, c, collect(u.name) as users
WHERE sessionCount > 1
RETURN c.name, users

// Return all high value assets (we call then crownJewels here) from the Network
// Also list what all groups, users have direct access to these high value objects
MATCH (o {highvalue:true})<--(a)
WHERE a:User OR a:Group
RETURN o, a

// Which groups have write access to the domain object? 
// And what all users have generic all access (full rights) on these groups
MATCH (d:Domain { name: 'TestCompany.Local' })<-[:WRITE_OWNER]-(g:Group) 
MATCH (g)-[:GENERIC_ALL]->(u:User)
RETURN d, g, u LIMIT 25

// Get all users who have RDP access, and the computer where he/she has the access
// Some users have RDP access available through groups they are part of
CALL
{
    MATCH p=(o:User)-[:CAN_RDP]->(c:Computer) RETURN p
    UNION ALL
    MATCH p =(o:User)-[:MEMBER_OF]->(g:Group)-[:CAN_RDP]->(c:Computer) RETURN p
}
RETURN p LIMIT 50
