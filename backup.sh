#!/bin/bash

QUELLE=~/übungen/tag2
ZIEL=~/backups
DATUM=$(date +%Y-%m-%d)

echo "=== Backup startet: $DATUM ==="

# Backuo-Ordner erstellen
mkdir -p $ZIEL

# Dateien kopieren
cp -r $QUELLE $ZIEL/backup-$DATUM

echo "=== Backup abgeschlossen! ==="
echo "Gespeichert in: $ZIEL/backup-$Datum"

ls $ZIEL