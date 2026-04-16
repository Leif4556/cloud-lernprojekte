#!/bin/bash

ZIELRORDNER=~/backup_v2/dateien
LOGORDNER=~/backup_v2/logs
DATUM=$(date +%Y-%m-%d_%H-%M-%S)
ANZAHL_DATEIEN=$(ls $ZIELRORDNER | wc -l)

touch $LOGORDNER/log_$DATUM.log
echo "Script lief am $DATUM" >> $LOGORDNER/log_$DATUM.log
echo "Es wurden $ANZAHL_DATEIEN Dateien erstellt" >> $LOGORDNER/log_$DATUM.log

cat $LOGORDNER/log_$DATUM.log
