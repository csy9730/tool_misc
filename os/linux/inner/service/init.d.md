# /etc/init.d

 ## /etc 

/etc/init.d/才真正存放启动项服务.

/etc/下rc开头的目录中存放着需要自动启动的脚本（软链接）.

### runlevel
运行级别(run level)

Init进程是系统启动之后的第一个用户进程，所以它的pid(进程编号)始终为1。init进程上来首先做的事是去读取/etc/目录下inittab文件中initdefault id值，这个值称为运行级别(run-level)。它决定了系统启动之后运行于什么级别。运行级别决定了系统启动的绝大部分行为和目的。这个级别从0到6 ，具有不同的功能。不同的运行级定义如下： 
- 0 - 停机（千万别把initdefault设置为0，否则系统永远无法启动）
- 1 - 单用户模式
- 2 - 多用户，没有 NFS
- 3 - 完全多用户模式(标准的运行级)
- 4 – 系统保留的
- 5 - X11 （x window)
- 6 - 重新启动 （千万不要把initdefault 设置为6，否则将一直在重启 ）

### ubuntu /etc

* /etc/rc0.d/  
* /ect/rc6.d/
* /ect/rcS.d/
* /etc/init.d/
* /etc/profile

 /etc/rc0.d/K01rsyslog ->  /etc/nit.d/rsyslog

/etc/init.d/才真正存放启动项服务。/etc/rc0.d 根据不同启动级别，选择性的链接到init.d。



### centos /etc

- /etc/rc0.d -> /etc/rc.d/rc0.d
- /etc/rc1.d -> /etc/rc.d/rc1.d
- /etc/rc2.d -> /etc/rc.d/rc2.d
- /etc/rc3.d -> /etc/rc.d/rc3.d
- /etc/rc4.d -> /etc/rc.d/rc4.d
- /etc/rc5.d -> /etc/rc.d/rc5.d
- /etc/rc6.d -> /etc/rc.d/rc6.d
- rc.d
- /etc/rrc.local -> /etc/rrc.d/rc.local
- init.d -> rc.d/init.d
- /etc/profile

/etc/rc.d/才真正存放启动项服务。/etc/rc0.d 根据不同启动级别，选择性的链接到rc.d。


### /etc/rc.d   

``` tree
.
|-- init.d
|   |-- functions
|   |-- netconsole
|   |-- network
|   `-- README
|-- rc0.d
|   |-- K50netconsole -> ../init.d/netconsole
|   `-- K90network -> ../init.d/network
|-- rc1.d
|   |-- K50netconsole -> ../init.d/netconsole
|   `-- K90network -> ../init.d/network
|-- rc2.d
|   |-- K50netconsole -> ../init.d/netconsole
|   `-- S10network -> ../init.d/network
|-- rc3.d
|   |-- K50netconsole -> ../init.d/netconsole
|   `-- S10network -> ../init.d/network
|-- rc4.d
|   |-- K50netconsole -> ../init.d/netconsole
|   `-- S10network -> ../init.d/network
|-- rc5.d
|   |-- K50netconsole -> ../init.d/netconsole
|   `-- S10network -> ../init.d/network
|-- rc6.d
|   |-- K50netconsole -> ../init.d/netconsole
|   `-- K90network -> ../init.d/network
`-- rc.local

```
### /etc/rc.local
/etc/rc.local 是软连接， 指向 /etc/rc.d/rc.local

``` bash
#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

touch /var/lock/subsys/local
/etc/init.d/mysqld start #mysql开机启动
/etc/init.d/nginx start #nginx开机启动
/etc/init.d/php-fpm start #php-fpm开机启动
/etc/init.d/memcached start #memcache开机启动
```

在文件末尾（exit 0之前）加上你开机需要启动的程序或执行的命令即可（执行的程序需要写绝对路径，添加到系统环境变量的除外），如：

`/usr/local/thttpd/sbin/thttpd  -C /usr/local/thttpd/etc/thttpd.conf`

### /etc/init.d

 init.d目录包含许多系统各种服务的启动和停止脚本。


### /etc/profile.d
将写好的脚本（.sh文件）放到目录 /etc/profile.d/ 下，系统启动后就会自动执行该目录下的所有shell脚本。

此外，/home/user_abc/.profile 脚本，每次用户登录tty时，都会调用.profile脚本

### /etc/rc0.d/*.sh

1、这些链接文件前面为什么会带一个Kxx或者Sxx呢？
   是这样的，带K的表示停止(Kill)一个服务，S表示开启(Start)的意思
2、K和S后面带的数字呢？干什么用的
   这个我开始的时候还以为是排列起来好看或者数数用呢。后来发现不是的。它的作用是用来排序，就是决定这些脚本执行的顺序，数值小的先执行，数值大的后执行。很多时候这些执行顺序是很重要的，比如要启动Apache服务，就必须先配置网络接口，不然一个没有IP的机子来启动http服务那岂不是很搞笑。。。
 3、无意中我发现同一个服务带S的和带K的链接到init.d之后是同一个脚本。我就纳闷了，为什么会是执行同一个脚本呢？
   这个时候真是S和K的妙用了，原来S和K并不止是用来看起来分的清楚而已。S给和K还分别给init.d下面的脚本传递了start和stop的参数。哦，是这样的(焕然大悟的样子,呵呵)！这时我才想起来原来曾经无数用过的`/etc/rc.d/init.d/network restart`命令。原来传S时相当于执行了`/etc/rc.d/init.d/xxx start`这条命令，当然K就相当于`/etc/rc.d/init.d/xxx stop`了


#### /etc/rc5.d/S01ssh.sh
``` bash
#! /bin/sh

