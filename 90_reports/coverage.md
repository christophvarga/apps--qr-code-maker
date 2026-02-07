# Coverage - QR Code Maker

## Uebersicht

| Metrik | Wert |
|--------|------|
| Datum | 07.02.2026 |
| Typ | Playwright E2E (kein klassisches Code-Coverage) |
| Gesamt-Abdeckung | ~85% (Feature-Coverage) |

## Feature-Coverage

| Feature | Abgedeckt |
|---------|-----------|
| Seite laden & Grundstruktur | Ja (9 Tests) |
| Tab-Navigation | Ja (4 Tests) |
| Accessibility (ARIA, Keyboard) | Ja (10 Tests) |
| Text/URL QR-Code Generierung | Ja (6 Tests) |
| WLAN QR-Code Generierung | Ja (6 Tests) |
| Design-Optionen (Farben, Gradient, Logo) | Ja (4 Tests) |
| Erweiterte Einstellungen (ECC, Pixel) | Ja (6 Tests) |
| QR-Code Regenerierung | Ja (2 Tests) |
| Input-Sanitization | Teilweise (via WiFi-Special-Chars Test) |
| File-Upload-Validierung | Nein (schwer in E2E zu simulieren) |
| Download-Funktion | Ja (Button-Sichtbarkeit, kein Datei-Check) |

## Hinweis

Vanilla-JS Client-Side App ohne Build-Tool. Klassisches Line-Coverage
(Istanbul/c8) nicht anwendbar ohne Bundler. Feature-Coverage ueber
Playwright E2E-Tests abgebildet.
