#!/bin/bash

current_date=$(date +"%d/%b/%Y")

cat /var/log/apache2/access.log | grep  "${current_date}"  | grep -E -o  '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq -c
