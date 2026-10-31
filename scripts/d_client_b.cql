CONSISTENCY LOCAL_QUORUM;
SERIAL CONSISTENCY LOCAL_SERIAL;
CONSISTENCY;
SERIAL CONSISTENCY;
SELECT (text)'--- D client B (cass2): claim the same seat for Bob ---' AS step FROM system.local;
INSERT INTO nosql_rf3.seat_claims (event_id, seat_no, owner)
VALUES ('__EVENT__', 1, 'Bob') IF NOT EXISTS;
