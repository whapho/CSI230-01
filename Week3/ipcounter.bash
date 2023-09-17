#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <IP address> <Prefix>"
	exit 1
fi

# Validate IP and store octets
ip="$1"
octets=()

if [[ "${ip}" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
	IFS='.' read -r -a octets <<< "$ip"
else
	echo "Invalid IP address."
	exit 1
fi

# Validate and store prefix
prefix="$2"
if [ "${prefix}" -ne "24" ] && [ "${prefix}" -ne "16" ]; then
	echo "Invalid prefix. Please provide either 16 or 24."
	exit 1
fi

# Determine host bits
if [ "${prefix}" -eq "16" ]; then
	host_bits="16"
else
	host_bits="8"
fi

# calculate possible host addresses
num_hosts=$((2 ** host_bits -2))

# convert network ip to binary and store
binary_octets=()

for octet in "${octets[@]}"; do
	binary_octet=$(printf "%08d\n" $(echo "obase=2;$octet" | bc))
	binary_octets+=("$binary_octet")
done

network_ip="${binary_octets[0]} ${binary_octets[1]} ${binary_octets[2]}"

# create output text file
output_file="ip_addresses.txt"
> "${output_file}"

# loop through possible host addresses and write them to the file
for ((i = 1; i <= num_hosts; i++)); do
	host_add=$(printf "%08d\n" $(echo "obase=2;$i" | bc))
	host_binary="${network_ip} ${host_add}"
	echo "${host_binary}" >> "${output_file}"
done

echo "IP addresses have been written to ${output_file}."
