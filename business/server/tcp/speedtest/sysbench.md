#  sysbench

```
sysbench fileio prepare; sysbench fileio --file-test-mode=rndrw run;
```
## demo

### demo I
一台ali主机

```
sysbench fileio prepare; sysbench fileio --file-test-mode=rndrw run;


2147483648 bytes written in 19.31 seconds (106.04 MiB/sec).
sysbench 1.0.17 (using system LuaJIT 2.0.4)

Running the test with following options:
Number of threads: 1
Initializing random number generator from current time


Extra file open flags: (none)
128 files, 16MiB each
2GiB total file size
Block size 16KiB
Number of IO requests: 0
Read/Write ratio for combined random IO test: 1.50
Periodic FSYNC enabled, calling fsync() each 100 requests.
Calling fsync() at the end of test, Enabled.
Using synchronous I/O mode
Doing random r/w test
Initializing worker threads...

Threads started!


File operations:
    reads/s:                      986.60
    writes/s:                     657.66
    fsyncs/s:                     2106.44

Throughput:
    read, MiB/s:                  15.42
    written, MiB/s:               10.28

General statistics:
    total time:                          10.0242s
    total number of events:              37478

Latency (ms):
         min:                                    0.00
         avg:                                    0.27
         max:                                   13.63
         95th percentile:                        0.97
         sum:                                 9960.36

Threads fairness:
    events (avg/stddev):           37478.0000/0.00
    execution time (avg/stddev):   9.9604/0.00

```

## demo II

一台vultr主机
```
$ sysbench fileio prepare; sysbench fileio --file-test-mode=rndrw run;

Extra file open flags: (none)
128 files, 16MiB each
2GiB total file size
Block size 16KiB
Number of IO requests: 0
Read/Write ratio for combined random IO test: 1.50
Periodic FSYNC enabled, calling fsync() each 100 requests.
Calling fsync() at the end of test, Enabled.
Using synchronous I/O mode
Doing random r/w test
Initializing worker threads...

Threads started!


File operations:
    reads/s:                      1875.41
    writes/s:                     1250.27
    fsyncs/s:                     4006.27

Throughput:
    read, MiB/s:                  29.30
    written, MiB/s:               19.54

General statistics:
    total time:                          10.0109s
    total number of events:              71290

Latency (ms):
         min:                                    0.00
         avg:                                    0.14
         max:                                   12.72
         95th percentile:                        0.41
         sum:                                 9929.33

Threads fairness:
    events (avg/stddev):           71290.0000/0.00
    execution time (avg/stddev):   9.9293/0.00

```

### true x86 machine
