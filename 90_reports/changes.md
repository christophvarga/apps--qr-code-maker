# Changes - QR Code Maker

## [2026-02-07] Post-Audit Cleanup (v1.2.2)

### Aenderungen
- **Legacy-Tests entfernt**: 5 veraltete Root-Level Testdateien entfernt (test_qr_generator.py, test_wlan_visual.py, test_ecc_pixel.py, test_high_pixel.py, test_fix_verification.py). Diese waren nach dem Security/A11y-Refactoring nicht mehr funktional (erwarteten alert() statt inline errors, falscher ECC-Default, hardcoded localhost, headless=False).
- **nginx.conf Security-Headers**: X-Frame-Options und Referrer-Policy in location-Bloecken ergaenzt (nginx add_header Vererbung ist nicht additiv -- location-Block-Headers ersetzen Server-Level-Headers).
- **docker-compose.yml**: Deprecated `version` Key entfernt (Docker Compose V2).
- **Test-Report korrigiert**: TestAccessibility Zaehlerfehler behoben (10, nicht 11 Tests).
- **coverage.md erstellt**: Fehlender Report nach Workflow-Standard.
- **llm-context.md**: Version auf 1.2.2 gebumpt.

### Entfernte Dateien
- `test_qr_generator.py` (Legacy, broken)
- `test_wlan_visual.py` (Legacy, broken)
- `test_ecc_pixel.py` (Legacy, broken)
- `test_high_pixel.py` (Legacy, broken)
- `test_fix_verification.py` (Legacy, broken)

### Geaenderte Dateien
- `nginx.conf` - Security-Headers in location-Bloecken
- `docker-compose.yml` - version Key entfernt
- `90_reports/test-report.md` - Zaehlerfehler behoben
- `90_reports/coverage.md` - Neu erstellt
- `90_reports/changes.md` - Aktualisiert
- `00_infos/llm-context.md` - v1.2.2

### Tests
- 47 Tests, alle bestanden (keine Aenderung an Testcode)

### Risiken/HOLDs
- Keine

---

## [2026-02-07 22:06] Session 20260207-220631

### Commits
bd8713f feat(security,a11y,refactor): harden app with input validation, ARIA, and code quality improvements; bump v1.2.0

### Staged Changes
- Keine staged Changes

### Unstaged Changes
00_infos/llm-context.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---
## Datum: 07.02.2026

## Aenderungen

### Security Fixes
- **Input-Sanitization**: Max-Length Validierung (4296 Zeichen) fuer QR-Text, 32/63 Zeichen fuer SSID/Passwort
- **WiFi-Format-Escaping**: Sonderzeichen (`;`, `\`, `:`, `"`) in SSID/Passwort werden per Backslash escaped
- **File-Upload-Validierung**: 5MB Groessenlimit, MIME-Type-Pruefung (PNG/JPG/GIF/WebP), Dimensions-Check (4096px max)
- **SRI-Hash**: Subresource Integrity auf CDN-Link fuer qrcode-generator@1.4.4
- **CSP Meta-Tag**: Content Security Policy in index.html (script-src, style-src, font-src, img-src)
- **noscript Fallback**: Hinweis wenn JavaScript deaktiviert

### Accessibility
- **ARIA-Attribute**: `role="tablist"`, `role="tab"`, `role="tabpanel"`, `aria-selected`, `aria-controls`, `aria-labelledby`
- **Keyboard-Navigation**: Pfeiltasten (Links/Rechts/Hoch/Runter) plus Home/End zwischen Tabs
- **Canvas-Accessibility**: `aria-label="Generierter QR-Code"` und `role="img"` auf Canvas
- **prefers-reduced-motion**: CSS Media Query die alle Animationen deaktiviert
- **alert() ersetzt**: Durch inline Error-Messages (div mit `role="alert"` und `aria-live="assertive"`)
- **Farbkontrast verbessert**: Subtitle (#555 statt #666), Tab-Text (#475569 statt #64748b), Download-Button (#064e2c)
- **Focus-Visible**: Sichtbarer Fokus-Ring fuer Keyboard-Navigation auf Buttons und Tabs

### Code-Refactoring
- **generateQRCode() aufgeteilt**: In `getInputText()`, `createQRMatrix()`, `renderToCanvas()`, `drawLogo()`, plus `showError()`/`clearError()`
- **Error-Handling**: try-catch um Canvas-Operationen, FileReader, und Download
- **Inline-Styles entfernt**: 4 inline Styles nach CSS verschoben (`.color-label`, `.logo-name-display`)
- **Doppelten Font-Import entfernt**: Nur noch in HTML (CSS @import entfernt)

### Docker-Optimierung
- **Health-Check**: In Dockerfile (`HEALTHCHECK` Directive) und docker-compose.yml
- **Custom nginx.conf**: Gzip-Kompression, Caching-Headers (7d/30d), Security-Headers, `/health` Endpoint

### Dokumentation
- **open-questions.md** erstellt (HOLD-Template)
- **llm-context.md** aktualisiert auf v1.2.0

### Neue Dateien
- `nginx.conf` - Custom Nginx-Konfiguration
- `00_infos/meta/open-questions.md` - HOLD-Template

### Geaenderte Dateien
- `index.html` - ARIA, SRI, CSP, noscript, Inline-Styles entfernt
- `script.js` - Security, Accessibility, Refactoring
- `styles.css` - prefers-reduced-motion, Kontrast, Font-Import-Dedup, neue CSS-Klassen
- `Dockerfile` - Custom nginx.conf, HEALTHCHECK
- `docker-compose.yml` - Health-Check Konfiguration
- `87_tests/e2e/test_qr_code_ui.py` - 14 neue Tests (Accessibility, Security, Error-Handling)
- `00_infos/llm-context.md` - Version 1.2.0
- `90_reports/test-report.md` - Aktualisiert
- `90_reports/changes.md` - Aktualisiert

## Tests
- 47 Tests total (vorher 33), alle bestanden
- 14 neue Tests: Accessibility (10), Security (1), Error-Handling (2), Canvas A11y (1)

## Risiken/HOLDs
- Keine
