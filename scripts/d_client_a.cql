CONSISTENCY LOCAL_QUORUM;
SERIAL CONSISTENCY LOCAL_SERIAL;
CONSISTENCY;
SERIAL CONSISTENCY;
SELECT (text)'--- D client A (cass1): claim seat 1 for Alice ---' AS step FROM system.local;
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner)
VALUES ('__EVENT__', 1, 'Alice') IF NOT EXISTS;
