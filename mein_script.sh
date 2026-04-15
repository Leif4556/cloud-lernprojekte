#!/bin/bash

NAME="Leif"
DATUM=$(date)

echo "Hallo $NAME!"
echo "Heute ist: $DATUM"
echo "Du bist in: $(pwd)"


for i in {1..5}; do
    echo "Backup $i von 5"
done