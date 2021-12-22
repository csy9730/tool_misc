


### 用7-ZIP实现命令行压缩和解压功能
语法格式：（详细情况见7-zip帮助文件，看得头晕可以跳过，用到再学）
7z <command> [<switch>...] <base_archive_name> [<arguments>...]
7z.exe的每个命令都有不同的参数<switch>,请看帮助文件
<base_archive_name>为压缩包名称
<arguments>为文件名称，支持通配符或文件列表
其中，7z是至命令行压缩解压程序7z.exe，<command>是7z.exe包含的命令，列举如下：
```
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
```




