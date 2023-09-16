#!/bin.bash

pl=$(bash prefixlength.bash)

submask=""
for i in {1..32}
   do
	if [[ "${i}" -lt "${pl}" ]];
	then
		submask+="1"
	else
		submask+="0"
	fi
   done

echo "${submask}"
