#!/bin/bash

echo arg num=$#
if [ "$1" = "" ]; then
    echo "null"
else
    echo $1
fi

echo quiting
