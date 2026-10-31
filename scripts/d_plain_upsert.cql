-- Contrast: ordinary INSERT (no IF NOT EXISTS) on a DIFFERENT event id.
CONSISTENCY LOCAL_QUORUM;
SELECT (text)'--- Plain INSERT by Alice ---' AS step FROM system.local;
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner) VALUES ('__EVENT__', 1, 'Alice');
SELECT (text)'--- Plain INSERT by Bob (no error, silently overwrites) ---' AS step FROM system.local;
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner) VALUES ('__EVENT__', 1, 'Bob');
SELECT * FROM nosql_rf3.seat_claims WHERE event_id = '__EVENT__' AND seat_no = 1;
