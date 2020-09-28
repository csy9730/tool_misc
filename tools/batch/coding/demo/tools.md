

### 用ftp命令实现自动下载
ftp是常用的下载工具，ftp界面中有40多个常用命令，自己学习了，不介绍了。这里介绍如何用dos命令行调用ftp命令，实现ftp自动登录，并上传下载，并自动退出ftp程序。
其实可以将ftp命令组合保存为一个文本文件，然后用以下命令调用即可。
ftp  -n -s:[[drive:]path]filename
上面的filename为ftp命令文件，包括登录IP地址，用户名、密码、操作命令等
例：
``` bash
open 90.52.8.3   ＃ 打开ip
user iware       ＃ 用户为iware
password8848    ＃ 密码
bin             ＃ 二进制传输模式
prompt
cd tmp1         ＃切换至iware用户下的tmp1目录
pwd
lcd d:\download   ＃ 本地目录
mget *          ＃ 下载tmp1目录下的所有文件
bye             ＃ 退出ftp
```

### 用7-ZIP实现命令行压缩和解压功能
语法格式：（详细情况见7-zip帮助文件，看得头晕可以跳过，用到再学）
7z <command> [<switch>...] <base_archive_name> [<arguments>...]
7z.exe的每个命令都有不同的参数<switch>,请看帮助文件
<base_archive_name>为压缩包名称
<arguments>为文件名称，支持通配符或文件列表
其中，7z是至命令行压缩解压程序7z.exe，<command>是7z.exe包含的命令，列举如下：
a： Adds files to archive. 添加至压缩包
a命令可用参数：
  -i (Include)
  -m (Method)
  -p (Set Password)
  -r (Recurse)
  -sfx (create SFX)
  -si (use StdIn)
  -so (use StdOut)
  -ssw (Compress shared files)
  -t (Type of archive)
  -u (Update)
  -v (Volumes)
  -w (Working Dir)
  -x (Exclude) 
b： Benchmark 
d： Deletes files from archive. 从压缩包中删除文件
d命令可用参数：
  -i (Include)
  -m (Method)
  -p (Set Password)
  -r (Recurse)
  -u (Update)
  -w (Working Dir)
  -x (Exclude) 
e： Extract解压文件至当前目录或指定目录
e命令可用参数：
  -ai (Include archives)
  -an (Disable parsing of archive_name)
  -ao (Overwrite mode)
  -ax (Exclude archives)
  -i (Include)
  -o (Set Output Directory)
  -p (Set Password)
  -r (Recurse)
  -so (use StdOut)
  -x (Exclude)
  -y (Assume Yes on all queries) 
l： Lists contents of archive.
t： Test 
u： Update 
x： eXtract with full paths用文件的完整路径解压至当前目录或指定目录
x命令可用参数：
  -ai (Include archives)
  -an (Disable parsing of archive_name)
  -ao (Overwrite mode)
  -ax (Exclude archives)
  -i (Include)
  -o (Set Output Directory)
  -p (Set Password)
  -r (Recurse)
  -so (use StdOut)
  -x (Exclude)
  -y (Assume Yes on all queries)



### 将批处理转化为可执行文件：
由于批处理文件是一种文本文件，任何人都可以对其进行随便编辑，不小心就会把里面的命令破坏掉，所以如果将其转换成.com格式的可执行文件，不仅执行效率会大大提高，而且不会破坏原来的功能，更能将优先级提到最高。Bat2Com就可以完成这个转换工作。
小知识：在DOS环境下，可执行文件的优先级由高到低依次为.com>.exe>.bat>.cmd，即如果在同一目录下存在文件名相同的这四类文件，当只键入文件名时，DOS执行的是name.com，如果需要执行其他三个文件，则必须指定文件的全名，如name.bat。
这是一个只有5.43K大小的免费绿色工具，可以运行在纯DOS或DOS窗口的命令行中，用法：Bat2Com
FileName，这样就会在同一目录下生成一个名为FileNme.com的可执行文件，执行的效果和原来的.bat文件一样。

