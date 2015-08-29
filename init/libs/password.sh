#!/bin/bash

function get_password ()
{
local return=$1
local length=$2
local ps
local ps_verify

while true; do
  read -s -p 'Password (hidden): ' ps
  echo
  read -s -p 'Retype Password  : ' ps_verify
  echo
  if [ "$ps" != "$ps_verify" ]; then
    echo "Passwords do not match. Try again."
  elif [ "${#ps}" -lt "$length" ]; then
    echo 'Password must be at least $length characters.'
  else
    echo 'Password accepted.'
    break # Exit loop password accepted.
  fi
    eval $return="'$ps'"
done
}