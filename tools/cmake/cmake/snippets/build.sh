#!/bin/bash

if [ -d "build" ]; then
    echo "exist"
else
    mkdir build
fi

cygwin=false;
darwin=false;
mingw=false;
linux=false;

parse_uname_os(){
    case "`uname -s`" in
    CYGWIN*) 
        echo "cygwin"
        cygwin=true ;;
    MINGW*) 
        echo "mingw"
        mingw=true;;
    Linux*) 
        echo "Linux"
        linux=true
        ;;
    Darwin*) 
        echo "darwin"
        darwin=true
        ;;
    *)  
        echo "os not found"  
            ;;  
    esac
}


cd build
cmake .. 
echo "cmake finished"
cmake --build .
echo "compile finished"

cmake --install .
# if [ $? -ne 0 ]; then exit 1; fi;