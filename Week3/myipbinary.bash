#!bin/bash

ip=$(bash myip.bash)

myip1=$(echo "${ip}" | awk -F. '{ print $1 }')
myip2=$(echo "${ip}" | awk -F. '{ print $2 }')
myip3=$(echo "${ip}" | awk -F. '{ print $3 }')
myip4=$(echo "${ip}" | awk -F. '{ print $4 }')


ip1binary=$(echo "obase=2;$myip1" | bc)
ip2binary=$(echo "obase=2;$myip2" | bc)
ip3binary=$(echo "obase=2;$myip3" | bc)
ip4binary=$(echo "obase=2;$myip4" | bc)

echo "${ip1binary}""${ip2binary}""${ip3binary}""${ip4binary}"
