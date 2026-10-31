# CRUD (Part 4)

| Field | Record |
|---|---|
| Configuration | Table `nosql_rf3.registrations` (RF 3), 120 seeded rows, `CONSISTENCY LOCAL_QUORUM`, cqlsh on cass1 |
| Action | `bash scripts/crud_run.sh` (runs `scripts/crud.cql`, then a query on the non-key column `attendee`) |
| Expected result | Each step verified by a SELECT; INSERT on an existing key and UPDATE on a missing key both succeed (upsert); query on `attendee` refused |
| Observed result | Step 1: Alice. Step 2: 2 rows sorted by seat_no. Step 3: e-mail changed. Step 4: attendee → Carol, e-mail kept. Step 5: new row seat 3 Dave (e-mail null). Step 6: seats 1 and 3 remain. Step 7: seats 5–10 ascending, 30–26 descending, count 30. Cleanup: count 0. `allow_filtering_error.txt`: `InvalidRequest … use ALLOW FILTERING` |
| Interpretation | INSERT/UPDATE are upserts and overwrite only the listed columns. The clustering column supports ordered range queries inside one partition. Queries outside the key are refused: tables are designed per query |

Screenshot: `../screenshots/06_allow_filtering.png`.
