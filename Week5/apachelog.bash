#!/bin/bash

# variables
log_file="/var/log/apache2/access.log"
ip_list="/home/mgerew/CSI230-01/Week5/clientIPs.txt"
blacklist="/home/mgerew/CSI230-01/Week5/blacklisted.txt"

# functions
listIPs() {
	awk 'NF{ if ( $1 != "127.0.0.1" ) print $1 }' "$log_file" | sort -u > clientIPs.txt

	num_ips=$(wc -l < clientIPs.txt)
	echo "Found $num_ips unique IP addresses. Saved to clientIPs.txt"
}

visitors() {
	while read -r ip; do
	  count=$(cat "$log_file" | grep $(date +"%d/%b/%Y") | grep "${ip}" -c )
	  echo "${count}" "${ip}"
	done < "$ip_list"
}

badClients() {
	while file= read -r ip; do
	  count=$(cat "$log_file" | grep $(date +"%d/%b/%Y:%H:[0-9][0-9]") | grep "${ip}" |  cut -c 50- | grep -c -E '400|403|404' )

	  if [[ "${count}" -ge 3 ]]; then
	    echo -e "${ip}" > "$blacklist"
	  fi
	done < "$ip_list"
	echo "IPs Blacklisted:"
	cat "$blacklist"
}

histogram() {
	currentDate=$(date +"%d/%b/%Y")
	while file= read -r ip; do
          count=$(cat "$log_file" | grep "$currentDate" | grep "${ip}" | grep -c "200" )
	  echo "$count" visits on "$currentDate"
	done < "$ip_list"
}

block() {
	while file= read -r ip; do
	  sudo iptables -A INPUT -s "${ip}" -j DROP
	done < "$blacklist"

	iptables -L -v
}

resetBlock() {
        while file= read -r ip; do
          sudo iptables -D INPUT -s "${ip}" -j DROP
        done < "$blacklist"

        iptables -L -v
}

# menu
while true; do
  echo "[1] Number of Visitors"
  echo "[2] Display Visitors"
  echo "[3] Show Bad Visits"
  echo "[4] Block Bad Visits"
  echo "[5] Reset Block Rules"
  echo "[6] Show Histogram"
  echo "[7] Quit"

  read -p "Enter your choice: " choice

  case $choice in
    1)
      listIPs
      ;;
    2)
      visitors
      ;;
    3)
      badClients
      ;;
    4)
      block
      ;;
    5)
      resetBlock
      ;;
    6)
      histogram
      ;;
    7)
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a valid option."
      ;;
  esac
done
















