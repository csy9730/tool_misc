# fail2ban

[https://github.com/fail2ban/fail2ban](https://github.com/fail2ban/fail2ban)

## install
``` bash
# install from source codes
git clone https://github.com/fail2ban/fail2ban.git
cd fail2ban
sudo python setup.py install 

# or
pip install git+https://github.com/fail2ban/fail2ban.git

# install by yum
yum install fail2ban fail2ban-systemd
```

安装过程：
```
creating /etc/fail2ban/fail2ban.d
creating /etc/fail2ban/jail.d
creating /var/lib/fail2ban
creating /run/fail2ban
creating /usr/share/doc/fail2ban
copying README.md -> /usr/share/doc/fail2ban
copying DEVELOP -> /usr/share/doc/fail2ban
copying FILTERS -> /usr/share/doc/fail2ban
copying doc/run-rootless.txt -> /usr/share/doc/fail2ban
running install_egg_info
running egg_info
creating fail2ban.egg-info
writing fail2ban.egg-info/PKG-INFO
writing dependency_links to fail2ban.egg-info/dependency_links.txt
writing top-level names to fail2ban.egg-info/top_level.txt
writing manifest file 'fail2ban.egg-info/SOURCES.txt'
reading manifest file 'fail2ban.egg-info/SOURCES.txt'
reading manifest template 'MANIFEST.in'
writing manifest file 'fail2ban.egg-info/SOURCES.txt'
Copying fail2ban.egg-info to /usr/local/lib/python3.6/site-packages/fail2ban-1.0.1.dev1-py3.6.egg-info
running install_scripts
copying build/scripts-3.6/fail2ban-client -> /usr/local/bin
copying build/scripts-3.6/fail2ban-regex -> /usr/local/bin
copying build/scripts-3.6/fail2ban-testcases -> /usr/local/bin
copying build/scripts-3.6/fail2ban-server -> /usr/local/bin
WARNING: Cannot find root-base option, check the bin-path to fail2ban-scripts in "fail2ban.service".
Creating build/fail2ban.service (from fail2ban.service.in): @BINDIR@ -> /usr/local/bin
creating fail2ban-python binding -> /usr/local/bin
changing mode of /usr/local/bin/fail2ban-client to 755
changing mode of /usr/local/bin/fail2ban-regex to 755
changing mode of /usr/local/bin/fail2ban-testcases to 755
changing mode of /usr/local/bin/fail2ban-server to 755
```

### file arch

```
pi@raspberrypi:~ $ find / -name "*fail2ban*" 2> /dev/null
/usr/bin/fail2ban-testcases
/usr/bin/fail2ban-regex
/usr/bin/fail2ban-server
/usr/bin/fail2ban-client
/usr/bin/fail2ban-python

/usr/lib/python3/dist-packages/fail2ban
/usr/lib/python3/dist-packages/fail2ban/client/fail2banreader.py
/usr/lib/tmpfiles.d/fail2ban-tmpfiles.conf
/usr/share/doc/fail2ban/examples/cacti/fail2ban_stats.sh
/var/cache/apt/archives/fail2ban_0.9.6-2_all.deb
/var/lib/dpkg/info/fail2ban.list
/var/lib/fail2ban/fail2ban.sqlite3
/var/lib/systemd/deb-systemd-helper-enabled/fail2ban.service.dsh-also
/var/lib/systemd/deb-systemd-helper-enabled/multi-user.target.wants/fail2ban.service
/var/log/fail2ban.log
/run/fail2ban
/lib/systemd/system/fail2ban.service
/etc/logrotate.d/fail2ban
/etc/rc3.d/S03fail2ban
/etc/monit/monitrc.d/fail2ban
/etc/rc5.d/S03fail2ban
/etc/rc2.d/S03fail2ban
/etc/rc4.d/S03fail2ban
/etc/rc6.d/K01fail2ban
/etc/rc1.d/K01fail2ban
/etc/fail2ban
/etc/fail2ban/fail2ban.conf
/etc/fail2ban/fail2ban.d
/etc/default/fail2ban
/etc/systemd/system/multi-user.target.wants/fail2ban.service
/etc/bash_completion.d/fail2ban
/etc/init.d/fail2ban
/etc/rc0.d/K01fail2ban

```


> 你永远应该使用fail2ban-client而不是直接使用fail2ban-server。

## help
### fail2ban-client


```
fail2ban-client status sshd
```


```
pi@raspberrypi:~ $ sudo fail2ban-client --help
Usage: /usr/bin/fail2ban-client [OPTIONS] <COMMAND>

Fail2Ban v0.9.6 reads log file that contains password failure report
and bans the corresponding IP addresses using firewall rules.

Options:
    -c <DIR>                configuration directory
    -s <FILE>               socket path
    -p <FILE>               pidfile path
    -d                      dump configuration. For debugging
    -i                      interactive mode
    -v                      increase verbosity
    -q                      decrease verbosity
    -x                      force execution of the server (remove socket file)
    -b                      start server in background (default)
    -f                      start server in foreground (note that the client forks once itself)
    -h, --help              display this help message
    -V, --version           print the version

Command:
                                             BASIC
    start                                    starts the server and the jails
    reload                                   reloads the configuration
    reload <JAIL>                            reloads the jail <JAIL>
    stop                                     stops all jails and terminate the
                                             server
    status                                   gets the current status of the
                                             server
    ping                                     tests if the server is alive
    help                                     return this output
    version                                  return the server version

                                             LOGGING
    set loglevel <LEVEL>                     sets logging level to <LEVEL>.
                                             Levels: CRITICAL, ERROR, WARNING,
                                             NOTICE, INFO, DEBUG
    get loglevel                             gets the logging level
    set logtarget <TARGET>                   sets logging target to <TARGET>.
                                             Can be STDOUT, STDERR, SYSLOG or a
                                             file
    get logtarget                            gets logging target
    set syslogsocket auto|<SOCKET>           sets the syslog socket path to
                                             auto or <SOCKET>. Only used if
                                             logtarget is SYSLOG
    get syslogsocket                         gets syslog socket path
    flushlogs                                flushes the logtarget if a file
                                             and reopens it. For log rotation.

                                             DATABASE
    set dbfile <FILE>                        set the location of fail2ban
                                             persistent datastore. Set to
                                             "None" to disable
    get dbfile                               get the location of fail2ban
                                             persistent datastore
    set dbpurgeage <SECONDS>                 sets the max age in <SECONDS> that
                                             history of bans will be kept
    get dbpurgeage                           gets the max age in seconds that
                                             history of bans will be kept

                                             JAIL CONTROL
    add <JAIL> <BACKEND>                     creates <JAIL> using <BACKEND>
    start <JAIL>                             starts the jail <JAIL>
    stop <JAIL>                              stops the jail <JAIL>. The jail is
                                             removed
    status <JAIL> [FLAVOR]                   gets the current status of <JAIL>,
                                             with optional flavor or extended
                                             info

                                             JAIL CONFIGURATION
    set <JAIL> idle on|off                   sets the idle state of <JAIL>
    set <JAIL> addignoreip <IP>              adds <IP> to the ignore list of
                                             <JAIL>
    set <JAIL> delignoreip <IP>              removes <IP> from the ignore list
                                             of <JAIL>
    set <JAIL> addlogpath <FILE> ['tail']    adds <FILE> to the monitoring list
                                             of <JAIL>, optionally starting at
                                             the 'tail' of the file (default
                                             'head').
    set <JAIL> dellogpath <FILE>             removes <FILE> from the monitoring
                                             list of <JAIL>
    set <JAIL> logencoding <ENCODING>        sets the <ENCODING> of the log
                                             files for <JAIL>
    set <JAIL> addjournalmatch <MATCH>       adds <MATCH> to the journal filter
                                             of <JAIL>
    set <JAIL> deljournalmatch <MATCH>       removes <MATCH> from the journal
                                             filter of <JAIL>
    set <JAIL> addfailregex <REGEX>          adds the regular expression
                                             <REGEX> which must match failures
                                             for <JAIL>
    set <JAIL> delfailregex <INDEX>          removes the regular expression at
                                             <INDEX> for failregex
    set <JAIL> ignorecommand <VALUE>         sets ignorecommand of <JAIL>
    set <JAIL> addignoreregex <REGEX>        adds the regular expression
                                             <REGEX> which should match pattern
                                             to exclude for <JAIL>
    set <JAIL> delignoreregex <INDEX>        removes the regular expression at
                                             <INDEX> for ignoreregex
    set <JAIL> findtime <TIME>               sets the number of seconds <TIME>
                                             for which the filter will look
                                             back for <JAIL>
    set <JAIL> bantime <TIME>                sets the number of seconds <TIME>
                                             a host will be banned for <JAIL>
    set <JAIL> datepattern <PATTERN>         sets the <PATTERN> used to match
                                             date/times for <JAIL>
    set <JAIL> usedns <VALUE>                sets the usedns mode for <JAIL>
    set <JAIL> banip <IP>                    manually Ban <IP> for <JAIL>
    set <JAIL> unbanip <IP>                  manually Unban <IP> in <JAIL>
    set <JAIL> maxretry <RETRY>              sets the number of failures
                                             <RETRY> before banning the host
                                             for <JAIL>
    set <JAIL> maxlines <LINES>              sets the number of <LINES> to
                                             buffer for regex search for <JAIL>
    set <JAIL> addaction <ACT>[ <PYTHONFILE> <JSONKWARGS>]
                                             adds a new action named <ACT> for
                                             <JAIL>. Optionally for a Python
                                             based action, a <PYTHONFILE> and
                                             <JSONKWARGS> can be specified,
                                             else will be a Command Action
    set <JAIL> delaction <ACT>               removes the action <ACT> from
                                             <JAIL>

                                             COMMAND ACTION CONFIGURATION
    set <JAIL> action <ACT> actionstart <CMD>
                                             sets the start command <CMD> of
                                             the action <ACT> for <JAIL>
    set <JAIL> action <ACT> actionstop <CMD> sets the stop command <CMD> of the
                                             action <ACT> for <JAIL>
    set <JAIL> action <ACT> actioncheck <CMD>
                                             sets the check command <CMD> of
                                             the action <ACT> for <JAIL>
    set <JAIL> action <ACT> actionban <CMD>  sets the ban command <CMD> of the
                                             action <ACT> for <JAIL>
    set <JAIL> action <ACT> actionunban <CMD>
                                             sets the unban command <CMD> of
                                             the action <ACT> for <JAIL>
    set <JAIL> action <ACT> timeout <TIMEOUT>
                                             sets <TIMEOUT> as the command
                                             timeout in seconds for the action
                                             <ACT> for <JAIL>

                                             GENERAL ACTION CONFIGURATION
    set <JAIL> action <ACT> <PROPERTY> <VALUE>
                                             sets the <VALUE> of <PROPERTY> for
                                             the action <ACT> for <JAIL>
    set <JAIL> action <ACT> <METHOD>[ <JSONKWARGS>]
                                             calls the <METHOD> with
                                             <JSONKWARGS> for the action <ACT>
                                             for <JAIL>

                                             JAIL INFORMATION
    get <JAIL> logpath                       gets the list of the monitored
                                             files for <JAIL>
    get <JAIL> logencoding                   gets the encoding of the log files
                                             for <JAIL>
    get <JAIL> journalmatch                  gets the journal filter match for
                                             <JAIL>
    get <JAIL> ignoreip                      gets the list of ignored IP
                                             addresses for <JAIL>
    get <JAIL> ignorecommand                 gets ignorecommand of <JAIL>
    get <JAIL> failregex                     gets the list of regular
                                             expressions which matches the
                                             failures for <JAIL>
    get <JAIL> ignoreregex                   gets the list of regular
                                             expressions which matches patterns
                                             to ignore for <JAIL>
    get <JAIL> findtime                      gets the time for which the filter
                                             will look back for failures for
                                             <JAIL>
    get <JAIL> bantime                       gets the time a host is banned for
                                             <JAIL>
    get <JAIL> datepattern                   gets the patern used to match
                                             date/times for <JAIL>
    get <JAIL> usedns                        gets the usedns setting for <JAIL>
    get <JAIL> maxretry                      gets the number of failures
                                             allowed for <JAIL>
    get <JAIL> maxlines                      gets the number of lines to buffer
                                             for <JAIL>
    get <JAIL> actions                       gets a list of actions for <JAIL>

                                             COMMAND ACTION INFORMATION
    get <JAIL> action <ACT> actionstart      gets the start command for the
                                             action <ACT> for <JAIL>
    get <JAIL> action <ACT> actionstop       gets the stop command for the
                                             action <ACT> for <JAIL>
    get <JAIL> action <ACT> actioncheck      gets the check command for the
                                             action <ACT> for <JAIL>
    get <JAIL> action <ACT> actionban        gets the ban command for the
                                             action <ACT> for <JAIL>
    get <JAIL> action <ACT> actionunban      gets the unban command for the
                                             action <ACT> for <JAIL>
    get <JAIL> action <ACT> timeout          gets the command timeout in
                                             seconds for the action <ACT> for
                                             <JAIL>

                                             GENERAL ACTION INFORMATION
    get <JAIL> actionproperties <ACT>        gets a list of properties for the
                                             action <ACT> for <JAIL>
    get <JAIL> actionmethods <ACT>           gets a list of methods for the
                                             action <ACT> for <JAIL>
    get <JAIL> action <ACT> <PROPERTY>       gets the value of <PROPERTY> for
                                             the action <ACT> for <JAIL>
```                                             