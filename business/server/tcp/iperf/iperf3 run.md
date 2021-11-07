# iperf3 run


## run records
### 10Mb/s
```
H:\greensoftware\misc\iperf>iperf3 -c 192.168.0.120
Connecting to host 192.168.0.120, port 5201
[  4] local 192.168.0.112 port 55624 connected to 192.168.0.120 port 5201
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-1.00   sec   896 KBytes  7.34 Mbits/sec
[  4]   1.00-2.00   sec   640 KBytes  5.24 Mbits/sec
[  4]   2.00-3.00   sec  1.12 MBytes  9.43 Mbits/sec
[  4]   3.00-4.00   sec  1.00 MBytes  8.40 Mbits/sec
[  4]   4.00-5.00   sec  1.12 MBytes  9.42 Mbits/sec
[  4]   5.00-6.00   sec  1.38 MBytes  11.5 Mbits/sec
[  4]   6.00-7.00   sec  1.25 MBytes  10.5 Mbits/sec
[  4]   7.00-8.00   sec  1.38 MBytes  11.5 Mbits/sec
[  4]   8.00-9.00   sec  1.38 MBytes  11.5 Mbits/sec
[  4]   9.00-10.00  sec  1.12 MBytes  9.44 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-10.00  sec  11.2 MBytes  9.44 Mbits/sec                  sender
[  4]   0.00-10.00  sec  11.2 MBytes  9.44 Mbits/sec                  receiver

iperf Done.

```


### 千兆路由 450Mb/s
```
➜  ~ iperf3 -c 192.168.0.113
Connecting to host 192.168.0.113, port 5201
[  5] local 192.168.0.120 port 46752 connected to 192.168.0.113 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  59.5 MBytes   499 Mbits/sec   13   1.93 MBytes
[  5]   1.00-2.00   sec  53.8 MBytes   451 Mbits/sec    6   1.94 MBytes
[  5]   2.00-3.00   sec  52.5 MBytes   441 Mbits/sec    1   1.96 MBytes
[  5]   3.00-4.00   sec  48.8 MBytes   409 Mbits/sec    6   1.97 MBytes
[  5]   4.00-5.00   sec  53.8 MBytes   451 Mbits/sec    2   1.98 MBytes
[  5]   5.00-6.00   sec  51.2 MBytes   430 Mbits/sec    1   1.99 MBytes
[  5]   6.00-7.00   sec  51.2 MBytes   430 Mbits/sec    1   2.00 MBytes
[  5]   7.00-8.00   sec  51.2 MBytes   430 Mbits/sec    4   2.01 MBytes
[  5]   8.00-9.00   sec  52.5 MBytes   440 Mbits/sec    0   2.02 MBytes
[  5]   9.00-10.00  sec  52.5 MBytes   440 Mbits/sec    0   2.03 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   527 MBytes   442 Mbits/sec   34             sender
[  5]   0.00-10.02  sec   525 MBytes   439 Mbits/sec                  receiver

iperf Done.
```

### localhost
```
H:\greensoftware\misc\iperf>iperf3 -c 127.0.0.1
Connecting to host 127.0.0.1, port 5201
[  4] local 127.0.0.1 port 55614 connected to 127.0.0.1 port 5201
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-1.00   sec  1.28 GBytes  11.0 Gbits/sec
[  4]   1.00-2.00   sec  1.40 GBytes  12.0 Gbits/sec
[  4]   2.00-3.00   sec  1.39 GBytes  12.0 Gbits/sec
[  4]   3.00-4.00   sec  1.39 GBytes  11.9 Gbits/sec
[  4]   4.00-5.00   sec  1.44 GBytes  12.3 Gbits/sec
[  4]   5.00-6.00   sec  1.44 GBytes  12.4 Gbits/sec
[  4]   6.00-7.00   sec  1.46 GBytes  12.5 Gbits/sec
[  4]   7.00-8.00   sec  1.44 GBytes  12.4 Gbits/sec
[  4]   8.00-8.48   sec   704 MBytes  12.4 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-8.48   sec  11.9 GBytes  12.1 Gbits/sec                  sender
[  4]   0.00-8.48   sec  0.00 Bytes  0.00 bits/sec                  receiver
iperf3: interrupt - the client has terminated

```

