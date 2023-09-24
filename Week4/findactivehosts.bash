#!/bin/bash

input_file="/home/mgerew/CSI230-01/Week4/possibleips.txt"
output_file="activehosts.txt"

if [ ! -f "$input_file" ]; then
        echo "Error: File not found."
        exit 1
fi

> "$output_file"

while read -r ip; do
        result=$(ping -c 1 "$ip" | grep -E "1 packets transmitted, 1 received")

	if [[ -n "$result" ]]; then
		echo "$ip" >> "$output_file"
	fi
done < "$input_file"


