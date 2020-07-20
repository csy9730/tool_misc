# demo

## 内涵图

可以实现内涵图：把图片和压缩文件保存在一起
``` batch
copy "src.jpg"+"src2.zip" "dst.jpg"
rem xcopy "src" "dst" /i /s
```


## 改变编码方式
1、打开CMD.exe 命令行窗口
2、通过chcp 命令改变代码页，UTF-8 的代码页为65001，`chcp 65001` 执行该操作后，代码页就被变成UTF-8 了。但是，在窗口中仍旧不能正确显示UTF-8 字符。
3、修改窗口属性，改变字体在命令行标题栏上点击右键，选择”属性”->”字体”，将字体修改为True Type字体”Lucida Console”，然后点击确定将属性应用到当前窗口。
``` batch
rem 就是换成UTF-8 代码页
chcp 65001 

rem 可以换回默认的GBK
chcp 936 

rem 美国英语
chcp 437 
```

注意事项：
1.无法通过建立快捷方式的方法来快速切换到这种窗口模式（无法修改codepage 为65001，Lucida Console 字体只有在code page 设为65001 后才能选择）！
2.这种状态下的控制台调用不了.bat 脚本！


## 一键修改IP
Win7+xp 命令行一键修改IP、DNS
第一步：新建一个txt 文件
第二步：在文件中添加如下内容：
``` batch
netsh interface ip set address name="本地连接" source=static addr=10.60.37.99 mask=255.255.255.0gateway=10.60.37.254
netsh interface ip set dns "本地连接" source=static addr=202.120.190.208
```

4 个红色的部分需要我们根据需要修改：
10.60.37.99 是IP 地址
255.255.255.0 是掩码地址
10.60.37.254 是默认网关
202.120.190.208 是DNS
第三步：将txt 文件的后缀由.txt 改为.cmd
第四步：右键点击.cmd 文件，选择“以管理员身份运行”

如果想改回DHCP(自动获取IP 和DNS)，
只需创建一个新的cmd 文件，内容为：
``` batch
netsh interface ip set address name="本地连接" source=dhcp
netsh interface ip set dns name="本地连接" source=dhcp
```
XP 中的指令稍有不同：
``` batch
netsh interface ip set address name="本地连接" source=static addr=10.60.37.96 mask=255.255.255.0
netsh interface ip set address name="本地连接" gateway=10.60.37.254 gwmetric=0
netsh interface ip set dns "本地连接" source=static addr=202.120.190.208
``` 

## 一键开启wifi
电脑开启wifi：服务开启，cmd 口令，
``` batch
netsh wlan set hostednetwork mode=allow ssid=ABC-PC key=12333333
pause
netsh wlan start hostednetwork
pause
netsh wlan stop hostednetwork
```


## 一键备份
``` batch
CLS
@echo off
title auto bak directory
set src="abc3"
set dsc="bak2\"
echo "source directory= %src% ,destination directory = %dsc% "
if not exist %dsc% (mkdir %dsc%)
if not exist "%dsc%bakCount.txt" ( echo 0 >"%dsc%bakCount.txt" )
set /p var=< "%dsc%bakCount.txt"
set /a var=var+1
echo %var%
echo d |(xcopy "%src%" "%dsc%%src%" /s)
ren "%dsc%%src%" "%src%_%var%"
rem xcopy %src% "%dsc%%src%%var%"
echo %var% >"%dsc%bakCount.txt"
echo "%var%:%date%%time%">>"%dsc%bakDate.txt"
pause
exit
```
## 批量文件编辑
SOP：批量复制指定目录下得jpg 后缀文件。
在命令提示符（cmd）中输入：
``` batch
for /f %i in ('dir "d:\pcdesktop\*.jpg" /s /b') do copy "%i" "f:\hello"
rem 我这里的指定文件夹为"f:\hello"，一定要确保指定文件夹是存在的
```
如果在.bat 脚本中输入，会有如下改变：
``` batch
for /f %%i in ('dir "d:\pcdesktop\*.jpg" /s /b') do copy "%%i" "f:\hello"
for /f "tokens=*"%i in ('dir "d:\pcdesktop\*.jpg" /s /b') do copy "%i" "f:\hello"
```

* Tips： for 脚本用使用%%i，命令行使用%i 。
* 路径名文件名有空格时会出错，使用“”包括。
  
``` batch
cd "F:\Jmgo\Books\Foreign\且听风吟"
dir
rem 批量添加前缀名，批量添加后缀名
for /f %%i in ('dir /b *.txt') do (ren %%i 且听风吟_%%i)
pause
cmd
rem 批量复制到指定路径
@echo off
cd /d e:\
for /f "tokens=*" %%d in ('dir /ad /s /b ^| findstr /i "input"') do (
xcopy "%%d" C:\Temp\data /s /i /y /h)
```