# 📘 Wiki – Tag 3: Bash Scripting Vertiefung & SSH

## Bash Scripting – Vertiefung

### Datum formatieren
`$(date)` gibt ein langes Format aus mit Leerzeichen – ungeeignet für Dateinamen!

```bash
date                        # Thu Apr 16 17:16:17 CEST 2026  ❌ für Dateinamen
date +%Y-%m-%d              # 2026-04-16                      ✅ pro Tag
date +%Y-%m-%d_%H-%M-%S     # 2026-04-16_17-22-39            ✅ pro Ausführung
```

**Formatzeichen:**
| Zeichen | Bedeutung |
|---|---|
| `%Y` | Jahr (4-stellig) |
| `%m` | Monat |
| `%d` | Tag |
| `%H` | Stunde |
| `%M` | Minute |
| `%S` | Sekunde |

---

### Dateien zählen

```bash
ls ~/ordner | wc -l
```

- `wc` = **w**ord **c**ount
- `-l` = Zeilen zählen
- Kombiniert mit Pipe: zählt Dateien im Ordner

---

### Saubere Script-Struktur

Alle Pfade als Variablen am Anfang definieren:

```bash
#!/bin/bash

ZIELORDNER=~/backup/dateien
LOGORDNER=~/backup/logs
DATUM=$(date +%Y-%m-%d_%H-%M-%S)
ANZAHL=$(ls $ZIELORDNER | wc -l)
```

**Warum?**
- Absoluter Pfad → funktioniert egal wo du das Script aufrufst
- Variable → nur einmal ändern wenn sich Pfad ändert
- Kein relativer Pfad → keine unerwarteten Fehler

---

### Typische Fehler

**Leerzeichen bei Variablenzuweisung:**
```bash
DATUM = $(date)   # ❌ Leerzeichen verboten!
DATUM=$(date)     # ✅
```

**Falsches `$` nutzen:**
```bash
echo $(DATUM)    # ❌ $() ist für Befehle
echo $DATUM      # ✅ $ für Variablen
```

**Datum im Dateinamen:**
```bash
touch log_$(date).log      # ❌ Leerzeichen im Dateinamen!
touch log_$(date +%Y-%m-%d_%H-%M-%S).log   # ✅
```

---

### Script Speicherort

Scripts gehören **nicht** in Log- oder Daten-Ordner – saubere Trennung:

```
~/projekt/
    ├── scripts/    ← Scripts hier
    ├── logs/       ← Log-Dateien
    └── dateien/    ← Daten
```

---

## SSH (Secure Shell)

### Was ist SSH?
SSH = **S**ecure **Sh**ell

Verbindung zu einem entfernten Server – nur Text wird übertragen:

```
Dein Laptop                    Server
     │                            │
     │──── "ls -la" ────────────►│
     │                            │ führt aus
     │◄─── Ergebnis als Text ─────│
```

- Alles läuft auf dem Server
- Dein Laptop ist nur ein Fenster
- Funktioniert auch über schwache Verbindungen
- Verbindung ist verschlüsselt

---

### Key-Pair Authentifizierung

```
🔑 Private Key  →  bleibt auf deinem Laptop (NIEMALS weitergeben!)
🔓 Public Key   →  liegt auf dem Server / GitHub
```

- Server kennt deinen Public Key
- Beim Verbinden beweist dein Laptop mit dem Private Key dass er zusammengehört
- Kein Passwort nötig

**⚠️ Private Key verloren oder gestohlen:**
- Verloren → kein Zugriff mehr auf Server
- Gestohlen → jemand kann sich als du ausgeben → sofort Server-Zugriff entziehen!

---

### SSH Key erstellen

```bash
mkdir ~/.ssh
chmod 700 ~/.ssh          # Nur Besitzer darf rein!
ssh-keygen -t ed25519 -C "deine@email.de"
```

- Speicherort: einfach Enter (Standard `~/.ssh/id_ed25519`)
- Passphrase: für Lernzwecke leer, in Produktion immer setzen!

**Ergebnis:**
```
~/.ssh/
    ├── id_ed25519      # Private Key  (chmod 600 – nur du!)
    └── id_ed25519.pub  # Public Key   (darf jeder lesen)
```

**Aufbau des Public Keys:**
```
ssh-ed25519  AAAA...langer Key...  deine@email.de
│            │                     │
Algorithmus  Der eigentliche Key   Kommentar
```

---

### Public Key auf GitHub hinterlegen

1. `cat ~/.ssh/id_ed25519.pub` → kopieren
2. GitHub → Settings → SSH and GPG keys → **New SSH key**
3. Titel: Gerätename (z.B. "Windows Laptop")
4. Key einfügen → speichern

**Verbindung testen:**
```bash
ssh -T git@github.com
# Erwartete Ausgabe: "Hi Leif4556! You've successfully authenticated..."
```

Beim ersten Verbinden fragt Linux ob du dem Server vertraust → `yes` eingeben → wird in `~/.ssh/known_hosts` gespeichert.

---

### Repo auf SSH umstellen

```bash
git remote -v                          # Aktuelle URL anzeigen
git remote set-url origin git@github.com:USERNAME/repo.git
git remote -v                          # Prüfen ob es geklappt hat
```

**HTTPS vs SSH:**
| | HTTPS | SSH |
|---|---|---|
| Authentifizierung | Token | Key-Pair |
| URL | `https://github.com/...` | `git@github.com:...` |
| Token nötig | ✅ | ❌ |
| Empfohlen | ❌ | ✅ |

---

## Neue Befehle

| Befehl | Bedeutung |
|---|---|
| `wc -l` | Zeilen zählen |
| `ssh-keygen -t ed25519 -C "mail"` | SSH Key erstellen |
| `ssh -T git@github.com` | SSH Verbindung testen |
| `git remote -v` | Remote URL anzeigen |
| `git remote set-url origin URL` | Remote URL ändern |
