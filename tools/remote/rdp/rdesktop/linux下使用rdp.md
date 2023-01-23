# linux下使用rdp

简单的说就是在linux下如何远程终端连接一台windows的服务器。

在windwos下我们直接可以mstsc开启远程终端的连接。而linux下呢。就需要安装一款工具了。
## install
命令：`sudo apt-get install rdesktop`

默认端口是3389

注意：windows 的服务中的 Terminal Servies 需要开启。我的电脑 右键 属性 远程中，勾选 允许远程用户链接到此计算机。另外，退出的时候选择注销，而不是关机！

## useage

参数:

- -r disk:MyDisk=/home/comet/temp就是把你的Linux下某个文件夹挂载到远程主机上
  - -r clipboard:PRIMARYCLIPBOARD是允许在远程主机和本机之间共享剪切板，就是可以复制粘贴。
  - -r disk:wj=/home/magicgod 映射虚拟盘，可选，会在远程机器的网上邻居里虚拟出一个映射盘，功能很强，甚至可以是软盘或光盘
  - -r sound:off 关闭声音，当然也可以把远程发的声音映射到本地来。
- -x lan|modem：用来决定网络带宽，如果带宽宽的话，选择lan，则可以将桌面背景也传过来，默认是没有桌面背景的；有壁纸的感觉好好哦
- -f 全屏
- -u xxxxxx 登录用户，可选
- -p xxxxxx 登录密码，可选
- -a 16 颜色，可选，不过最高就是16位
- -z 压缩，可选
- -g 1024x768 分辨率，可选，缺省是一种比当前本地桌面低的分辨率
- -P 缓冲，可选


### demo
`rdesktop  ip`即可。

### demo2

```  bash
# 文件夹挂载到远程主机
rdesktop -f -r disk:MyDisk=~/temp ip


# 全屏，直接输入用户名和密码
rdesktop -f 192.168.0.184 -u Test3 -p 2013@Miqilai

# 共享剪切板
rdesktop -r clipboard:PRIMARYCLIPBOARD ip

```


### misc
**Q**: rdesktop退出全屏模式 ：

**A**: 使用组合键ctrl+alt+enter进行切换。




## help
```
rdesktop --help
rdesktop: invalid option -- '-'
rdesktop: A Remote Desktop Protocol client.
Version 1.8.3. Copyright (C) 1999-2011 Matthew Chapman et al.
See http://www.rdesktop.org/ for more information.

Usage: rdesktop [options] server[:port]
   -u: user name
   -d: domain
   -s: shell / seamless application to start remotly
   -c: working directory
   -p: password (- to prompt)
   -n: client hostname
   -k: keyboard layout on server (en-us, de, sv, etc.)
   -g: desktop geometry (WxH)
   -i: enables smartcard authentication, password is used as pin
   -f: full-screen mode
   -b: force bitmap updates
   -L: local codepage
   -A: path to SeamlessRDP shell, this enables SeamlessRDP mode
   -B: use BackingStore of X-server (if available)
   -e: disable encryption (French TS)
   -E: disable encryption from client to server
   -m: do not send motion events
   -C: use private colour map
   -D: hide window manager decorations
   -K: keep window manager key bindings
   -S: caption button size (single application mode)
   -T: window title
   -t: disable use of remote ctrl
   -N: enable numlock syncronization
   -X: embed into another window with a given id.
   -a: connection colour depth
   -z: enable rdp compression
   -x: RDP5 experience (m[odem 28.8], b[roadband], l[an] or hex nr.)
   -P: use persistent bitmap caching
   -r: enable specified device redirection (this flag can be repeated)
         '-r comport:COM1=/dev/ttyS0': enable serial redirection of /dev/ttyS0 to COM1
             or      COM1=/dev/ttyS0,COM2=/dev/ttyS1
         '-r disk:floppy=/mnt/floppy': enable redirection of /mnt/floppy to 'floppy' share
             or   'floppy=/mnt/floppy,cdrom=/mnt/cdrom'
         '-r clientname=<client name>': Set the client name displayed
             for redirected disks
         '-r lptport:LPT1=/dev/lp0': enable parallel redirection of /dev/lp0 to LPT1
             or      LPT1=/dev/lp0,LPT2=/dev/lp1
         '-r printer:mydeskjet': enable printer redirection
             or      mydeskjet="HP LaserJet IIIP" to enter server driver as well
         '-r sound:[local[:driver[:device]]|off|remote]': enable sound redirection
                     remote would leave sound on server
                     available drivers for 'local':
                     alsa:      ALSA output driver, default device: default
         '-r clipboard:[off|PRIMARYCLIPBOARD|CLIPBOARD]': enable clipboard
                      redirection.
                      'PRIMARYCLIPBOARD' looks at both PRIMARY and CLIPBOARD
                      when sending data to server.
                      'CLIPBOARD' looks at only CLIPBOARD.
         '-r scard[:"Scard Name"="Alias Name[;Vendor Name]"[,...]]
          example: -r scard:"eToken PRO 00 00"="AKS ifdh 0"
                   "eToken PRO 00 00" -> Device in Linux/Unix enviroment
                   "AKS ifdh 0"       -> Device shown in Windows enviroment 
          example: -r scard:"eToken PRO 00 00"="AKS ifdh 0;AKS"
                   "eToken PRO 00 00" -> Device in Linux/Unix enviroment
                   "AKS ifdh 0"       -> Device shown in Windows enviroment 
                   "AKS"              -> Device vendor name                 
   -0: attach to console
   -4: use RDP version 4
   -5: use RDP version 5 (default)
   -o: name=value: Adds an additional option to rdesktop.
           sc-csp-name        Specifies the Crypto Service Provider name which
                              is used to authenticate the user by smartcard
           sc-container-name  Specifies the container name, this is usally the username
           sc-reader-name     Smartcard reader name to use
           sc-card-name       Specifies the card name of the smartcard to use

```
