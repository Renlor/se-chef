#!/bin/bash

function prompt ()
{
return=$1
printf "%s" "$2"
read val
echo

eval $return="'$val'"
}