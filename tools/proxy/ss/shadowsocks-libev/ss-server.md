# ss-server

## help
```
root@DESKTOP-PGE4ABC:/mnt # /usr/bin/ss-server --help

shadowsocks-libev 3.1.3

  maintained by Max Lv <max.c.lv@gmail.com> and Linus Yang <laokongzi@gmail.com>

  usage:

    ss-server

       -s <server_host>           Host name or IP address of your remote server.
       -p <server_port>           Port number of your remote server.
       -l <local_port>            Port number of your local server.
       -k <password>              Password of your remote server.
       -m <encrypt_method>        Encrypt method: rc4-md5,
                                  aes-128-gcm, aes-192-gcm, aes-256-gcm,
                                  aes-128-cfb, aes-192-cfb, aes-256-cfb,
                                  aes-128-ctr, aes-192-ctr, aes-256-ctr,
                                  camellia-128-cfb, camellia-192-cfb,
                                  camellia-256-cfb, bf-cfb,
                                  chacha20-ietf-poly1305,
                                  xchacha20-ietf-poly1305,
                                  salsa20, chacha20 and chacha20-ietf.
                                  The default cipher is rc4-md5.

       [-a <user>]                Run as another user.
       [-f <pid_file>]            The file path to store pid.
       [-t <timeout>]             Socket timeout in seconds.
       [-c <config_file>]         The path to config file.
       [-n <number>]              Max number of open files.
       [-i <interface>]           Network interface to bind.
       [-b <local_address>]       Local address to bind.

       [-u]                       Enable UDP relay.
       [-U]                       Enable UDP relay and disable TCP relay.
       [-6]                       Resovle hostname to IPv6 address first.

       [-d <addr>]                Name servers for internal DNS resolver.
       [--reuse-port]             Enable port reuse.
       [--fast-open]              Enable TCP fast open.
                                  with Linux kernel > 3.7.0.
       [--acl <acl_file>]         Path to ACL (Access Control List).
       [--manager-address <addr>] UNIX domain socket address.
       [--mtu <MTU>]              MTU of your network interface.
       [--mptcp]                  Enable Multipath TCP on MPTCP Kernel.
       [--no-delay]               Enable TCP_NODELAY.
       [--key <key_in_base64>]    Key of your remote server.
       [--plugin <name>]          Enable SIP003 plugin. (Experimental)
       [--plugin-opts <options>]  Set SIP003 plugin options. (Experimental)

       [-v]                       Verbose mode.
       [-h, --help]               Print this message.
```
