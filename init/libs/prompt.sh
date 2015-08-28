#!/bin/bash

function prompt ()
{
return=$1
printf $2
read val

eval $return="'$val'"
}