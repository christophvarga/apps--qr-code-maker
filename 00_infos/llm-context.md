# QR Code Maker - LLM Context

> Version: 1.2.10
> Stand: 07.02.2026
> Status: **FEATURE-COMPLETE**

## Ziel & Scope

Lokales QR-Code-Generator-Tool als standalone Web-App. Laeuft komplett client-side (Vanilla JS), keine Server-Komponente noetig. Generiert QR-Codes fuer Text/URLs und WLAN-Zugangsdaten mit umfangreichen Anpassungsmoeglichkeiten (Farben, Logos, Groessen).

**Zielgruppe:** Lokale Nutzung, kein Deployment vorgesehen.

## Implementierte Features

| Feature | Status |
|---------|--------|
| Text/URL QR-Codes | Fertig |
| WLAN QR-Codes (SSID, Passwort, Verschluesselung) | Fertig |
| Error Correction Levels (L/M/Q/H) | Fertig |
| Output-Groessen (256/400/512/800px) | Fertig |
| Farbanpassung (Vorder-/Hintergrund) | Fertig |
| Farbverlauf mit Toggle | Fertig |
| Logo-Integration (5-30%) | Fertig |
| Download als PNG | Fertig |
| Responsive Glassmorphism-UI | Fertig |
| Input-Sanitization & WiFi-Escaping | Fertig (v1.2.0) |
| File-Upload-Validierung (5MB, Typ, Dimensions) | Fertig (v1.2.0) |
| CSP Meta-Tag & SRI-Hash | Fertig (v1.2.0) |
| ARIA-Attribute & Keyboard-Navigation | Fertig (v1.2.0) |
| Inline Error-Messages (statt alert()) | Fertig (v1.2.0) |
| prefers-reduced-motion Support | Fertig (v1.2.0) |
| Docker Health-Check & Nginx-Optimierung | Fertig (v1.2.0) |

## Tech Stack

- **Frontend:** Vanilla JS (ES6+), HTML5, CSS3
- **QR-Library:** qrcode-generator@1.4.4 (CDN, SRI-gesichert)
- **Fonts:** Google Fonts - Outfit
- **Tests:** Playwright (Python) - 8 Testklassen, 47 Tests
- **CI/CD:** Woodpecker CI (Auto-Merge) + GitHub Actions (Deploy)
- **Container:** Nginx Alpine mit Custom-Config (Gzip, Caching, Health-Endpoint)

## STOP/HOLD/ASK/CONFIRM

- **STOP:** Keine aktiven STOPs.
- **HOLD:** Keine offenen HOLDs (siehe `00_infos/meta/open-questions.md`).
- **ASK:** Bei neuen Features oder groesseren Aenderungen.
- **CONFIRM:** Bei Aenderungen am Design System.

## Tests & Reports

**Gruen bedeutet:**
- Alle 47 Playwright-Tests bestanden (8 Testklassen)
- Core-Funktionalitaet, Edge Cases, Visual Rendering, Accessibility, Security abgedeckt

**Testausfuehrung:**
```bash
# Setup (einmalig)
pip install -r requirements.txt && playwright install chromium

# Tests ausfuehren
pytest 87_tests/ -v

# Oder via Make
make install   # Setup
make test      # Tests ausfuehren
make test-report  # Tests mit JUnit/Coverage-Artefakten
```

## Strukturkonventionen

- `index.html`, `script.js`, `styles.css` - Hauptanwendung (Root-Level, da standalone Tool)
- `nginx.conf` - Custom Nginx-Konfiguration (Gzip, Caching, Health-Endpoint)
- `00_infos/` - Dokumentation und Kontext
- `87_tests/e2e/test_qr_code_ui.py` - Core UI Tests (PageLoad, Tabs, Accessibility, Text/URL)
- `87_tests/e2e/test_qr_code_features.py` - Feature Tests (WLAN, Design, Settings, Regeneration)
- `87_tests/conftest.py` - Test-Fixtures
- `requirements.txt` - Test-Dependencies (Playwright, pytest)
- `Makefile` - Build-Targets (install, test, test-report)
- `venv/` - Python Virtual Environment fuer Tests

## Security

- **CSP:** Content Security Policy via Meta-Tag (script-src self + jsdelivr, style-src self + googleapis)
- **SRI:** Subresource Integrity Hash auf qrcode-generator CDN-Script
- **Input-Validierung:** Max-Length auf Textfeldern, WiFi-Sonderzeichen-Escaping
- **File-Upload:** 5MB Limit, MIME-Type-Pruefung, Dimensions-Check (4096px max)
- **Error-Handling:** try-catch um Canvas-Ops, FileReader, Download
