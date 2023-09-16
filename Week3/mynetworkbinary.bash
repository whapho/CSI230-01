#!/bin/bash

ip=$(bash myipbinary.bash)
pl=$(bash prefixlength.bash)
mask=$(bash mymaskbinary.bash)

network=""

for i in {0..31}
do
	#echo
	if [ "$i" -lt "$pl" ];
	then
	network+="${ip:$i:1}"
	else
	network+="0"
	fi
done

echo "${network}"