### BEGIN INIT INFO
# Provides:		sshd
# Required-Start:	$remote_fs $syslog
# Required-Stop:	$remote_fs $syslog
# Default-Start:	2 3 4 5
# Default-Stop:		
# Short-Description:	OpenBSD Secure Shell server
### END INIT INFO

set -e

# /etc/init.d/ssh: start and stop the OpenBSD "secure shell(tm)" daemon

test -x /usr/sbin/sshd || exit 0
( /usr/sbin/sshd -\? 2>&1 | grep -q OpenSSH ) 2>/dev/null || exit 0

umask 022

if test -f /etc/default/ssh; then
    . /etc/default/ssh
fi

. /lib/lsb/init-functions

if [ -n "$2" ]; then
    SSHD_OPTS="$SSHD_OPTS $2"
fi

# Are we running from init?
run_by_init() {
    ([ "$previous" ] && [ "$runlevel" ]) || [ "$runlevel" = S ]
}

check_for_no_start() {
    # forget it if we're trying to start, and /etc/ssh/sshd_not_to_be_run exists
    if [ -e /etc/ssh/sshd_not_to_be_run ]; then 
	if [ "$1" = log_end_msg ]; then
	    log_end_msg 0 || true
	fi
	if ! run_by_init; then
	    log_action_msg "OpenBSD Secure Shell server not in use (/etc/ssh/sshd_not_to_be_run)" || true
	fi
	exit 0
    fi
}

check_dev_null() {
    if [ ! -c /dev/null ]; then
	if [ "$1" = log_end_msg ]; then
	    log_end_msg 1 || true
	fi
	if ! run_by_init; then
	    log_action_msg "/dev/null is not a character device!" || true
	fi
	exit 1
    fi
}

check_privsep_dir() {
    # Create the PrivSep empty dir if necessary
    if [ ! -d /run/sshd ]; then
	mkdir /run/sshd
	chmod 0755 /run/sshd
    fi
}

check_config() {
    if [ ! -e /etc/ssh/sshd_not_to_be_run ]; then
	/usr/sbin/sshd $SSHD_OPTS -t || exit 1
    fi
}

export PATH="${PATH:+$PATH:}/usr/sbin:/sbin"

case "$1" in
  start)
	check_privsep_dir
	check_for_no_start
	check_dev_null
	log_daemon_msg "Starting OpenBSD Secure Shell server" "sshd" || true
	if start-stop-daemon --start --quiet --oknodo --pidfile /run/sshd.pid --exec /usr/sbin/sshd -- $SSHD_OPTS; then
	    log_end_msg 0 || true
	else
	    log_end_msg 1 || true
	fi
	;;
  stop)
	log_daemon_msg "Stopping OpenBSD Secure Shell server" "sshd" || true
	if start-stop-daemon --stop --quiet --oknodo --pidfile /run/sshd.pid; then
	    log_end_msg 0 || true
	else
	    log_end_msg 1 || true
	fi
	;;

  reload|force-reload)
	check_for_no_start
	check_config
	log_daemon_msg "Reloading OpenBSD Secure Shell server's configuration" "sshd" || true
	if start-stop-daemon --stop --signal 1 --quiet --oknodo --pidfile /run/sshd.pid --exec /usr/sbin/sshd; then
	    log_end_msg 0 || true
	else
	    log_end_msg 1 || true
	fi
	;;

  restart)
	check_privsep_dir
	check_config
	log_daemon_msg "Restarting OpenBSD Secure Shell server" "sshd" || true
	start-stop-daemon --stop --quiet --oknodo --retry 30 --pidfile /run/sshd.pid
	check_for_no_start log_end_msg
	check_dev_null log_end_msg
	if start-stop-daemon --start --quiet --oknodo --pidfile /run/sshd.pid --exec /usr/sbin/sshd -- $SSHD_OPTS; then
	    log_end_msg 0 || true
	else
	    log_end_msg 1 || true
	fi
	;;

  try-restart)
	check_privsep_dir
	check_config
	log_daemon_msg "Restarting OpenBSD Secure Shell server" "sshd" || true
	RET=0
	start-stop-daemon --stop --quiet --retry 30 --pidfile /run/sshd.pid || RET="$?"
	case $RET in
	    0)
		# old daemon stopped
		check_for_no_start log_end_msg
		check_dev_null log_end_msg
		if start-stop-daemon --start --quiet --oknodo --pidfile /run/sshd.pid --exec /usr/sbin/sshd -- $SSHD_OPTS; then
		    log_end_msg 0 || true
		else
		    log_end_msg 1 || true
		fi
		;;
	    1)
		# daemon not running
		log_progress_msg "(not running)" || true
		log_end_msg 0 || true
		;;
	    *)
		# failed to stop
		log_progress_msg "(failed to stop)" || true
		log_end_msg 1 || true
		;;
	esac
	;;

  status)
	status_of_proc -p /run/sshd.pid /usr/sbin/sshd sshd && exit 0 || exit $?
	;;

  *)
	log_action_msg "Usage: /etc/init.d/ssh {start|stop|reload|force-reload|restart|try-restart|status}" || true
	exit 1
