#!/bin/bash

function prompt ()
{
  local return=$1
  local val

  read -p "$2" val

  eval $return="'$val'"
}

function prompt_password ()
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
      echo
      echo "Passwords do not match. Try again."
    elif [ "${#ps}" -lt "$length" ]; then
      echo
      echo 'Password must be at least $length characters.'
    else
      echo 'Password accepted.'
      echo
      break # Exit loop password accepted.
    fi
      eval $return="'$ps'"
  done
}