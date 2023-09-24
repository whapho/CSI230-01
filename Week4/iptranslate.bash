#!/bin/bash

input_file="/home/mgerew/CSI230-01/Week3/ip_addresses.txt"
output_file="possibleips.txt"

if [ ! -f "$input_file" ]; then
	echo "Error: File not found."
	exit 1
fi

> "$output_file"

while read -r binary_ip; do
	# remove spaces from the binary ip
	binary_ip="$(echo "$binary_ip" | tr -d ' ')"

	octet1="${binary_ip:0:8}"
	octet2="${binary_ip:8:8}"
	octet3="${binary_ip:16:8}"
	octet4="${binary_ip:24:8}"

	decimaloctet1=$(echo "ibase=2; $octet1" | bc)
	decimaloctet2=$(echo "ibase=2; $octet2" | bc)
	decimaloctet3=$(echo "ibase=2; $octet3" | bc)
	decimaloctet4=$(echo "ibase=2; $octet4" | bc)


	decimal_ip="$decimaloctet1.$decimaloctet2.$decimaloctet3.$decimaloctet4"

	echo "${decimal_ip}" >> "$output_file"
done < "$input_file"
