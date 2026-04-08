# AnalizaGolubova – release data repo

Ovaj repozitorijum čuva **release metapodatke** i **SQLite podatke** koje desktop aplikacija koristi za update.

## Sadržaj

- `update.json` – verzija aplikacije i URL instalera.
- `data/db_version.json` – verzija baze i URL centralne baze.
- `data/takmicari_grupacije.db` – centralna baza takmičara/grupacija.
- `Staze/2025/*.db` – baze po stazi/trci za sezonu 2025.
- `migrations/` – istorija SQL migracija (versioned SQL).

## Pravila verzionisanja

Repo koristi **dve nezavisne verzije**:

1. **App verzija** (`update.json.version`)  
   - menja se kada izlazi novi installer (`.exe`),
   - format: `MAJOR.MINOR` ili `MAJOR.MINOR.PATCH`.

2. **DB verzija** (`data/db_version.json.version`)  
   - menja se kada se menja struktura/podaci centralne baze,
   - monotono raste (integer: 1, 2, 3...).

Detaljna pravila su u `docs/VERSIONING.md`.

## Integritet fajlova (checksum)

Svaki update JSON sadrži `sha256`:

- `update.json.sha256` – SHA-256 installer fajla (može biti `TBD` dok artefakt nije javno dostupan).
- `data/db_version.json.sha256` – SHA-256 baze.

## Release checklist

1. Ažurirati `update.json` (`version`, `url`, `sha256`).
2. Ažurirati `data/db_version.json` (`version`, `url`, `sha256`) ako je DB menjana.
3. Pokrenuti validaciju:

```bash
python3 scripts/validate_release_metadata.py
```

4. Ako ima schema promena, dodati novu SQL migraciju u `migrations/`.

## CI

GitHub Actions workflow (`.github/workflows/validate-release.yml`) automatski pokreće validaciju na push/pull request.