esac

exit 0

```
#### S999_ip.sh
``` bash
#!/bin/sh
#
# ipconfig        Starts ipconfig&enable io.
#

# Make sure the ssh-keygen progam exists
[ -f /sbin/ifconfig ] || exit 0

umask 077

start() {
        printf "reset ifconfig: "
        ifconfig eth0 192.168.1.136 netmask 255.255.255.0
        io -4 -w 0xfe000900 0xffff050a
        echo "OK"
}
stop() {
        printf "Stopping ifconfig: "
        echo "OK"
}
restart() {
        stop
        start
}

case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart|reload)
        restart
        ;;
  *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
esac

exit $?
```

#### /etc/init/ssh.conf
/etc/init/ssh.conf
``` bash
# ssh - OpenBSD Secure Shell server
#
# The OpenSSH server provides secure shell access to the system.

description	"OpenSSH server"

start on runlevel [2345]
stop on runlevel [!2345]

respawn
respawn limit 10 5
umask 022

env SSH_SIGSTOP=1
expect stop

# 'sshd -D' leaks stderr and confuses things in conjunction with 'console log'
console none

pre-start script
    test -x /usr/sbin/sshd || { stop; exit 0; }
    test -e /etc/ssh/sshd_not_to_be_run && { stop; exit 0; }

    mkdir -p -m0755 /run/sshd
end script

# if you used to set SSHD_OPTS in /etc/default/ssh, you can change the
# 'exec' line here instead
exec /usr/sbin/sshd -D
```

#### /etc/init.d/vsftpd
/etc/init.d/vsftpd

``` bash
#!/bin/sh

### BEGIN INIT INFO
# Provides:		vsftpd
# Required-Start:	$network $remote_fs $syslog
# Required-Stop:	$network $remote_fs $syslog
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Very secure FTP server
# Description:		Provides a lightweight, efficient FTP server written
#			for security.
### END INIT INFO

set -e

DAEMON="/usr/sbin/vsftpd"
NAME="vsftpd"
PATH="/sbin:/bin:/usr/sbin:/usr/bin"
LOGFILE="/var/log/vsftpd.log"
CHROOT="/var/run/vsftpd/empty"

test -x "${DAEMON}" || exit 0

. /lib/lsb/init-functions

if [ ! -e "${LOGFILE}" ]
then
	touch "${LOGFILE}"
	chmod 640 "${LOGFILE}"
	chown root:adm "${LOGFILE}"
fi

if [ ! -d "${CHROOT}" ]
then
	mkdir -p "${CHROOT}"
fi

case "${1}" in
	start)
		log_daemon_msg "Starting FTP server" "${NAME}"

		if [ -e /etc/vsftpd.conf ] && ! egrep -iq "^ *listen(_ipv6)? *= *yes" /etc/vsftpd.conf
		then
			log_warning_msg "vsftpd disabled - listen disabled in config."
			exit 0
		fi

		start-stop-daemon --start --background -m --oknodo --pidfile /var/run/vsftpd/vsftpd.pid --exec ${DAEMON}
		
		n=0
		while [ ${n} -le 5 ]
		do 
			_PID="$(if [ -e /var/run/vsftpd/vsftpd.pid ]; then cat /var/run/vsftpd/vsftpd.pid; fi)"
			if ! ps -C vsftpd | grep -qs "${_PID}"
			then
				break
			fi
			sleep 1
			n=$(( $n + 1 ))
		done

		if ! ps -C vsftpd | grep -qs "${_PID}"
		then
			log_warning_msg "vsftpd failed - probably invalid config."
			exit 1
		fi

		log_end_msg 0
		;;

	stop)
		log_daemon_msg "Stopping FTP server" "${NAME}"

		start-stop-daemon --stop --pidfile /var/run/vsftpd/vsftpd.pid --oknodo --retry 30 --exec ${DAEMON}
		RET=$?
		if [ $RET = 0 ]; then rm -f /var/run/vsftpd/vsftpd.pid; fi
		log_end_msg $?
		;;

	restart)
		${0} stop
		${0} start
		;;

	reload|force-reload)
		log_daemon_msg "Reloading FTP server configuration"

		start-stop-daemon --stop --pidfile /var/run/vsftpd/vsftpd.pid --signal 1 --exec $DAEMON

		log_end_msg "${?}"
		;;

	status)
		status_of_proc "${DAEMON}" "FTP server"
		;;

	*)
		echo "Usage: ${0} {start|stop|restart|reload|status}"
		exit 1
		;;
esac
```