CONSISTENCY ALL;
SELECT (text)'--- B1: seed at CL ALL, all nodes up ---' AS step FROM system.local; 
INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee)
VALUES ('B-TEST', 1, 'before_failure');
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations 
WHERE event_id = 'B-TEST' AND seat_no = 1;
