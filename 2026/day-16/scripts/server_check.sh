#!/bin/bash

service="nginx"

read -p "Do you want to check the status? (y/n):" answer

if [ "$answer" == "y" ]; then
	systemctl status "$service"
  if systemctl is-active --quiet "$service"; then
        echo "$service is active"
    else
        echo "$service is not active"
    fi
elif [ "$answer" = "n" ]; then
    echo "Skipped."
else
	echo "Invalid Input"
fi
