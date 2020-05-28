# service


以下功能相似，都能设置启动项
``` bash
service sshd restart # 重启sshd服务
systemctl restart sshd # 重启sshd服务
/etc/init.d/sshd restart # 重启sshd服务
chkconfig --add ssh  # 添加sshd服务到启动项
```


/usr/sbin/service 是bash脚本，service功能是调用/bin/systemctl，生成/etc/init.d/sshd 文件 或者 /etc/init/ssh.conf

systemctl（/bin/systemctl）的功能是：在/etc/systemd/system目录添加一个符号链接，指向/usr/lib/systemd/system里面的httpd.service文件。
例如：/usr/lib/systemd/system/sshd.service ，

/sbin/chkconfig 是bash脚本


```
systemctl status sshd # sshd状态查看
# systemctl 和 service 功能相当
service sshd start # 开启sshd服务
service sshd status # 查看服务是否开启
service sshd stop # 关闭ssh服务

```
## systemctl
systemctl是CentOS7的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。
``` bash
systemctl start firewalld.service # 启动一个服务
systemctl stop firewalld.service # 关闭一个服务
systemctl restart firewalld.service # 重启一个服务
systemctl status firewalld.service # 显示一个服务的状态
systemctl enable firewalld.service # 在开机时启用一个服务
systemctl disable firewalld.service # 在开机时禁用一个服务
systemctl is-enabled firewalld.service # 查看服务是否开机启动
systemctl list-unit-files|grep enabled # 查看已启动的服务列表
systemctl --failed # 查看启动失败的服务列表
```

## misc

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