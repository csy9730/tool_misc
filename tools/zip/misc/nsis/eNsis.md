# nsis

NSIS(Nullsoft Scriptable Install System) 

下面来说明一下代码。

首先，在NSIS中，以;和#开头的，为注释，相当于//和/**/。

第二，NSIS支持宏定义。

第三，每一个脚本中必须包含一个Section和SectionEnd。Section表示开始起点，SectionEnd表示过程运行结束。

第四，每一个脚本中必须包含一个OutFile。OutFile用于输出打包好的安装程序。

第五，要把所有需要打包的文件放到一个目录里面

## FAQ

### 引入压缩文件
``` nsi
installDir "D:\Program Files\example" ;指定安装目录
Page directory ;添加目录选择页
Page instfiles ;添加安装状态页 
Section "unzip" ;过程"unzip"开始
    writeUninstaller $INSTDIR/uninstaller.exe ;生成卸载程序
    SetOutPath "$INSTDIR\"
        File data.7z
        File "tools\*.exe"
        File "tools\*.dll"
    nsexec::exec "7z.exe"
    nsExec::Exec '"7z.exe" x "data.7z" -o"$INSTDIR"'
    Delete "7z.exe"
    Delete "7z.dll"
    Delete "data.7z"
SectionEnd ;过程"unzip"结束

OutFile setupExample.exe
section "Uninstall" ;过程"Uninstall"开始
rmDir /r "$INSTDIR" ;删除安装目录
sectionEnd ;过程"Uninstall"结束
```

### nsis 如何打包超大文件
由于 旧版系统限制，nsis无法打包超过2GB的文件。

会报以下错误（在Windows 10.0.17763）：

```

D:\Projects\deploy>makensis Foo.nsi
Processing config: D:\Program Files (x86)\NSIS\nsisconf.nsh
Processing script file: "Foo.nsi" (ACP)

Internal compiler error #12345: error mmapping datablock to 26143526.

Note: you may have one or two (large) stale temporary file(s) left in your temporary directory (Generally this only happens on Windows 9x).
```


论坛说把大文件拆分成小文件，可以避开限制。并且还要设置lzma压缩方式。

```

D:\Projects\deploy>makensis Foo.nsi
Processing config: D:\Program Files (x86)\NSIS\nsisconf.nsh
Processing script file: "Foo.nsi" (ACP)

Processed 1 file, writing output (x86-ansi):
warning 7998: ANSI targets are deprecated

Output: "D:\Projects\deploy\Setup_pure.exe"
Install: 7 pages (448 bytes), 6 sections (2 required) (12432 bytes), 1533 instructions (42924 bytes), 926 strings (44419
 bytes), 2 language tables (740 bytes).
Uninstall: 1 page (128 bytes), 1 section (2072 bytes), 223 instructions (6244 bytes), 267 strings (5383 bytes), 2 langua
ge tables (460 bytes).
Datablock optimizer saved 1817 bytes (~0.0%).

Using lzma compression.

EXE header size:              149504 / 37376 bytes
Install code:                  21915 / 95283 bytes
Install data:             2146199924 / 2213293649 bytes
Uninstall code+data:           13746 / 19291 bytes
CRC (0x5F0ECD45):                  4 / 4 bytes

Total size:               2146385093 / 2213445603 bytes (96.9%)

1 warning:
  7998: ANSI targets are deprecated
```


可以使用[nsisbi](https://sourceforge.net/projects/nsisbi/) 绕过限制。
> NSISBI aims to remove the current 2GB limit found in NSIS.


```

D:\Projects\deploy>makensis Foo.nsi
Processing config: E:\greensoftware\misc\nsisbi\nsisconf.nsh
Processing script file: "Foo.nsi" (ACP)

Processed 1 file, writing output (x86-unicode):

Output: "D:\Projects\deploy\Setup_pure.exe"
Install: 7 pages (448 bytes), 6 sections (2 required) (12432 bytes), 1538 instructions (55368 bytes), 4771 strings (86976 bytes), 2 language tables (740 bytes).
Uninstall: 1 page (128 bytes), 1 section (2072 bytes), 223 instructions (8028 bytes), 1347 strings (9812 bytes), 2 language tables (460 bytes).
Datablock optimizer saved 1854 bytes (~0.0%).

Using zlib compression.

EXE header size:              153088 / 40960 bytes
Install code:                  34307 / 156436 bytes
Install data:             2156071358 / 2213297805 bytes
Uninstall code+data:           15934 / 20241 bytes
CRC (0x7BF9C460):                  4 / 4 bytes

Total size:         2156274695 bytes / 2213515450 bytes (97.4%)
```

可以看到打包成功


			
				
nsis检测x64-or-x86问题, 根据检测结果分支执行？

...



强制指定压缩算法(Force compressor)：       				

`makensis.exe /X"SetCompressor /FINAL lzma" myscript.nsi`

## misc

```
RequestExecutionLevel user        ;普通用户权限
```


## 
http://forums.winamp.com/forumdisplay.php?f=65

https://nsis-dev.github.io/NSIS-Forums/html/t-329895.html

https://nsis.sourceforge.io/Docs/
