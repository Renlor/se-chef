#!/bin/bash

function prompt ()
{
return=$1
read "$2" val
echo

eval $return="'$val'"
}