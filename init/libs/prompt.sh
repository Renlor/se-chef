#!/bin/bash

function prompt ()
{
return=$1
read -s "$2" val
echo

eval $return="'$val'"
}