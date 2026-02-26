# Plan: script.js aufteilen (366 → max 300 Zeilen pro Datei)

## Context

`script.js` hat 366 Zeilen und überschreitet das 300-Zeilen-Limit. Die App ist Vanilla JS ohne Bundler und nutzt `file://` Protokoll für Tests — daher keine ES-Module möglich. Aufteilung über mehrere `<script>`-Tags mit geteiltem Global Scope.

## Aufteilung (4 Dateien)

### 1. `qr-core.js` (~86 Zeilen)
- DOM-Element-Referenzen (Zeilen 1-21)
- Konstanten (Zeilen 23-27)
- State-Variablen (`currentTab`, `uploadedLogo`)
- Error-Display: `showError()`, `clearError()`
- Input-Sanitization: `sanitizeInput()`, `escapeWifiField()`
- File-Validierung: `validateImageFile()`, `validateImageDimensions()`

### 2. `qr-tabs.js` (~56 Zeilen)
- `initTabs()` — Tab-Initialisierung mit Keyboard-Navigation
- `activateTab()` — Tab-Aktivierung

### 3. `qr-renderer.js` (~108 Zeilen)
- Input-Extraktion: `getTextInput()`, `getWifiInput()`, `getDesignTabInput()`, `getInputText()`
- QR-Rendering: `createQRMatrix()`, `renderToCanvas()`, `drawLogo()`

### 4. `qr-app.js` (~113 Zeilen)
- `generateQRCode()` — Hauptfunktion
- Alle Event-Listener (Generate, Enter-Key, Logo-Upload, Logo-Size, Gradient, Download)

## Änderungen

| Datei | Aktion |
|-------|--------|
| `qr-core.js` | NEU — DOM, Konstanten, Validation |
| `qr-tabs.js` | NEU — Tab-Logik |
| `qr-renderer.js` | NEU — Input + Rendering |
| `qr-app.js` | NEU — App-Logik + Events |
| `script.js` | LÖSCHEN |
| `index.html` | `<script src="script.js">` ersetzen durch 4 `<script>`-Tags (Reihenfolge wichtig!) |
| `00_infos/llm-context.md` | Strukturkonventionen aktualisieren, Version bump |

### Script-Reihenfolge in index.html
```html
<script src="qr-core.js"></script>
<script src="qr-tabs.js"></script>
<script src="qr-renderer.js"></script>
<script src="qr-app.js"></script>
```

## Verifizierung

1. Tests ausführen: `source venv/bin/activate && pytest 87_tests/e2e/test_qr_code_ui.py -v`
2. Alle 47 Tests müssen grün sein
3. Keine Datei über 300 Zeilen: `wc -l qr-*.js`
