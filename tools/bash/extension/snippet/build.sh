#!/bin/bash

[ ! $BUILD ] && export BUILD=build

echo "set $BUILD "
if [ -d "$BUILD" ]; then
    echo "$BUILD exist"
else
    mkdir $BUILD
fi

cd $BUILD
cmake ..
echo "begin compile"
make
echo "compile finished"
make install
echo "install finished"