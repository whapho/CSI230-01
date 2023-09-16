#!/bin/bash

ip=$(bash myfullip.bash)

echo "${ip::-3}"
