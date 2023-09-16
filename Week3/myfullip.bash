#!/bin/bash

ip_addr_output=$(ip addr | grep 'inet ' | grep -Ev 'inet (127\.)' |  awk '{print $2}')

echo "$ip_addr_output"
