# timeout
执行一条命令，如果超时就杀死该命令。

## help
```
$ timeout --help
Usage: timeout [OPTION] DURATION COMMAND [ARG]...
  or:  timeout [OPTION]
Start COMMAND, and kill it if still running after DURATION.

Mandatory arguments to long options are mandatory for short options too.
      --preserve-status
                 exit with the same status as COMMAND, even when the
                   command times out
      --foreground
                 when not running timeout directly from a shell prompt,
                   allow COMMAND to read from the TTY and get TTY signals;
                   in this mode, children of COMMAND will not be timed out
  -k, --kill-after=DURATION
                 also send a KILL signal if COMMAND is still running
                   this long after the initial signal was sent
  -s, --signal=SIGNAL
                 specify the signal to be sent on timeout;
                   SIGNAL may be a name like 'HUP' or a number;
                   see 'kill -l' for a list of signals
  -v, --verbose  diagnose to stderr any signal sent upon timeout
      --help     display this help and exit
      --version  output version information and exit

DURATION is a floating point number with an optional suffix:
's' for seconds (the default), 'm' for minutes, 'h' for hours or 'd' for days.
A duration of 0 disables the associated timeout.

If the command times out, and --preserve-status is not set, then exit with
status 124.  Otherwise, exit with the status of COMMAND.  If no signal
is specified, send the TERM signal upon timeout.  The TERM signal kills
any process that does not block or catch that signal.  It may be necessary
to use the KILL (9) signal, since this signal cannot be caught, in which
case the exit status is 128+9 rather than 124.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report timeout translation bugs to <https://translationproject.org/team/>
Full documentation at: <https://www.gnu.org/software/coreutils/timeout>
or available locally via: info '(coreutils) timeout invocation'

```

使用示例：
ping 一个网址，超过4秒就自动退出。
``` bash
$ timeout 4 ping www.baidu.com
PING www.a.shifen.com (14.215.177.39) 56(84) bytes of data.
64 bytes from 14.215.177.39 (14.215.177.39): icmp_seq=1 ttl=52 time=8.17 ms
64 bytes from 14.215.177.39 (14.215.177.39): icmp_seq=2 ttl=52 time=8.21 ms
64 bytes from 14.215.177.39 (14.215.177.39): icmp_seq=3 ttl=52 time=8.19 ms
64 bytes from 14.215.177.39 (14.215.177.39): icmp_seq=4 ttl=52 time=8.23 ms
```
