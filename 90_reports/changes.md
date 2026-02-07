# Changes - Security, Accessibility & Code Quality Hardening (v1.2.0)

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
- 14 neue Tests: Accessibility (11), Security (1), Error-Handling (2)

## Risiken/HOLDs
- Keine
