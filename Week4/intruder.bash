#!/bin/bash

for i in {1..20}
do
curl --silent --output /dev/null 192.168.3.130/hellowworld.html
echo "${i}"
done
