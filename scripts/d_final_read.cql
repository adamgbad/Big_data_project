CONSISTENCY LOCAL_QUORUM;
SELECT (text)'--- D final state (read through cass3) ---' AS step FROM system.local;
SELECT * FROM nosql_rf3.seat_claims WHERE event_id = '__EVENT__' AND seat_no = 1;
