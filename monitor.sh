#!/bin/bash

ZIELRORDNER=~/monitor/logs
DATUM=$(date +%Y-%m-%d_%H-%M-%S)
USER=$(whoami)
DIRECTORY=$(pwd)

if [ ! -d $ZIELRORDNER ]; then
    mkdir -p $ZIELRORDNER
fi

touch $ZIELRORDNER/Log_$DATUM.log
echo $DATUM >> $ZIELRORDNER/Log_$DATUM.log
echo $USER >> $ZIELRORDNER/Log_$DATUM.log
echo $DIRECTORY >> $ZIELRORDNER/Log_$DATUM.log
cat $ZIELRORDNER/Log_$DATUM.log