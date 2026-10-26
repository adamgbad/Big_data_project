CREATE KEYSPACE IF NOT EXISTS nosql_rf3
WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 3}; 

CREATE KEYSPACE IF NOT EXISTS nosql_rf1
WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 1};

-- Main table: query = all registrations of one event 
CREATE TABLE IF NOT EXISTS nosql_rf3.registrations (
    event_id        text,           -- partition key
    seat_no         int,            -- clustering column
    attendee        text,
    email           text, 
    registered_at   timestamp,
    PRIMARY KEY ((event_id), seat_no)
) WITH CLUSTERING ORDER BY (seat_no ASC);

-- Guide 5 (lightweight transactions)
CREATE TABLE IF NOT EXISTS nosql_rf3.seat_claims ( 
    event_id        text,
    seat_no         int, 
    owner           text,
    PRIMARY KEY (event_id, seat_no)
);

-- Guide 4 (placement, RF 1): good design
CREATE TABLE IF NOT EXISTS nosql_rf1.registrations_good ( 
    event_id        text,
    seat_no         int, 
    attendee        text, 
    email           text,
    registered_at   timestamp,
    PRIMARY KEY ((event_id), seat_no)
);

-- Guide 4: deliberately poor design (constant partition key) 
CREATE TABLE IF NOT EXISTS nosql_rf1.registrations_bad (
    bucket          text, 
    event_id        text, 
    seat_no         int, 
    attendee        text,
    PRIMARY KEY ((bucket), event_id, seat_no)
);