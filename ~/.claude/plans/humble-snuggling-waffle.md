# Analyse: QR Code Maker - Zustand, Luecken & Verbesserungspotential

## Context

Die App ist als "FEATURE-COMPLETE" markiert (v1.1.0). Sie funktioniert, hat gute Tests und CI/CD. Aber es gibt signifikante Luecken in **Security**, **Accessibility** und **Code-Qualitaet**, die fuer eine produktionsreife App adressiert werden sollten. Diese Analyse dient als Entscheidungsgrundlage: Was ist der Ist-Zustand, wo sind die Luecken, was lohnt sich zu verbessern?

---

## Ist-Zustand (Gesamtbewertung: 6.4/10)

| Kategorie | Score | Bewertung |
|-----------|-------|-----------|
| Tests | 9/10 | Exzellent - 50+ E2E-Tests, 5 Suites |
| CI/CD | 8/10 | Sehr gut - Woodpecker + GitHub Actions |
| Docker | 8/10 | Sehr gut - Nginx Alpine, Traefik-Labels |
| Code-Organisation | 7/10 | Gut - 849 Zeilen, klar strukturiert |
| Performance | 7/10 | Gut - Minimale Dependencies |
| Dokumentation | 5/10 | Lueckenhaft - Kein README |
| **Security** | **4/10** | **Handlungsbedarf** |
| **Accessibility** | **3/10** | **Schlecht - WCAG AA Fail** |

---

## Luecken & Verbesserungspotential

### Prioritaet 1: Security (4/10 -> Ziel: 8/10)

**Kritische Luecken:**

1. **Keine Input-Sanitization** (`script.js`)
   - User-Input wird direkt an QR-Generator weitergereicht
   - `text = qrText.value.trim()` ohne jegliche Validierung

2. **WiFi-Format-Injection** (`script.js`)
   - Sonderzeichen (`;`, `\`, `:`) in SSID/Passwort werden nicht escaped
   - `WIFI:T:${security};S:${ssid};P:${password};H:false;;` bricht bei Sonderzeichen

3. **File-Upload ohne Validierung** (`script.js`)
   - Keine Dateigroessen-Limits (Memory-Risiko)
   - Keine echte MIME-Type-Pruefung
   - Keine Bild-Dimensions-Validierung

4. **CDN ohne SRI** (`index.html`)
   - `qrcode-generator@1.4.4` via jsDelivr ohne Subresource-Integrity-Hash
   - Bei CDN-Kompromittierung: XSS-Risiko

5. **Kein CSP-Header**
   - Weder als Meta-Tag noch in Nginx-Config

**Fix-Aufwand:** ~2-3h, alle Fixes in `script.js`, `index.html`, ggf. Nginx-Config

---

### Prioritaet 2: Accessibility (3/10 -> Ziel: 7/10)

**Kritische Luecken:**

1. **Keine ARIA-Attribute** auf Tab-Controls
   - Fehlt: `role="tablist"`, `role="tab"`, `aria-selected`, `aria-controls`

2. **Keine Keyboard-Navigation** zwischen Tabs
   - Nur Tab-Key funktioniert, keine Pfeiltasten

3. **Canvas nicht zugaenglich**
   - Kein `aria-label`, kein Alternativtext fuer generierten QR-Code

4. **`prefers-reduced-motion` ignoriert**
   - Endlos-Animation `gradientBG` laeuft immer (auch Batterie-Problem)

5. **`alert()` fuer Fehlermeldungen**
   - Blockiert Screen Reader, schlechte UX

6. **Farbkontrast ungeprueft**
   - Gradient-Text koennte WCAG AA verfehlen

**Fix-Aufwand:** ~3-4h, Aenderungen in `index.html`, `styles.css`, `script.js`

---

### Prioritaet 3: Code-Qualitaet (7/10 -> Ziel: 9/10)

1. **`generateQRCode()` ist 114 Zeilen** - sollte in 4-5 kleinere Funktionen zerlegt werden
2. **Kein Error-Handling** - Keine try-catch Blocks um Canvas-Operationen
3. **FileReader ohne Error-Handler**
4. **Inline-Styles in HTML** (Zeilen 56, 61, 71, 82) - gehoeren in CSS
5. **Font-Import doppelt** - Sowohl in HTML als auch CSS
6. **Kein `<noscript>` Fallback**

**Fix-Aufwand:** ~2h

---

### Prioritaet 4: Dokumentation (5/10 -> Ziel: 8/10)

1. **Kein README.md** - Grundlegende Projektbeschreibung fehlt
2. **Kein CHANGELOG**
3. **`open-questions.md` existiert nicht** (aus Template erwartet)

**Fix-Aufwand:** ~30min

---

### Prioritaet 5: Tests - Fehlende Edge Cases

Tests sind bereits gut (9/10), aber es fehlen:

1. **XSS-Injection-Tests** - Boesartige Inputs testen
2. **WiFi-Sonderzeichen-Tests** - `;`, `\`, `:` in SSID/Passwort
3. **File-Upload-Grenzen** - Uebergrosse Dateien, falsche MIME-Types
4. **`prefers-reduced-motion`-Test**

**Fix-Aufwand:** ~1-2h

---

### Prioritaet 6: Docker/Deployment (Minor)

1. **Kein Health-Check** in Dockerfile/Compose
2. **Nginx Default-Config** - Koennte optimiert werden (Caching-Headers, Gzip)

**Fix-Aufwand:** ~30min

---

## Empfohlene Reihenfolge

| # | Bereich | Aufwand | Impact |
|---|---------|---------|--------|
| 1 | Security Fixes | ~2-3h | Hoch |
| 2 | Accessibility | ~3-4h | Hoch |
| 3 | Code-Refactoring | ~2h | Mittel |
| 4 | Fehlende Tests | ~1-2h | Mittel |
| 5 | Dokumentation | ~30min | Niedrig |
| 6 | Docker-Optimierung | ~30min | Niedrig |

**Gesamt geschaetzter Aufwand: ~10-12h**

---

## Betroffene Dateien

| Datei | Aenderungen |
|-------|-------------|
| `script.js` | Input-Sanitization, WiFi-Escaping, Error-Handling, Refactoring |
| `index.html` | ARIA-Attribute, SRI-Hash, noscript, Inline-Styles entfernen |
| `styles.css` | prefers-reduced-motion, Kontrast-Fixes, doppelten Font-Import entfernen |
| `Dockerfile` | Health-Check |
| `docker-compose.yml` | Health-Check |
| `87_tests/e2e/test_qr_code_ui.py` | Neue Security/A11y-Tests |
| `00_infos/meta/open-questions.md` | Erstellen (Template) |

---

## Naechster Schritt

Diese Analyse ist rein diagnostisch. Der User entscheidet, welche Prioritaeten angegangen werden sollen. Jeder Bereich kann unabhaengig implementiert werden.
