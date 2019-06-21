#!/bin/bash

WATCHLOG="./watch.log"
PIDFile="./.app_pid"
APPFILE="app.rb"

[ -f $PIDFile ] && read PID< $PIDFile

if [[ ! $PID ]]; then  
#	echo "$(date): No pid file - no work here."
	exit
fi

#echo "$(date) PID file found pid=$PID, checking the server is alive..."
CMD=$(ps -p $PID -o args=)
if [[ $CMD = *"$APPFILE" ]]; then 
#	echo "$(date): Server is alive - no work here"
	exit
fi

echo $(date)+": server failed, trying to restart..." >> $WATCHLOG
/bin/bash ./server.sh restart >> $WATCHLOG
