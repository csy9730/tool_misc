# customize eclipse

## arch

- eclipse/ 核心IDE程序
- GNU Tools ARM Embedded/ 编译器和附属工具
- Java/      IDE的运行环境
- msys/      msys环境，提供windows可用的linux常用工具
- Packages/.repos.xml
- workspace/   项目目录路径
- startup_eclipse_neon.bat


## startup_eclipse_neon.bat

startup_eclipse_neon.bat

``` bat
@echo on
echo Startup Eclipse...
@echo off

set BAT_DIR=%~dp0
echo %BAT_DIR%

set SOFT_ROOT_DIR=%BAT_DIR%

set path=%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\;
set path=%SOFT_ROOT_DIR%\Java\jre1.8.0_102\bin;%path%
set path=%SOFT_ROOT_DIR%\GNU Tools ARM Embedded\4.8 2014q1\bin;%path%
set path=%SOFT_ROOT_DIR%\msys\1.0\bin;%path%

start "" "%SOFT_ROOT_DIR%\eclipse\eclipse.exe"
```

重置环境变量，添加指定路径到环境变量。


### 打开项目

1. 拷贝安装eclipse，jre和AWORKS库文件
2. 打开eclipse软件，右键project Explorer，选择import选项。
3. 到达项目路径，搜索导入项目文件，后缀名为cproject

