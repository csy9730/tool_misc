#!/bin/bash

if [ -d "build" ]; then
    echo "exist"
else
    mkdir build
fi

cd build
cmake .. 
echo "cmake finished"
make
echo "compile finished"
