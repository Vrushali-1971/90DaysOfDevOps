#!/bin/bash

DIR="$1"

#Argument Validation
if [ -z "$DIR" ]; then
	echo "Please provide directory path"
	exit 1
fi

# Directory Validation
if [ ! -d "$DIR" ]; then
	echo "Directory does not exist"
	exit 1
fi
log_count=$(find "$DIR" -name '*.log' | wc -l)
total_errors=$(find "$DIR" -name "*.log" -exec grep -h  "ERROR" {} +  2>/dev/null | wc -l)

echo "The log files: $log_count"
echo "Total ERROR lines: $total_errors"


if [ "$total_errors" -gt 0 ]; then
	exit 1
else 
	exit 0
fi
