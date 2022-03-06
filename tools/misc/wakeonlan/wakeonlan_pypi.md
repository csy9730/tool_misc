# wakeonlan pypi

## install
```
pip2 install wakeonlan
```
### help
```
usage: wakeonlan [-h] [-i ip] [-p port] mac address [mac address ...]

Wake one or more computers using the wake on lan protocol.

positional arguments:
  mac address  The mac addresses or of the computers you are trying to wake.

optional arguments:
  -h, --help   show this help message and exit
  -i ip        The ip address of the host to send the magic packet to.
               (default 255.255.255.255)
  -p port      The port of the host to send the magic packet to (default 9)
```
