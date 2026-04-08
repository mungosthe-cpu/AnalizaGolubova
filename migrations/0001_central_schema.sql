-- Initial schema for data/takmicari_grupacije.db

CREATE TABLE IF NOT EXISTS users (
    ime TEXT PRIMARY KEY,
    grad TEXT DEFAULT '',
    lat REAL,
    lon REAL,
    grupacija TEXT DEFAULT '',
    broj_korisnika TEXT DEFAULT '',
    email TEXT DEFAULT ''
);

CREATE TABLE IF NOT EXISTS grupacija_roster_godina (
    godina INTEGER NOT NULL,
    ime_kanonski TEXT NOT NULL,
    grupacija TEXT NOT NULL,
    PRIMARY KEY (godina, ime_kanonski)
);

CREATE INDEX IF NOT EXISTS idx_grg_godina ON grupacija_roster_godina (godina);

CREATE TABLE IF NOT EXISTS grupacija_roster_meta (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL
);
