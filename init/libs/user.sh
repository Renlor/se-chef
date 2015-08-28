#!/bin/bash

# adds a user takes a username and n groups as arguments
#e.g. add_user myuser mygroup sudo printer . . .
function add_user ()
{
hash groupadd 2>/dev/null || { echo >&2 "groupadd is required but is not installed.  Aborting."; exit 1; }
hash mkdir    2>/dev/null || { echo >&2 "mkdir is required but is not installed.  Aborting."; exit 1; }
hash useradd  2>/dev/null || { echo >&2 "useradd is required but is not installed.  Aborting."; exit 1; }
hash chown    2>/dev/null || { echo >&2 "chown is required but is not installed.  Aborting."; exit 1; }

if [ -z "$1" ]; then
  local user=$1

  mkdir /home/$user
  groupadd $user

  if [ -z "$2" ]; then
    local groups="${@:2}"

    for group in "$groups"; do
      groupadd $group
    done
    useradd -g $user -G $groups $user
  else
    useradd -g $user $user
  fi
    chown -R $user:$user /home/$user
  else
  echo "called add_user without any arguments at a minimum a username is required."
  exit 1
fi
}