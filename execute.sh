#!/bin/bash

function errorsend {
	if [ $# -gt 0 ]
	then
		echo $1 1>&2
	fi
	exit 1
}

function numeric {
	if ! [ $# -eq 1 ]
	then
		errorsend "Необходим 1 аргумент в numeric"
	else
		if [ $1 -eq $1 ] 2> /dev/null
		then
			return 0
		else
			return 1
		fi
	fi
}

function getarg {
	while [ $# -gt 0 ]; do
		case $1 in
			-t|--timeout)
			shift
			if [ $# -eq 0 ]; then
				errorsend "Укажите timeout"
			fi
			TIMEOUT=$1
			if ! numeric $TIMEOUT; then
				errorsend "Аргумент timeout не число"
			fi
			shift
			;;
			-p |--path)
			shift
			if [ $# -eq 0 ]; then
				errorsend "Укажите path"
			fi
			SCRIPT_PATH=$1

			if ! [ -f $SCRIPT_PATH ]; then
				errorsend "Не удалось найти $SCRIPT_PATH"
			fi
			shift 
			;;
			*)
			errorsend "Неизвестный аргумент $1"
			;;
		esac
	done

	if [ -z $TIMEOUT ]; then
		errorsend "Укажите timeout"
	fi

	if [ -z $SCRIPT_PATH ]; then
		errorsend "Укажите path"
	fi
}
function main {
	PID=-1
	START_TIMESTAMP=$(date +%s)
	LOGS_FILE="output_$START_TIMESTAMP.log"
	ERRORS_FILE="errors_$START_TIMESTAMP.log"

	while [ 0 -eq 0 ]; do
		if ! ps -p $PID > /dev/null 2>&1; then
			bash $SCRIPT_PATH 1>$LOGS_FILE 2>$ERRORS_FILE & 
			PID=$!
			echo "Pid: $PID"
		else
			echo "Запуск отложен"
		fi
		sleep $TIMEOUT
	done
}
getarg $@
main