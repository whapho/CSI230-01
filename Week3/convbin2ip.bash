#!/bin/bash

binary="$1"
ip=""

for i in {0..24..8}; do
	octet="${binary:i:8}"
	decimal=$(echo "obase=10;ibase=2;$octet" | bc)
	ip+="${decimal}"
	if [[ "$i" -lt 24 ]]; then
		ip+="."
	fi
done

echo "${ip}"
