# 📘 Wiki – Tag 6: Bash Vertiefung – if/else & Cronjobs

## if/else in Bash

### Grundstruktur

```bash
if [ Bedingung ]; then
    # tue etwas
else
    # tue etwas anderes
fi
```

- `then` statt `do` (wie bei for-Schleife)
- `fi` = Abschluss (if rückwärts)
- Leerzeichen vor `]` ist **Pflicht**!

### Wichtige Flags

| Flag | Bedeutung |
|---|---|
| `-d` | Prüft ob ein **Directory** existiert |
| `-f` | Prüft ob eine **Datei** existiert |

```bash
if [ -d ~/ordner ]; then
    echo "Ordner existiert"
fi

if [ -f ~/datei.txt ]; then
    echo "Datei existiert"
fi
```

### Logisches Und `&&`

```bash
if [ -d $ZIELORDNER ] && [ -d $LOGORDNER ]; then
    echo "Beide Ordner gefunden"
else
    echo "Einer der Ordner fehlt"
    exit 1
fi
```

### exit 1

Beendet das Script mit einem Fehler-Code:
```bash
exit 1   # Script mit Fehler beenden
exit 0   # Script erfolgreich beenden (Standard)
```

---

## Scripts absichern – Best Practices

Immer am Anfang prüfen ob alle benötigten Ordner/Dateien existieren:

```bash
#!/bin/bash

ZIELORDNER=~/backup/dateien
LOGORDNER=~/backup/logs
DATUM=$(date +%Y-%m-%d_%H-%M-%S)

if [ -d $ZIELORDNER ] && [ -d $LOGORDNER ]; then
    ANZAHL=$(ls $ZIELORDNER | wc -l)
    # ... rest des Scripts
else
    echo "Einer der Ordner fehlt"
    exit 1
fi
```

**Wichtig:** `ANZAHL` erst **innerhalb** der if-Prüfung berechnen – sonst gibt `ls` einen Fehler wenn der Ordner nicht existiert!

---

## Cronjobs

Ein Cronjob führt Scripts **automatisch zu geplanten Zeiten** aus.

### Crontab verwalten

```bash
crontab -e    # Crontab bearbeiten (öffnet Editor)
crontab -l    # Aktuelle Cronjobs anzeigen
crontab -r    # Alle Cronjobs löschen
```

### Syntax

```
* * * * * /pfad/zum/script.sh
│ │ │ │ │
│ │ │ │ └── Wochentag (0-7, 0=Sonntag)
│ │ │ └──── Monat (1-12)
│ │ └────── Tag des Monats (1-31)
│ └──────── Stunde (0-23)
└────────── Minute (0-59)
```

`*` = jeden/jede

### Beispiele

| Crontab Eintrag | Bedeutung |
|---|---|
| `0 2 * * * /script.sh` | Jeden Tag um 2:00 Uhr |
| `0 * * * * /script.sh` | Jede Stunde |
| `*/5 * * * * /script.sh` | Alle 5 Minuten |
| `0 2 * * 1 /script.sh` | Jeden Montag um 2:00 Uhr |
| `0 2 1 * * /script.sh` | Am 1. jeden Monats um 2:00 Uhr |

### Wichtig: Immer absoluten Pfad nutzen!

```bash
# ❌ Falsch – Cronjob weiß nicht wo du bist
0 2 * * * ./backup.sh

# ✅ Richtig – absoluter Pfad
0 2 * * * ~/cloud-lernprojekte/backup.sh
```

### nano Shortcuts (für crontab -e)

| Shortcut | Bedeutung |
|---|---|
| `Strg+O` | Speichern |
| `Strg+X` | Beenden |
| `Strg+W` | Suchen |

---

## Q1 Abgeschlossen! ✅

| Thema | Status |
|---|---|
| Linux Grundlagen & Navigation | ✅ |
| Dateiberechtigungen & chmod | ✅ |
| Bash Scripting – Variablen, Schleifen, Arrays | ✅ |
| Bash Scripting – if/else, Cronjobs | ✅ |
| Prozesse & Pipes | ✅ |
| Netzwerk-Basics – DNS, IP, Subnetting, HTTP/S | ✅ |
| SSH & Key-Pair Authentifizierung | ✅ |
| Git – Commit, Push, Pull, Branching, Merge, Rebase | ✅ |
