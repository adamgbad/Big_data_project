CONSISTENCY LOCAL_QUORUM;

SELECT (text)'--- STEP 1 CREATE: insert one registration ---' AS step FROM system.local;
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee, email, registered_at)
VALUES ('CRUD-DEMO', 1, 'Alice', 'alice@example.org', '2026-11-01 10:00:00');
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO' AND seat_no = 1;

SELECT (text)'--- STEP 2 READ: all rows of one partition ---' AS step FROM system.local;
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee, email, registered_at)
VALUES ('CRUD-DEMO', 2, 'Bob', 'bob@example.org', '2026-11-01 10:05:00');
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO'; 

SELECT (text)'--- STEP 3 UPDATE: change the e-mail of seat 1 ---' AS step FROM system.local;
UPDATE nosql_rf3.registrations SET email = 'alice.new@example.org'
WHERE event_id = 'CRUD-DEMO' AND seat_no = 1;
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO' AND seat_no = 1;

SELECT (text)'--- STEP 4 UPSERT: INSERT on an existing key overwrites only the listed columns ---' AS step FROM system.local;
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee) 
VALUES ('CRUD-DEMO', 1, 'Carol');
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO' AND seat_no = 1;

SELECT (text)'--- STEP 5 UPSERT: UPDATE on a missing key creates the row ---' AS step FROM system.local;
UPDATE nosql_rf3.registrations SET attendee = 'Dave' 
WHERE event_id = 'CRUD-DEMO' AND seat_no = 3;
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO';

SELECT (text)'--- STEP 6 DELETE: remove seat 2 ---' AS step FROM system.local; 
DELETE FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO' AND seat_no = 2;
SELECT * FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO';

SELECT (text)'--- STEP 7 USEFUL QUERIES beyond a single-row lookup ---' AS step FROM system.local;
SELECT seat_no, attendee FROM nosql_rf3.registrations
WHERE event_id = 'E1' AND seat_no >= 5 AND seat_no <= 10; 
SELECT seat_no, attendee FROM nosql_rf3.registrations
WHERE event_id = 'E1' ORDER BY seat_no DESC LIMIT 5;
SELECT count(*) FROM nosql_rf3.registrations WHERE event_id = 'E1';

SELECT (text)'--- CLEANUP ---' AS step FROM system.local;
DELETE FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO';
SELECT count(*) FROM nosql_rf3.registrations WHERE event_id = 'CRUD-DEMO';