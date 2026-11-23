#!/bin/bash

read -p "Enter the file name:" file

if [ -f "$file" ]; then 
	echo "File exists"
else 
	echo "File does not exist"
fi
