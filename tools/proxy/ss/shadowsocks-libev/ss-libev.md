# shadowsocks-libev




*ss-local*|*ss-redir*|*ss-server*|*ss-tunnel*|*ss-manager* 有什么区别？
- ss-local
- ss-redir
- ss-server
- ss-tunnel
- ss-manager


流程：
1. 服务端
   1. ss-server 提供ss服务
   2. ss-manager 提供ss服务
2. ss客户端
   - ss-tunel 接收ss服务，在本地提供转发远程的端口到本地端口服务，相当于`ssh -L`
   - ss-local 接受ss服务，在本地提供socks5服务，相当于`ssh -D`
   - ss-redir 提供透明代理，无需暴露socks服务，直接暴露网关服务
3. socks5 的服务端
4. socks5 的客户端


## install


``` bash
# ubuntu 
sudo apt-get update
sudo apt-get install shadowsocks-libev

# centos not found 
```

## run


### ss-local
```
root@DESKTOP-PGE4ABC:/mnt# ls /usr/bin/ss-*
/usr/bin/ss-local  /usr/bin/ss-manager  /usr/bin/ss-nat  /usr/bin/ss-redir  /usr/bin/ss-server  /usr/bin/ss-tunnel
```


* ss-local 是将本地作为客户端，需要连接一个ss服务器，可以向本地提供socks5服务。
* ss-server 是将本地作为服务端，向外部提供ss代理服务
* ss-redir  实现透明代理
* ss-nat
* ss-tunnel 提供的**本地端口转发**工具，通常用于解决 dns 污染问题。
* ss-manager

### start

启动服务端: 
```
/usr/bin/ss-server -c /etc/shadowsocks-libev/config.json

```


#### daemon 
``` bash
# Start
sudo systemctl start shadowsocks-libev.service
# Stop
sudo systemctl stop shadowsocks-libev.service
# Restart
sudo systemctl restart shadowsocks-libev.service

sudo systemctl status shadowsocks-libev.service
```

``` bash
ls  /lib/systemd/system/shadowsocks-libev*
shadowsocks-libev-local@.service   shadowsocks-libev-server@.service  shadowsocks-libev.service
shadowsocks-libev-redir@.service   shadowsocks-libev-tunnel@.service
```
## source

以下是ubuntu下的shadowsocks相关文件：

- /etc/shadowsocks-libev/config.json 配置了服务器地址核端口，加密方式，json格式。
- /etc/default/shadowsocks-libev， 默认配置。
- /etc/init.d/shadowsocks-libev       bash脚本格式
- /lib/systemd/system/shadowsocks-libev.service systemd的接口，ini格式。

- /etc/systemd/system/multi-user.target.wants/shadowsocks-libev.service
- /etc/rc0.d/K01shadowsocks-libev
- /etc/rc5.d/S01shadowsocks-libev
- /etc/rc4.d/S01shadowsocks-libev
- /etc/rc1.d/K01shadowsocks-libev
- /etc/rc3.d/S01shadowsocks-libev
- /etc/rc2.d/S01shadowsocks-libev
- /etc/rc6.d/K01shadowsocks-libev
- /lib/systemd/system/shadowsocks-libev-server@.service 
- /lib/systemd/system/shadowsocks-libev-local@.service
- /lib/systemd/system/shadowsocks-libev-tunnel@.service
- /lib/systemd/system/shadowsocks-libev-redir@.service
- 

#### config.json

`/etc/shadowsocks-libev/config.json`


``` json
{
    "server":"192.168.0.112",
    "server_port":18188,
    "local_port":1080,
    "password":"123456",
    "timeout":60,
    "method":"aes-256-gcm"
}
```


#### /etc/default/shadowsocks-libev
``` ini
# Enable during startup?
START=yes

# Configuration file
CONFFILE="/etc/shadowsocks-libev/config.json"

# Extra command line arguments
DAEMON_ARGS="-u"

# User and group to run the server as
USER=nobody
GROUP=nogroup

# Number of maximum file descriptors
MAXFD=32768
```


