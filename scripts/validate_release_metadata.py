#!/usr/bin/env python3
import hashlib
import json
import re
import sys
from pathlib import Path
from urllib.parse import urlparse

ROOT = Path(__file__).resolve().parents[1]
UPDATE_JSON = ROOT / "update.json"
DB_JSON = ROOT / "data" / "db_version.json"
DB_FILE = ROOT / "data" / "takmicari_grupacije.db"


def load_json(path: Path) -> dict:
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def sha256_of_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def validate_url(url: str, field: str) -> list[str]:
    errs: list[str] = []
    parsed = urlparse(url)
    if parsed.scheme not in {"http", "https"}:
        errs.append(f"{field}: URL mora biti http/https")
    if not parsed.netloc:
        errs.append(f"{field}: URL nema host")
    return errs


def main() -> int:
    errors: list[str] = []

    update = load_json(UPDATE_JSON)
    db = load_json(DB_JSON)

    for req in ("version", "url", "sha256"):
        if req not in update:
            errors.append(f"update.json: nedostaje polje '{req}'")
        if req not in db:
            errors.append(f"data/db_version.json: nedostaje polje '{req}'")

    if "url" in update:
        errors.extend(validate_url(update["url"], "update.json.url"))
    if "url" in db:
        errors.extend(validate_url(db["url"], "data/db_version.json.url"))

    if "version" in update and "url" in update:
        version = str(update["version"])
        # očekujemo da ime setup fajla nosi verziju
        if re.search(rf"Setup_{re.escape(version)}\.exe", update["url"]) is None:
            errors.append(
                "update.json: version ne odgovara nazivu setup fajla u URL-u"
            )

    if "version" in db and not isinstance(db["version"], int):
        errors.append("data/db_version.json.version mora biti integer")

    if "sha256" in db:
        actual_db_sha = sha256_of_file(DB_FILE)
        if db["sha256"] != actual_db_sha:
            errors.append(
                "data/db_version.json.sha256 ne odgovara lokalnom data/takmicari_grupacije.db"
            )

    if "sha256" in update and update["sha256"] == "TBD":
        print("[WARN] update.json.sha256 = 'TBD' (postaviti finalni hash pre release-a)")

    if errors:
        print("[FAIL] Metadata validacija nije prošla:")
        for e in errors:
            print(f" - {e}")
        return 1

    print("[OK] Metadata validacija uspešna.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
