# 📘 Wiki – Tag 2: Linux Grundlagen & Bash Scripting

## Navigation & Dateisystem

| Befehl | Bedeutung | Beispiel |
|---|---|---|
| `pwd` | Aktuellen Pfad anzeigen | `/home/leif` |
| `cd` | Ordner wechseln | `cd ~/übungen` |
| `cd ..` | Einen Ordner höher | |
| `cd ~` | Home-Verzeichnis | `/home/leif` |
| `ls` | Ordnerinhalt anzeigen | |
| `ls -l` | Mit Details | Rechte, Größe, Datum |
| `ls -a` | Auch versteckte Dateien | Dateien mit `.` am Anfang |
| `ls -la` | Beides zusammen | |

**`~` ist eine Abkürzung für `/home/leif`** – spart Tipparbeit.

---

## Dateien & Ordner

| Befehl | Bedeutung | Beispiel |
|---|---|---|
| `mkdir ordner` | Ordner erstellen | |
| `mkdir -p a/b/c` | Ordner + Unterordner auf einmal | |
| `touch datei.txt` | Leere Datei erstellen | |
| `cp quelle ziel` | Kopieren | `cp datei.txt backup.txt` |
| `mv quelle ziel` | Verschieben oder Umbenennen | `mv datei.txt ordner/` |
| `rm datei.txt` | Datei löschen | ⚠️ Kein Papierkorb! |
| `rm -r ordner` | Ordner + Inhalt löschen | |

**mv Varianten:**
```bash
mv datei.txt neuer_name.txt          # Umbenennen
mv datei.txt ordner/                 # Verschieben
mv datei.txt ordner/neuer_name.txt   # Beides zusammen
```

---

## Berechtigungen (Permissions)

### Ausgabe verstehen
```
-rw-r--r-- 1 leif leif 0 Apr 15 16:10 datei.txt
```

| Teil | Bedeutung |
|---|---|
| `-rw-r--r--` | Berechtigungen |
| `leif leif` | Besitzer & Gruppe |
| `0` | Dateigröße |
| `Apr 15 16:10` | Änderungsdatum |

### Berechtigungen aufdröseln
```
rw- r-- r--
│   │   └── Alle anderen
│   └────── Gruppe
└────────── Besitzer
```

**r** = read (lesen), **w** = write (schreiben), **x** = execute (ausführen)

### chmod – Berechtigungen ändern
**chmod = change mode**

```bash
chmod 755 datei.txt   # rwxr-xr-x
chmod 644 datei.txt   # rw-r--r--
chmod 600 datei.txt   # rw-------
chmod +x  datei.txt   # Ausführbar machen
```

**Zahlen verstehen:**
| Zahl | Bedeutung |
|---|---|
| 7 | rwx (4+2+1) |
| 6 | rw- (4+2+0) |
| 5 | r-x (4+0+1) |
| 4 | r-- (4+0+0) |

### Gruppen
Mehrere Benutzer können in einer Gruppe sein und bekommen dann dieselben Rechte auf Dateien.
```bash
groups   # Eigene Gruppen anzeigen
```

---

## Dateiinhalt

| Befehl | Bedeutung |
|---|---|
| `cat datei.txt` | Inhalt anzeigen |
| `echo "Text"` | Text ausgeben |
| `echo "Text" > datei.txt` | Text in Datei schreiben (überschreibt!) |
| `echo "Text" >> datei.txt` | Text anhängen (nicht überschreiben) |

⚠️ **Wichtig:** `>` überschreibt, `>>` hängt an!

---

## In Dateien suchen

```bash
grep "Wort" datei.txt      # Groß-/Kleinschreibung beachten
grep -i "wort" datei.txt   # Groß-/Kleinschreibung ignorieren
grep "ERROR" server.log    # Fehler in Log-Dateien finden
```

**Linux ist case-sensitive:** `Cloud` ≠ `cloud`

---

## Prozesse

```bash
ps aux                  # Alle Prozesse anzeigen
ps aux | grep bash      # Gefiltert nach "bash"
top                     # Live-Ansicht (q zum Beenden)
kill 1234               # Prozess mit PID 1234 beenden
sleep 30 &              # Prozess im Hintergrund starten
```

**Ausgabe von ps aux:**
```
leif  597  0.0  0.0  3124  S  sleep 30
│     │    │    │         │  └── Befehl
│     │    │    │         └───── Status
│     │    │    └─────────────── RAM
│     │    └──────────────────── CPU
│     └───────────────────────── PID (Prozess-ID)
└─────────────────────────────── Besitzer
```

---

## Pipe `|`

Der Output von Befehl 1 wird Input von Befehl 2 – beliebig verkettbar.

```bash
ps aux | grep bash              # Prozesse filtern
ps aux | grep bash | grep -v grep   # grep selbst ausblenden
```

---

## Bash Scripting

### Aufbau einer .sh Datei
**.sh = Shell Script** – eine Textdatei mit Linux-Befehlen die nacheinander ausgeführt werden.

```bash
#!/bin/bash          # Shebang – immer erste Zeile!
                     # /bin/bash = Pfad zur Bash (auf jedem Linux gleich)

echo "Hallo Welt"
```

**Script ausführen:**
```bash
chmod +x mein_script.sh   # Ausführbar machen (einmalig)
./mein_script.sh          # Ausführen
bash mein_script.sh       # Alternativ (ohne chmod)
```

### Variablen

```bash
NAME="Leif"               # Direkt zuweisen
DATUM=$(date)             # Output eines Befehls speichern

echo "Hallo $NAME"        # Variable nutzen
echo "Heute: $DATUM"
```

**`$` bedeutet immer "Wert von":**
| Schreibweise | Bedeutung |
|---|---|
| `$NAME` | Wert einer Variable |
| `$(date)` | Output eines Befehls |
| `$1, $2` | Argumente ans Script |

### Schleifen

**Liste:**
```bash
for i in 1 2 3 4 5; do
    echo "Durchlauf $i"
done
```

**Zahlenbereich:**
```bash
for i in {1..5}; do
    echo "Backup $i von 5"
done
```

**Variable als Liste:**
```bash
DATEIEN="server.log app.log error.log"
for DATEI in $DATEIEN; do
    echo "Erstelle $DATEI"
    touch $DATEI
done
```

**Array:**
```bash
DATEIEN=("server.log" "app.log" "error.log")
for DATEI in "${DATEIEN[@]}"; do
    touch $DATEI
done
```

| | Liste | Array |
|---|---|---|
| Definition | `DATEIEN="a b c"` | `DATEIEN=("a" "b" "c")` |
| Zugriff | `$DATEIEN` | `${DATEIEN[@]}` |
| Ein Element | ❌ | `${DATEIEN[0]}` |

---

## Backup Script (Q1 Projekt Basis)

```bash
#!/bin/bash

QUELLE=~/übungen/tag2
ZIEL=~/backups
DATUM=$(date +%Y-%m-%d)

echo "=== Backup startet: $DATUM ==="

mkdir -p $ZIEL
cp -r $QUELLE $ZIEL/backup-$DATUM

echo "=== Backup abgeschlossen! ==="
echo "Gespeichert in: $ZIEL/backup-$DATUM"
ls $ZIEL
```

---

## Befehls-Übersicht (Abkürzungen)

| Befehl | Steht für |
|---|---|
| `chmod` | change mode |
| `chown` | change owner |
| `mkdir` | make directory |
| `rm` | remove |
| `cp` | copy |
| `mv` | move |
| `pwd` | print working directory |
| `ls` | list |
| `cd` | change directory |
