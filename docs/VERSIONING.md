# Versioning policy

## 1) Application version (`update.json.version`)

- Menjaj kada postoji nova verzija instalera.
- URL treba da sadrži istu verziju kao i `version` (npr. `...Setup_7.74.exe`).
- Ako URL koristi `releases/latest`, naziv fajla i dalje mora da nosi verziju radi kontrole konzistentnosti.

## 2) Database version (`data/db_version.json.version`)

- Integer koji raste na svaku smisleniju izmenu baze.
- Svako povećanje verzije treba da ima odgovarajuću SQL migraciju u `migrations/`.

## 3) Compatibility

- App i DB verzije su odvojene, ali release treba da navede minimalnu očekivanu DB verziju u release notes-u (van ovog repoa).

## 4) Checksums

- `sha256` vrednosti su obavezne pre release-a.
- Tokom pripreme release-a dozvoljeno je privremeno `TBD`, ali merge na glavnu granu treba da ima finalni hash.
