# wol

## help
```
➜  ~ wol --help
Usage: wol [OPTION] ... MAC-ADDRESS ...
Wake On LAN client - wakes up magic packet compliant machines.

    --help          display this help and exit
-V, --version       output version information and exit
-v, --verbose       verbose output
-w, --wait=NUM      wait NUM millisecs after sending
-h, --host=HOST     broadcast to this IP address or hostname
-i, --ipaddr=HOST   same as --host
-p, --port=NUM      broadcast to this UDP port
-f, --file=FILE     read addresses from file FILE ("-" reads from stdin)
    --passwd[=PASS] send SecureON password PASS (if no PASS is given, you
                    will be prompted for the password)
-b, --bind=HOST     bind to this IP address or hostname

Each MAC-ADDRESS is written as x:x:x:x:x:x, where x is a hexadecimal number
between 0 and ff which represents one byte of the address, which is in
network byte order (big endian).

PASS is written as x-x-x-x-x-x, where x is a hexadecimal number between 0
and ff which represents one byte of the password.

Report bugs to <krennwallner@aon.at>
```
