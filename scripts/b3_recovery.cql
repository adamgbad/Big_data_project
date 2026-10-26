CONSISTENCY ALL;
SELECT (text)'--- B3: read and write at CL ALL after node restored ---' AS step FROM system.local;
SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations
WHERE event_id = 'B-TEST' AND seat_no = 1;

INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee)
VALUES ('B-TEST', 1, 'after_recovery');

SELECT event_id, seat_no, attendee FROM nosql_rf3.registrations
WHERE event_id = 'B-TEST' AND seat_no = 1;
