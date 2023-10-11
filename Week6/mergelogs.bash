#!/bin/bash

logs="/var/log/apache2/"

mergedlogs=$((ls "${logs}") | grep "access.log" | grep -v "other_vhost" | grep -v "error")

for i in ${mergedlogs}
do
cat  "${logs}${i}" >> mergedlogs.txt
done


