#!/bin/bash
PIDFile="./.app_pid"
APPFILE="app.rb"
LOGFILE="err.txt"

#Default environment
export RACK_ENV=development

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

stop() {
	[[ -z "$PID" ]] && return

	CMD=$(ps -p $PID -o args=)
	if [[ $CMD = *"$APPFILE" ]]
	then
		echo -n "   Stopping server with pid $PID... "
		kill -15 $PID
		while $(kill -0 $PID 2>/dev/null); do
			sleep 1
		done
		echo -e "${BOLD}${GREEN}stopped.${NC}"
		rm $PIDFile
	else
		echo -e "   Process with pid ${BOLD}$PID${NC} not found"
	fi
}

start() {
	
	echo -n -e "   Starting server ${BOLD}$APPFILE in $RACK_ENV ${NC}mode... "
	ruby $APPFILE >> log.txt 2>> err.txt&
	PID=$!
	echo $PID > $PIDFile
	
	sleep 2
	[[ "$PID" ]] && CMD=$(ps -p $PID -o args=)
	if [[ $CMD = *"$APPFILE" ]]
	then
		echo -e "${BOLD}${GREEN}started with pid: $PID${NC}"
		tail -n 10 $LOGFILE | grep -e "Sinatra.*stage"
	else
		echo -e "Server is ${RED}not stated!${NC}"
		tail -n 10 $LOGFILE
	fi
	
}

read PID< $PIDFile

case "$1" in
	
	status)
		
		[[ "$PID" ]] && CMD=$(ps -p $PID -o args=)
		if [[ $CMD = *"$APPFILE" ]]
		then
			echo -e "Server is ${GREEN}running${NC}, PID: $PID"
			TAILF="-f"
		else
			echo -e "Server is ${RED}not running!${NC}"
			TAILF=""
		fi
		[[ $2 ]] && TAILN=$2 || TAILN=10
		tail $TAILF -n $TAILN $LOGFILE
		;;
	
	stop)
		stop
		;;
	
	test|production|development)
		export RACK_ENV=$1
		;&

	start|restart|"")
		if [ $2 ] 
		then
			export RACK_ENV=$2
		fi
		
		stop
		start
		;;
	
	*)
		echo -e "   Unknown command: $1"
		echo -e "   Usage: ${BOLD}$0 [start|restart [RACK_ENV]] [stop] [status [NUMBEROFLOGLINES]${NC}"
		echo -e "   Default: ${BOLD}$0 restart production${NC}"
esac

