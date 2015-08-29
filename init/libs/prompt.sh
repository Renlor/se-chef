#!/bin/bash

function prompt ()
{
return=$1
read -p "$2" val

eval $return="'$val'"
}