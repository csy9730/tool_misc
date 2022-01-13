#!/usr/bin/env bash

mac_address=$1
# Strip colons from the MAC address
mac_address=$(echo $mac_address | sed 's/://g')

broadcast=$2
port=4343

# Magic packets consist of 12*`f` followed by 16 repetitions of the MAC address
magic_packet=$(
  printf 'f%.0s' {1..12}
  printf "$mac_address%.0s" {1..16}
)
# ... and they need to be hex-escaped
magic_packet=$(
  echo $magic_packet | sed -e 's/../\\x&/g'
)

# echo $magic_packet
echo -e $magic_packet | nc -w1 -u $broadcast $port