#!/bin/bash

function prompt ()
{
return=$1
read -p "$2" val
echo

eval $return="'$val'"
}