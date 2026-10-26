CONSISTENCY LOCAL_QUORUM;
SELECT (text)'--- B2a: LOCAL_QUORUM read, one node down ---' AS step FROM system.local;
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations 
WHERE event_id = 'B-TEST' AND seat_no = 1;

SELECT (text)'--- B2b: LOCAL_QUORUM write, one node down ---' AS step FROM system.local;
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee) 
VALUES ('B-TEST', 1, 'during_failure');

SELECT (text)'--- B2c: LOCAL_QUORUM read back ---' AS step FROM system.local; 
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations
WHERE event_id = 'B-TEST' AND seat_no = 1;

CONSISTENCY ALL;
SELECT (text)'--- B2d: ALL read, one node down (expected to FAIL) ---' AS step FROM system.local;
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations 
WHERE event_id = 'B-TEST' AND seat_no = 1;