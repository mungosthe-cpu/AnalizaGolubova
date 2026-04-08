-- Base schema used by track/race DB files under Staze/2025/*.db

CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ime TEXT NOT NULL UNIQUE,
    grad TEXT,
    lat REAL,
    lon REAL,
    grupacija TEXT DEFAULT '',
    broj_korisnika TEXT DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pigeons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    owner TEXT NOT NULL,
    golub TEXT NOT NULL,
    godina TEXT DEFAULT '',
    pol TEXT DEFAULT '',
    kategorija TEXT DEFAULT '',
    last_used_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(owner, golub)
);

CREATE TABLE IF NOT EXISTS pigeon_runs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    owner TEXT NOT NULL,
    golub TEXT NOT NULL,
    broj_trke INTEGER,
    start_grad TEXT,
    datum_pustanja TEXT,
    vreme_pustanja TEXT,
    datum_dolaska TEXT,
    vreme_dolaska TEXT,
    dist_km REAL,
    flight_sec INTEGER,
    speed_ms REAL,
    speed_kmh REAL,
    pol TEXT DEFAULT '',
    godina TEXT DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS races (
    race_id TEXT PRIMARY KEY,
    owner TEXT NOT NULL,
    broj_trke INTEGER,
    start_grad TEXT,
    datum_pustanja TEXT,
    vreme_pustanja TEXT,
    category TEXT DEFAULT 'S',
    lat REAL,
    lon REAL,
    locked INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);
