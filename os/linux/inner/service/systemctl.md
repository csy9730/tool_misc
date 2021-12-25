# systemctl


- systemctl
- service
- chkconfig

centos下有chkconfig，ubuntu 下默认没有chkconfig。

注意：在CentOS7.0后，不再使用service,而是systemctl 。centos7.0是向下兼容的，也是可以用service.




service常用命令就是启动，停止，重启动和查看服务，这些与之相对systemctl都有对应，下面列出相对应的命令

chkconfig常用于查看系统开机自动的服务，这些也可被systemctl代替
## systemctl

Systemd是由红帽公司的一名叫做Lennart Poettering的员工开发，systemd是Linux系统中最新的初始化系统（init）,它主要的设计目的是克服Sys V 固有的缺点，提高系统的启动速度。

systemd和upstart是竞争对手，ubantu上使用的是upstart的启动方式，centos7上使用systemd替换了Sys V，Systemd目录是要取代Unix时代依赖一直在使用的init系统，兼容SysV和LSB的启动脚本，

而且能够在进程启动中更有效地引导加载服务。
system：系统启动和服务器守护进程管理器，负责在系统启动或运行时，激活系统资源，服务器进程和其他进程，根据管理，字母d是守护进程（daemon）的缩写，systemd这个名字的含义就是它要守护整个系统。



systemctl是CentOS7的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。


### main

管理服务(unit)

systemctl 提供了一组子命令来管理单个的 unit，其命令格式为：

systemctl [command] [unit]

command 主要有：

start：立刻启动后面接的 unit。

stop：立刻关闭后面接的 unit。

restart：立刻关闭后启动后面接的 unit，亦即执行 stop 再 start 的意思。

reload：不关闭 unit 的情况下，重新载入配置文件，让设置生效。

enable：设置下次开机时，后面接的 unit 会被启动。

disable：设置下次开机时，后面接的 unit 不会被启动。

status：目前后面接的这个 unit 的状态，会列出有没有正在执行、开机时是否启动等信息。

is-active：目前有没有正在运行中。

is-enabled：开机时有没有默认要启用这个 unit。

kill ：不要被 kill 这个名字吓着了，它其实是向运行 unit 的进程发送信号。

show：列出 unit 的配置。

mask：注销 unit，注销后你就无法启动这个 unit 了。

unmask：取消对 unit 的注销。

list-units 显示所有启动项。

get-default：取得目前的 target。

```
start NAME...                   Start (activate) one or more units
stop NAME...                    Stop (deactivate) one or more units
reload NAME...                  Reload one or more units
restart NAME...                 Start or restart one or more units
status [PATTERN...|PID...]      Show runtime status of one or more units
show [PATTERN...|JOB...]        Show properties of one or more

enable [NAME...|PATH...]        Enable one or more unit files
disable NAME...                 Disable one or more unit files
reenable NAME...                Reenable one or more unit files
  ```


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

###  /etc/systemd/
ubuntu： 服务在目录下`/lib/systemd/system/foo.service`，开机启动项的服务在`/etc/systemd/system/multiuser.target.wants/ssh.service`

 - /lib/systemd/system 包含服务项
     - /lib/systemd/system/knockd.service 一个服务配置
 - /usr/lib/systemd/system  （和/usr/lib/systemd/system 内容近乎相同）
 - /etc/systemd/system/
     - /etc/systemd/system/multiuser.target.wants/ssh.service 开机启动项
 



### systemctl suspend
``` bash
sudo systemctl poweroff # 系统关机

sudo systemctl reboot  # 重新开机

sudo systemctl suspend  # 进入暂停模式

sudo systemctl hibernate # 进入休眠模式

sudo systemctl rescue  # 强制进入救援模式

sudo systemctl emergency # 强制进入紧急救援模式

```
suspend：暂停模式会将系统的状态保存到内存中，然后关闭掉大部分的系统硬件，当然，并没有实际关机。当用户按下唤醒机器的按钮，系统数据会从内存中回复，然后重新驱动被大部分关闭的硬件，所以唤醒系统的速度比较快。

hibernate：休眠模式则是将系统状态保存到硬盘当中，保存完毕后，将计算机关机。当用户尝试唤醒系统时，系统会开始正常运行，然后将保存在硬盘中的系统状态恢复回来。因为数据需要从硬盘读取，因此唤醒的速度比较慢(如果你使用的是 SSD 磁盘，唤醒的速度也是非常快的)。


