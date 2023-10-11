#!/bin/bash

# get parameter
input=$1

# ------------help section------------ 
Help() {
echo "-------------------------------"
echo "Syntax: ./$0 [- c/d]"
echo "Options:"
echo "d  List Disabled Accounts"
echo "c  Counts Logins of a User"
echo "-------------------------------"
}

if [ ${#} -ne 1 ]; then
Help
fi
# ------------help section-------------

while getopts ":dc" option; do
  case $option in
  d) # list deleted users
  grep "*" /etc/shadow
  ;;
  c) # counts logins for user
  while file= read -r username
  do
    p=$(last $username | grep -c $username) 
    echo "${p} ${username}"
   done < usr.txt
  ;;
  *) # display help
  Help
  ;;
  esac
done

