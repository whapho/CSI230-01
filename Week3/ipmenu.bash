#!/bin/bash

function main_menu() {
	echo "Please select an option"
	echo "[1] Get my ip address"
	echo "[2] Get my ip address in binary"
	echo "[3] Get my network mask in binary"
	echo "[4] Get my network address in binary"
	echo "[5] Convert a binary to ip address"
	echo "[6] Exit"

	read -p "enter your choice: " choice

	case "$choice" in
		1)
			echo "Your IP address:"
			bash myip.bash
			;;
		2)
			echo "Your IP address in binary:"
			bash myipbinary.bash
			;;
		3)
			echo "Your network mask in binary:"
			bash mymaskbinary.bash
			;;
		4)
			echo "Your network address in binary:"
			bash mynetworkbinary.bash
			;;
		5)
			while true; do
				echo  "Please enter your binary number (32 digit):"
				read binary

				if [[ "${#binary}" -eq 32 ]]; then
					break
				else
					echo "Invalid. Please enter a 32 digit number."
				fi
			done

			echo  "Your number as IP:"
			bash convbin2ip.bash "${binary}"
			;;
		6)
			exit
			;;
		*)
			echo "Invalid choice. Please try again."
			sleep 2
			main_menu
			;;
	esac
}


main_menu
