import datetime
import pathlib

EVENTS = {"E1": 30, "E2": 20, "E3": 15, "E4": 25, "E5": 10, "E6": 20}
BASE = datetime.datetime(2026, 11, 1, 9, 0, 0) 
OUT = pathlib.Path("scripts")

def rows():
    for event, n in EVENTS.items(): 
        for seat in range(1, n + 1):
            ts = BASE + datetime.timedelta(minutes=seat) 
            yield {
                "event": event, 
                "seat": seat,
                "name": f"attendee_{event}_{seat:03d}", 
                "email": f"{event.lower()}.{seat}@example.org",
                "ts": ts.strftime("%Y-%m-%d %H:%M:%S"),
            }

def write(filename, header, template): 
    count = 0
    with open(OUT / filename, "w", encoding="utf-8") as f: 
        f.write(header + "\n")
        for r in rows(): 
            f.write(template.format(**r) + "\n") 
            count += 1
    print(f"{filename}: {count} rows")

write("seed_rf3.cql", "CONSISTENCY LOCAL_QUORUM;",
      "INSERT INTO nosql_rf3.registrations (event_id, seat_no, attendee, email, registered_at) "
      "VALUES ('{event}', {seat}, '{name}', '{email}', '{ts}');")

write("seed_rf1_good.cql", "CONSISTENCY ONE;",
      "INSERT INTO nosql_rf1.registrations_good (event_id, seat_no, attendee, email, registered_at) "
      "VALUES ('{event}', {seat}, '{name}', '{email}', '{ts}');")

write("seed_rf1_bad.cql", "CONSISTENCY ONE;",
      "INSERT INTO nosql_rf1.registrations_bad (bucket, event_id, seat_no, attendee) "
      "VALUES ('all', '{event}', {seat}, '{name}');")