#### /etc/init.d/shadowsocks-libev
``` ini


# PATH should only include /usr/ if it runs after the mountnfs.sh script
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC=shadowsocks-libev       # Introduce a short description here
NAME=shadowsocks-libev       # Introduce the short server's name here
DAEMON=/usr/bin/ss-server    # Introduce the server's location here
DAEMON_ARGS=""               # Arguments to run the daemon with
PIDFILE=/var/run/$NAME/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

# Exit if the package is not installed
[ -x $DAEMON ] || exit 0

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

[ "$START" = "yes" ] || exit 0

: ${USER:="nobody"}
: ${GROUP:="nogroup"}

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

#
# Function that starts the daemon/service
#
do_start()
{
    # Modify the file descriptor limit
    ulimit -n ${MAXFD}

    # Take care of pidfile permissions
    mkdir /var/run/$NAME 2>/dev/null || true
    chown "$USER:$GROUP" /var/run/$NAME

    # Return
    #   0 if daemon has been started
    #   1 if daemon was already running
    #   2 if daemon could not be started
    start-stop-daemon --start --quiet --pidfile $PIDFILE --chuid $USER:$GROUP --exec $DAEMON --test > /dev/null \
        || return 1
    start-stop-daemon --start --quiet --pidfile $PIDFILE --chuid $USER:$GROUP --exec $DAEMON -- \
        -c "$CONFFILE" -u -f $PIDFILE $DAEMON_ARGS \
        || return 2
}

#
# Function that stops the daemon/service
#
do_stop()
{
    # Return
    #   0 if daemon has been stopped
    #   1 if daemon was already stopped
    #   2 if daemon could not be stopped
    #   other if a failure occurred
    start-stop-daemon --stop --quiet --retry=TERM/5 --pidfile $PIDFILE --exec $DAEMON
    RETVAL="$?"
    [ "$RETVAL" = 2 ] && return 2
    # Wait for children to finish too if this is a daemon that forks
    # and if the daemon is only ever run from this initscript.
    # If the above conditions are not satisfied then add some other code
    # that waits for the process to drop all resources that could be
    # needed by services started subsequently.  A last resort is to
    # sleep for some time.
    start-stop-daemon --stop --quiet --oknodo --retry=KILL/5 --exec $DAEMON
    [ "$?" = 2 ] && return 2
    # Many daemons don't delete their pidfiles when they exit.
    rm -f $PIDFILE
    return "$RETVAL"
}
```

#### /lib/systemd/system/shadowsocks-libev.service
/lib/systemd/system/shadowsocks-libev.service
``` ini

[Unit]
Description=Shadowsocks-libev Default Server Service
Documentation=man:shadowsocks-libev(8)
After=network.target

[Service]
Type=simple
EnvironmentFile=/etc/default/shadowsocks-libev
User=nobody
Group=nogroup
LimitNOFILE=32768
ExecStart=/usr/bin/ss-server -c $CONFFILE $DAEMON_ARGS

[Install]
WantedBy=multi-user.target

```

可以改成：`ExecStart=/usr/bin/ss-local -c /etc/shadowsocks-libev/%i.json`

以上脚本，本质是封装命令行，便于启动服务调用`/usr/bin/ss-local -c /etc/shadowsocks-libev/%i.json`

#### /lib/systemd/system/shadowsocks-libev-server@.service


``` ini
[Unit]
Description=Shadowsocks-Libev Custom Server Service for %I
Documentation=man:ss-server(1)
After=network.target

[Service]
Type=simple
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
ExecStart=/usr/bin/ss-server -c /etc/shadowsocks-libev/%i.json

[Install]
WantedBy=multi-user.target
```


#### /lib/systemd/system/shadowsocks-libev-server@.service
内容和/lib/systemd/system/shadowsocks-libev-server@.service类似
