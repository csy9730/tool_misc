# denyhosts

[https://github.com/denyhosts/denyhosts](https://github.com/denyhosts/denyhosts)

denyhosts是基于python2的包，可以检查失败登录的log的内容，添加ip到denyhost文件中。
## quickstart
### install & run
下载软件，安装，自启动一键脚本,适用于centos7脚本。

``` bash
wget https://github.com/denyhosts/denyhosts/archive/v3.1.tar.gz 
tar -zxvf v3.1.tar.gz 
cd denyhosts-3.1
pip2 install ipaddr 
python2 setup.py install  --record denyhostsInstall.log

# 查看是否安装成功
pip2 list |grep DenyHosts

# 修改服务文件
sed -i 's/usr\/sbin\/denyhosts/usr\/bin\/denyhosts.py/g'  /usr/bin/daemon-control-dist


# 如果是centos系统， 修改配置 
isCentos=$(lsb_release -a |grep -i Centos)
if [ "$isCentos" != ""  ] ;then
    echo "Your system is Centos"
    sed -i 's/var\/log\/auth.log/var\/log\/secure/g'  /etc/denyhosts.conf
else
    echo "Your system is ubuntu"
fi

chown root /usr/bin/daemon-control-dist
chmod 700 /usr/bin/daemon-control-dist

# 手动启动服务
/usr/bin/daemon-control-dist start

# 手动查看服务状态
/usr/bin/daemon-control-dist status

ln -s /usr/bin/daemon-control-dist /etc/init.d/denyhosts
# 创建启动服务连接
chkconfig denyhosts on
# 添加启动项

systemctl start  denyhosts
systemctl status denyhosts

# cat /var/log/denyhosts
```


## misc

### start

``` bash
#!/bin/bash
# wget https://github.com/denyhosts/denyhosts/archive/v3.1.tar.gz 
wget http://sourceforge.net/projects/denyhosts/files/denyhosts/2.6/DenyHosts-2.6.tar.gz # python2 的多年前的旧版本

tar -zxvf DenyHosts-2.6.tar.gz
cd DenyHosts-2.6

pip2 install ipaddr 
$ python2 setup.py install  --record denyhostsInstall.log

running install_scripts
copying build/scripts-2.7/denyhosts.py -> /usr/bin
copying build/scripts-2.7/daemon-control-dist -> /usr/bin
changing mode of /usr/bin/denyhosts.py to 755
changing mode of /usr/bin/daemon-control-dist to 755
running install_data
copying denyhosts.conf -> /etc
copying denyhosts.8 -> /usr/share/man/man8
running install_egg_info
Writing /usr/lib/python2.7/site-packages/DenyHosts-3.0-py2.7.egg-info
writing list of installed files to 'denyhostsInstall.log'


# 卸载的时候使用日志文件logName
# cat denyhostsInstall.log | xargs rm -rf
```


程序入口文件是 `/usr/bin/denyhosts.py` ,需要配合程序解释器使用
程序解释器：`/usr/bin/env python`
配置文件时`/etc/denyhosts.conf`，入口文件会自动读取该配置文件

服务入口是`/usr/bin/daemon-control-dist`
服务入口文件自动调用程序解释器，入口文件，和配置文件执行。

程序的安装目录是：`/usr/lib/python2.7/site-packages/DenyHosts`，提供程序后台，被入口文件调用。
共享文档目录 `/usr/share/denyhosts`  ，完全不影响程序使用。

``` bash
# /usr/bin/daemon-control-dist
cp  /usr/bin/daemon-control-dist /usr/bin/daemon-control

#  /usr/bin/daemon-control-dist start的内容等价于执行 /usr/bin/env python /usr/local/bin/denyhosts --config /etc/denyhosts.conf --daemon
# 修改/usr/bin/daemon-control
daemon-control start
# /usr/bin/daemon-control start等价于执行 /usr/bin/env python2 /usr/bin/denyhosts.py --config /etc/denyhosts.conf --daemon
```

/usr/bin/daemon-control文件中,可以修改守护进程的调用方法

/etc/denyhosts.conf文件中,可以修改配置:
``` ini
SECURE_LOG = /var/log/secure

```
ubuntu使用/var/log/auth.log 文件
centos使用/var/log/secure文件



### conf

* SECURE_LOG
* BLOCK_SERVICE


``` ini
SECURE_LOG = /var/log/secure
#sshd日志文件，它是根据这个文件来判断的，不同的操作系统，文件名稍有不同。

HOSTS_DENY = /etc/hosts.deny
#控制用户登陆的文件

PURGE_DENY = 5m
DAEMON_PURGE = 5m
#过多久后清除已经禁止的IP，如5m（5分钟）、5h（5小时）、5d（5天）、5w（5周）、1y（一年）

BLOCK_SERVICE  = sshd
#禁止的服务名，可以只限制不允许访问ssh服务，也可以选择ALL

DENY_THRESHOLD_INVALID = 5
#允许无效用户失败的次数

DENY_THRESHOLD_VALID = 10
#允许普通用户登陆失败的次数

DENY_THRESHOLD_ROOT = 5
#允许root登陆失败的次数

HOSTNAME_LOOKUP=NO
#是否做域名反解

DAEMON_LOG = /var/log/denyhosts
```

### daemon-control-dist
``` python
#!/usr/bin/python2
# denyhosts     Bring up/down the DenyHosts daemon
#
# chkconfig: 2345 98 02
# description: Activates/Deactivates the
#    DenyHosts daemon to block ssh attempts
#
###############################################

###############################################
#### Edit these to suit your configuration ####
###############################################

DENYHOSTS_BIN   = "/usr/bin/denyhosts.py"
DENYHOSTS_LOCK  = "/run/denyhosts.pid"
DENYHOSTS_CFG   = "/etc/denyhosts.conf"

PYTHON_BIN      = "/usr/bin/env python"

###############################################
####         Do not edit below             ####
###############################################

DENYHOSTS_BIN = "%s %s" % (PYTHON_BIN, DENYHOSTS_BIN)

import os, sys, signal, time

# make sure 'ps' command is accessible (which should be
# in either /usr/bin or /bin.  Modify the PATH so
# popen can find it
env = os.environ.get('PATH', "")
os.environ['PATH'] = "/usr/bin:/bin:%s" % env

STATE_NOT_RUNNING = -1
STATE_LOCK_EXISTS = -2

def usage():
    print "Usage: %s {start [args...] | stop | restart [args...] | status | debug | condrestart [args...] }" % sys.argv[0]
    print
    print "For a list of valid 'args' refer to:"
    print "$ denyhosts.py --help"
    print
    sys.exit(0)


def getpid():
    try:
        fp = open(DENYHOSTS_LOCK, "r")
        pid = int(fp.readline().rstrip())
        fp.close()
    except Exception, e:
        return STATE_NOT_RUNNING


    if not sys.platform.startswith('freebsd') and os.access("/proc", os.F_OK):
        # proc filesystem exists, look for pid
        if os.access(os.path.join("/proc", str(pid)), os.F_OK):
            return pid
        else:
            return STATE_LOCK_EXISTS
    else:
        # proc filesystem doesn't exist (or it doesn't contain PIDs), use 'ps'
        p = os.popen("ps -p %d" % pid, "r")
        p.readline() # get the header line
        pid_running = p.readline()
        # pid_running will be '' if no process is found
        if pid_running:
            return pid
        else:
            return STATE_LOCK_EXISTS


def start(*args):
    cmd = "%s --daemon " % DENYHOSTS_BIN
    if args: cmd += ' '.join(args)

    print "starting DenyHosts:   ", cmd

    os.system(cmd)


def stop():
    pid = getpid()
    if pid >= 0:
        os.kill(pid, signal.SIGTERM)
        print "sent DenyHosts SIGTERM"
    else:
        print "DenyHosts is not running"

def debug():
    pid = getpid()
    if pid >= 0:
        os.kill(pid, signal.SIGUSR1)
        print "sent DenyHosts SIGUSR1"
    else:
        print "DenyHosts is not running"

def status():
    pid = getpid()
    if pid == STATE_LOCK_EXISTS:
        print "%s exists but DenyHosts is not running" % DENYHOSTS_LOCK
    elif pid == STATE_NOT_RUNNING:
        print "Denyhosts is not running"
    else:
        print "DenyHosts is running with pid = %d" % pid


def condrestart(*args):
    pid = getpid()
    if pid >= 0:
        restart(*args)


def restart(*args):
    stop()
    time.sleep(1)
    start(*args)


if __name__ == '__main__':
    cases = {'start':       start,
             'stop':        stop,
             'debug':       debug,
             'status':      status,
             'condrestart': condrestart,
             'restart':     restart}

    try:
        args = sys.argv[2:]
    except Exception:
        args = []

    try:
        # arg 1 should contain one of the cases above
        option = sys.argv[1]
    except Exception:
        # try to infer context (from an /etc/init.d/ script, perhaps)
        procname = os.path.basename(sys.argv[0])
        infer_dict = {'K': 'stop',
                      'S': 'start'}
        option = infer_dict.get(procname[0])
        if not option:
            usage()

    try:
        if option in ('start', 'restart', 'condrestart'):
            anystartswith = lambda prefix, xs: any(map(lambda x: x.startswith(prefix), xs))
            if not anystartswith('--config', args) and '-c' not in args:
                args.append("--config=%s" % DENYHOSTS_CFG)

        cmd = cases[option]
        apply(cmd, args)
    except Exception:
        usage()

```

### daemon
``` bash
chown root daemon-control
chmod 700 daemon-control
#提高安全级别，修改权限

ln -s /usr/share/denyhosts/daemon-control /etc/init.d/denyhosts
#创建启动服务连接

chkconfig denyhosts on
#添加启动项

cp denyhosts.cfg denyhosts.cfg.bak
#备份配置文件，为修改配置做准备

cat /workspace/denyhost.txt<</usr/share/denyhosts/denyhosts.cfg
#将配置文件内容导入配置文件（我的配置文件安装之前已经配置好了！）

/etc/init.d/denyhosts start
#启动服务

```

### /var/log/denyhosts
```
2020-10-27 14:33:31,588 - prefs       : INFO        PLUGIN_PURGE: [None]
2020-10-27 14:33:31,588 - prefs       : INFO        PURGE_DENY: [None]
2020-10-27 14:33:31,588 - prefs       : INFO        PURGE_THRESHOLD: [0]
2020-10-27 14:33:31,588 - prefs       : INFO        RESET_ON_SUCCESS: [no]
2020-10-27 14:33:31,588 - prefs       : INFO        SECURE_LOG: [/var/log/secure]
2020-10-27 14:33:31,588 - prefs       : INFO        SMTP_DATE_FORMAT: [%a, %d %b %Y %H:%M:%S %z]
2020-10-27 14:33:31,588 - prefs       : INFO        SMTP_FROM: [DenyHosts <nobody@localhost>]
2020-10-27 14:33:31,588 - prefs       : INFO        SMTP_HOST: [localhost]
2020-10-27 14:33:31,588 - prefs       : INFO        SMTP_PASSWORD: [None]
2020-10-27 14:33:31,588 - prefs       : INFO        SMTP_PORT: [25]
2020-10-27 14:33:31,588 - prefs       : INFO        SMTP_SUBJECT: [DenyHosts Report]
2020-10-27 14:33:31,588 - prefs       : INFO        SMTP_USERNAME: [None]
2020-10-27 14:33:31,589 - prefs       : INFO        SSHD_FORMAT_REGEX: [None]
2020-10-27 14:33:31,589 - prefs       : INFO        SUCCESSFUL_ENTRY_REGEX: [None]
2020-10-27 14:33:31,589 - prefs       : INFO        SUSPICIOUS_LOGIN_REPORT_ALLOWED_HOSTS: [YES]
2020-10-27 14:33:31,589 - prefs       : INFO        SYNC_DOWNLOAD: [no]
2020-10-27 14:33:31,589 - prefs       : INFO        SYNC_DOWNLOAD_RESILIENCY: [18000]
2020-10-27 14:33:31,589 - prefs       : INFO        SYNC_DOWNLOAD_THRESHOLD: [3]
2020-10-27 14:33:31,589 - prefs       : INFO        SYNC_INTERVAL: [3600]
2020-10-27 14:33:31,589 - prefs       : INFO        SYNC_SERVER: [None]
2020-10-27 14:33:31,589 - prefs       : INFO        SYNC_UPLOAD: [no]
2020-10-27 14:33:31,589 - prefs       : INFO        SYSLOG_REPORT: [no]
2020-10-27 14:33:31,589 - prefs       : INFO        WORK_DIR: [/var/lib/denyhosts]
2020-10-27 14:35:38,801 - denyhosts   : INFO     Creating new firewall rule /sbin/iptables -I INPUT -s 114.218.57.215 -j DROP
2020-10-27 14:35:38,804 - denyhosts   : INFO     new denied hosts: ['114.218.57.215']
2020-10-27 14:38:08,957 - denyhosts   : INFO     Creating new firewall rule /sbin/iptables -I INPUT -s 208.109.11.147 -j DROP
2020-10-27 14:38:08,960 - denyhosts   : INFO     new denied hosts: ['208.109.11.147']

```