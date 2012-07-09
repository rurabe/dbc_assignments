SELECT details.body
FROM details
JOIN person
ON person.id = details.person_id
WHERE person.name = 'Barack Obama'
AND details.type = :full_address;
#Not sure if this is how a symbol would get stored in the db

SELECT person.*
FROM person
JOIN details
ON person.id = details.person_id
WHERE details.body = 'CA'
AND details.type = :state;


person_id = SELECT id
FROM person
WHERE name = "Barack Obama";

INSERT INTO details
(type,body,person_id)
VALUES
(:full_address,'717 California Street, San Francisco CA, 94108',#{person_id});

