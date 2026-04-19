#!/bin/bash

if [ -d ~/cloud-lernprojekte ]; then
    echo "Ordner gefunden"
else
    echo "Ordner nicht gefunden"
fi


if [ -f ~/cloud-lernprojekte/README.md ]; then
    echo "README gefunden"
else
    echo "README nicht gefunden"
fi