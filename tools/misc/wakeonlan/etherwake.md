# etherwake

[https://www.mkssoftware.com/docs/man1/etherwake.1.asp](https://www.mkssoftware.com/docs/man1/etherwake.1.asp)

etherwake Etherwake is a shell script wrapper around netcat. It sends a Magic Wake-On-LAN packet, (see: [http://en.wikipedia.org/wiki/Wake-on-LAN](http://en.wikipedia.org/wiki/Wake-on-LAN)) optionally containing a password for those few cards that require it, and will cause the receiving machine to wake up. Often used before an RDP connection in order to ensure that the server is awake and responding.

## help

Options
```
-b 
The Macic Packet is a UDP broadcast and so the subnect containing the mac_address must be known and specified here.

-p 
Some network cards require a password before responding to a macgic packet and waking up. This option is not yet implemented as currently PTC has no such cards with which to test.

-P 
UDP port on the target mac_address within the broadcast address specified. The default is 7. UDP Port 9 is also commonly used.

-? 
Prints out etherwake help.

mac_addr is the networc mac address of the taget network cards in colon separated six byte format


```

## nvram-wakeup
nvram-wakeup