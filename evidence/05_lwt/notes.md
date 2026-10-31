# Experiment D: lightweight transactions (Part 5D)

| Field | Record |
|---|---|
| Configuration | 3 nodes all UN, table `nosql_rf3.seat_claims` (PK `(event_id, seat_no)`), `CONSISTENCY LOCAL_QUORUM`, `SERIAL CONSISTENCY LOCAL_SERIAL`, fresh event id per run (`d_event_id.txt`) |
| Action | `bash scripts/d_lwt.sh`: client A on cass1 inserts Alice `IF NOT EXISTS`, then client B on cass2 inserts Bob `IF NOT EXISTS`, final read on cass3; contrast with plain INSERT; optional simultaneous run |
| Expected result | A `[applied] True`; B `[applied] False` and returns owner Alice; final owner Alice. Plain INSERT: no error, final owner Bob |
| Observed result | `d_client_a.txt` True. `d_client_b.txt` False, owner Alice. `d_final_read.txt` Alice (read through cass3). `d_plain_upsert.txt` owner Bob. `race_summary.txt` exactly one True and one False; `race_final.txt` shows the winner |
| Interpretation | The condition is checked and applied atomically for one row (Paxos), so the first claim is never overwritten. It costs extra round trips and covers one row/partition only; it is not a SQL transaction or a BATCH. A timeout would mean "unknown", not False |

Screenshot: `../screenshots/05_lwt_two_terminals.png` (both settings visible in each terminal).