### help
```
systemctl --help
systemctl [OPTIONS...] {COMMAND} ...

Query or send control commands to the systemd manager.

  -h --help           Show this help
     --version        Show package version
     --system         Connect to system manager
     --user           Connect to user service manager
  -H --host=[USER@]HOST
                      Operate on remote host
  -M --machine=CONTAINER
                      Operate on local container
  -t --type=TYPE      List units of a particular type
     --state=STATE    List units with particular LOAD or SUB or ACTIVE state
  -p --property=NAME  Show only properties by this name
  -a --all            Show all properties/all units currently in memory,
                      including dead/empty ones. To list all units installed on
                      the system, use the 'list-unit-files' command instead.
     --failed         Same as --state=failed
  -l --full           Don't ellipsize unit names on output
  -r --recursive      Show unit list of host and local containers
     --reverse        Show reverse dependencies with 'list-dependencies'
     --job-mode=MODE  Specify how to deal with already queued jobs, when
                      queueing a new job
     --show-types     When showing sockets, explicitly show their type
     --value          When showing properties, only print the value
  -i --ignore-inhibitors
                      When shutting down or sleeping, ignore inhibitors
     --kill-who=WHO   Who to send signal to
  -s --signal=SIGNAL  Which signal to send
     --now            Start or stop unit in addition to enabling or disabling it
     --dry-run        Only print what would be done
  -q --quiet          Suppress output
     --wait           For (re)start, wait until service stopped again
     --no-block       Do not wait until operation finished
     --no-wall        Don't send wall message before halt/power-off/reboot
     --no-reload      Don't reload daemon after en-/dis-abling unit files
     --no-legend      Do not print a legend (column headers and hints)
     --no-pager       Do not pipe output into a pager
     --no-ask-password
                      Do not ask for system passwords
     --global         Enable/disable/mask unit files globally
     --runtime        Enable/disable/mask unit files temporarily until next
                      reboot
  -f --force          When enabling unit files, override existing symlinks
                      When shutting down, execute action immediately
     --preset-mode=   Apply only enable, only disable, or all presets
     --root=PATH      Enable/disable/mask unit files in the specified root
                      directory
  -n --lines=INTEGER  Number of journal entries to show
  -o --output=STRING  Change journal output mode (short, short-precise,
                             short-iso, short-iso-precise, short-full,
                             short-monotonic, short-unix,
                             verbose, export, json, json-pretty, json-sse, cat)
     --firmware-setup Tell the firmware to show the setup menu on next boot
     --plain          Print unit dependencies as a list instead of a tree

Unit Commands:
  list-units [PATTERN...]         List units currently in memory
  list-sockets [PATTERN...]       List socket units currently in memory, ordered
                                  by address
  list-timers [PATTERN...]        List timer units currently in memory, ordered
                                  by next elapse
  start NAME...                   Start (activate) one or more units
  stop NAME...                    Stop (deactivate) one or more units
  reload NAME...                  Reload one or more units
  restart NAME...                 Start or restart one or more units
  try-restart NAME...             Restart one or more units if active
  reload-or-restart NAME...       Reload one or more units if possible,
                                  otherwise start or restart
  try-reload-or-restart NAME...   If active, reload one or more units,
                                  if supported, otherwise restart
  isolate NAME                    Start one unit and stop all others
  kill NAME...                    Send signal to processes of a unit
  is-active PATTERN...            Check whether units are active
  is-failed PATTERN...            Check whether units are failed
  status [PATTERN...|PID...]      Show runtime status of one or more units
  show [PATTERN...|JOB...]        Show properties of one or more
                                  units/jobs or the manager
  cat PATTERN...                  Show files and drop-ins of one or more units
  set-property NAME ASSIGNMENT... Sets one or more properties of a unit
  help PATTERN...|PID...          Show manual for one or more units
  reset-failed [PATTERN...]       Reset failed state for all, one, or more
                                  units
  list-dependencies [NAME]        Recursively show units which are required
                                  or wanted by this unit or by which this
                                  unit is required or wanted

Unit File Commands:
  list-unit-files [PATTERN...]    List installed unit files
  enable [NAME...|PATH...]        Enable one or more unit files
  disable NAME...                 Disable one or more unit files
  reenable NAME...                Reenable one or more unit files
  preset NAME...                  Enable/disable one or more unit files
                                  based on preset configuration
  preset-all                      Enable/disable all unit files based on
                                  preset configuration
  is-enabled NAME...              Check whether unit files are enabled
  mask NAME...                    Mask one or more units
  unmask NAME...                  Unmask one or more units
  link PATH...                    Link one or more units files into
                                  the search path
  revert NAME...                  Revert one or more unit files to vendor
                                  version
  add-wants TARGET NAME...        Add 'Wants' dependency for the target
                                  on specified one or more units
  add-requires TARGET NAME...     Add 'Requires' dependency for the target
                                  on specified one or more units
  edit NAME...                    Edit one or more unit files
  get-default                     Get the name of the default target
  set-default NAME                Set the default target

Machine Commands:
  list-machines [PATTERN...]      List local containers and host

Job Commands:
  list-jobs [PATTERN...]          List jobs
  cancel [JOB...]                 Cancel all, one, or more jobs

Environment Commands:
  show-environment                Dump environment
  set-environment NAME=VALUE...   Set one or more environment variables
  unset-environment NAME...       Unset one or more environment variables
  import-environment [NAME...]    Import all or some environment variables

Manager Lifecycle Commands:
  daemon-reload                   Reload systemd manager configuration
  daemon-reexec                   Reexecute systemd manager

System Commands:
  is-system-running               Check whether system is fully running
  default                         Enter system default mode
  rescue                          Enter system rescue mode
  emergency                       Enter system emergency mode
  halt                            Shut down and halt the system
  poweroff                        Shut down and power-off the system
  reboot [ARG]                    Shut down and reboot the system
  kexec                           Shut down and reboot the system with kexec
  exit [EXIT_CODE]                Request user instance or container exit
  switch-root ROOT [INIT]         Change to a different root file system
  suspend                         Suspend the system
  hibernate                       Hibernate the system
  hybrid-sleep                    Hibernate and suspend the system
  suspend-then-hibernate          Suspend the system, wake after a period of
                                  time and put it into hibernate
```

### frpc demo
``` ini

```
