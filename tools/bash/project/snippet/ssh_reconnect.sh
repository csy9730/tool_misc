#!/bin/bash
while true;  
do  
    date "+%Y/%m/%d_%H:%M:%S"
    ssh -CN -D 127.0.0.1:1080 my_host
    sleep 5
done
