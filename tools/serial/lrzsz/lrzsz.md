# lrzsz


在使用Linux的过程中，难免少不了需要上传下载文件，比如往服务器上传一些war包之类的，之前都是使用winSCP，lrzsz是一个更方便的命令，可以直接在Linux中输入命令，弹出一个框来选择上传的文件或者下载的文件保存的位置，然后确定就OK了。lrzsz并不是内置命令，默认情况下大多数Linux版本都没有这个命令，需要自己安装才可以使用。


## 如何安装

电脑上可以使用包安装。下位机上就只能交叉编译安装了。
### package
电脑上可以使用包安装。
```
apt install lrzsz
```

### compile

在官网下载lrzsz的最新发行版本：https://ohse.de/uwe/software/lrzsz.html

下载安装包：

```bash
wget https://ohse.de/uwe/releases/lrzsz-0.12.20.tar.gz
```

解压：

```
tar zxvf lrzsz-0.12.20.tar.gz
```

进入解压后的目录， 配置，编译，安装：

``` bash
export CC=gcc # 交叉编译需要配置编译器
./configure 
make && make install
```


进入/usr/bin目录，为之前安装的文件创建软链接：

```
ln -s /usr/local/bin/lrz rz
ln -s /usr/local/bin/lsz sz
```

## usage

rz，接受文件，下载文件

sz， 发送文件，上传文件

### rz

输入 `rz -h` 可以查看帮助文档：

```
rz version 0.12.20
Usage: rz [options] [filename.if.xmodem]
Receive files with ZMODEM/YMODEM/XMODEM protocol
    (X) = option applies to XMODEM only
    (Y) = option applies to YMODEM only
    (Z) = option applies to ZMODEM only
  -+, --append                append to existing files
  -a, --ascii                 ASCII transfer (change CR/LF to LF)
  -b, --binary                binary transfer
  -B, --bufsize N             buffer N bytes (N==auto: buffer whole file)
  -c, --with-crc              Use 16 bit CRC (X)
  -C, --allow-remote-commands allow execution of remote commands (Z)
  -D, --null                  write all received data to /dev/null
      --delay-startup N       sleep N seconds before doing anything
  -e, --escape                Escape control characters (Z)
  -E, --rename                rename any files already existing
      --errors N              generate CRC error every N bytes (debugging)
  -h, --help                  Help, print this usage message
  -m, --min-bps N             stop transmission if BPS below N
  -M, --min-bps-time N          for at least N seconds (default: 120)
  -O, --disable-timeouts      disable timeout code, wait forever for data
      --o-sync                open output file(s) in synchronous write mode
  -p, --protect               protect existing files
  -q, --quiet                 quiet, no progress reports
  -r, --resume                try to resume interrupted file transfer (Z)
  -R, --restricted            restricted, more secure mode
  -s, --stop-at {HH:MM|+N}    stop transmission at HH:MM or in N seconds
  -S, --timesync              request remote time (twice: set local time)
      --syslog[=off]          turn syslog on or off, if possible
  -t, --timeout N             set timeout to N tenths of a second
  -u, --keep-uppercase        keep upper case filenames
  -U, --unrestrict            disable restricted mode (if allowed to)
  -v, --verbose               be verbose, provide debugging information
  -w, --windowsize N          Window is N bytes (Z)
  -X  --xmodem                use XMODEM protocol
  -y, --overwrite             Yes, clobber existing file if any
      --ymodem                use YMODEM protocol
  -Z, --zmodem                use ZMODEM protocol
 
short options use the same arguments as the long ones
```

 #### sz

``` bash
sz version 0.12.21rc
Usage: sz [options] file ...
   or: sz [options] -{c|i} COMMAND
Send file(s) with ZMODEM/YMODEM/XMODEM protocol
    (X) = option applies to XMODEM only
    (Y) = option applies to YMODEM only
    (Z) = option applies to ZMODEM only
  -+, --append                append to existing destination file (Z)
  -2, --twostop               use 2 stop bits
  -4, --try-4k                go up to 4K blocksize
      --start-4k              start with 4K blocksize (doesn't try 8)
  -8, --try-8k                go up to 8K blocksize
      --start-8k              start with 8K blocksize
  -a, --ascii                 ASCII transfer (change CR/LF to LF)
  -b, --binary                binary transfer
  -B, --bufsize N             buffer N bytes (N==auto: buffer whole file)
  -c, --command COMMAND       execute remote command COMMAND (Z)
  -C, --command-tries N       try N times to execute a command (Z)
  -d, --dot-to-slash          change '.' to '/' in pathnames (Y/Z)
      --delay-startup N       sleep N seconds before doing anything
  -e, --escape                escape all control characters (Z)
  -E, --rename                force receiver to rename files it already has
  -f, --full-path             send full pathname (Y/Z)
  -i, --immediate-command CMD send remote CMD, return immediately (Z)
  -h, --help                  print this usage message
  -k, --1k                    send 1024 byte packets (X)
  -L, --packetlen N           limit subpacket length to N bytes (Z)
  -l, --framelen N            limit frame length to N bytes (l>=L) (Z)
  -m, --min-bps N             stop transmission if BPS below N
  -M, --min-bps-time N          for at least N seconds (default: 120)
  -n, --newer                 send file if source newer (Z)
  -N, --newer-or-longer       send file if source newer or longer (Z)
  -o, --16-bit-crc            use 16 bit CRC instead of 32 bit CRC (Z)
  -O, --disable-timeouts      disable timeout code, wait forever
  -p, --protect               protect existing destination file (Z)
  -r, --resume                resume interrupted file transfer (Z)
  -R, --restricted            restricted, more secure mode
  -q, --quiet                 quiet (no progress reports)
  -s, --stop-at {HH:MM|+N}    stop transmission at HH:MM or in N seconds
      --tcp-server            open socket, wait for connection (Z)
      --tcp-client ADDR:PORT  open socket, connect to ... (Z)
  -u, --unlink                unlink file after transmission
  -U, --unrestrict            turn off restricted mode (if allowed to)
  -v, --verbose               be verbose, provide debugging information
  -w, --windowsize N          Window is N bytes (Z)
  -X, --xmodem                use XMODEM protocol
  -y, --overwrite             overwrite existing files
  -Y, --overwrite-or-skip     overwrite existing files, else skip
      --ymodem                use YMODEM protocol
  -Z, --zmodem                use ZMODEM protocol

short options use the same arguments as the long ones
```



### reference

参考文档：

[lrzsz](https://ohse.de/uwe/software/lrzsz.html)