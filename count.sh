#!/bin/bash

function errorsend {
	if [ $# -gt 0 ]
	then
		echo $1 1>&2
	fi
	exit 1
}
if ! [ -d "$1" ]; then
	errorsend "Укажите путь до проекта"
fi

if ! [ $# -eq 1 ]; then
	errorsend "Передайте 1 аргумент"
fi

CNT=0

while read f; do
	CNT=$((CNT + $(cat "$f" | sed '/^\s*$/d' | grep -c '')))
done <<< $(find "$1" -name "*.c" -o -name "*.h")
echo $CNT