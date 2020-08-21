
# misc


使用nssm(稳定版本)工具将.EXE文件注册为Windows服务
winsw 下载地址: https://github.com/kohsuke/winsw/releases
安装denyhosts 攻击预防
Cloudreve
seafile
haiwen/seafile
filebrowser
APScheduler

Bad owner or permissions on C:\\Users
wmic ENVIRONMENT where "name='path'" get UserName,VariableValue |grep fpr
sudo wmic ENVIRONMENT where "name='path' and username='<system>'" set VariableValue="%path%;e:\fpr"



# server



###  


x32dbg

C:\Program Files (x86)\SogouInput\9.3.0.3129\SogouCloud.exe


代码静态分析
代码动态分析

不擅长集成，更擅长分解分析。

debug: featherTextpath.py 
小步重构还是大步重构？



## python

DEBUG
INFO
WARNING

debug:tmp_rotate_file
info:  console
error: error_log

sklearn grid_search
reuters数据集 预处理

raise RuntimeError(Exception):


python sys.stdout 二进制打印 存在延迟缓存慢等现象
C:\ProgramData\Anaconda3\Lib\site-packages\keras\datasets


``` python
import selenium 
from selenium import webdriver 
from fake_useragent import UserAgent
ua = UserAgent() 
option = webdriver.ChromeOptions() 
option.add_argument('--headless') 
option.add_argument("window-size=1024,768") 
option.add_argument('--start-maximized') 
option.add_argument('user-agent="%s"'%ua.random) 
browser = webdriver.Chrome(executable_path=r'C:\selenium\chromedriver.exe',chrome_options=option)
browser.get('https://www.baidu.com') 
browser.save_screenshot(r'D:\websoft88.com.png')
```


RuntimeError: cuDNN error: CUDNN_STATUS_INTERNAL_ERROR\r\n"
 destroyedTraining
 
 
import 导入同级目录模块
导入 下级目录模块
导入上级目录模块
导入兄弟目录模块

travis.yaml
coverage.py是一个用来统计python程序代码覆盖率的工具。它使用起来非常简单，并且支持最终生成界面友好的html报告。在最新版本中，还提供了分支覆盖的功能。

.tar.bz2

pywin32-221-py36h9c10281_0.tar.bz2
pywin32-221-py36h9c10281_0/DLLs
pywin32-221-py36h9c10281_0/info
pywin32-221-py36h9c10281_0/Library


# import tqdm

def texts_gen(file_list,maxlen = 500):
    pbar = (file_list)
    for file in pbar:
        # pbar.set_description("Processing %s" % file)
        print(pbar)
        with open(file,'r',encoding='utf-8') as f:
            while True:
                text = (f.readline().rstrip('\n').split('\t')[-1])
                if not text:
                    break
                if len(text) > maxlen:
                    text = text[0:maxlen]
                yield text

## c++


ss： qVariant 难以编辑
ss: qt slot为虚函数会重复触发么？
qheaderview 重构
ss: jinja2 / vue v-if 模板 引擎



如何查看vscode的 cmd 长输出 历史



cd doodle\cheers2019 ;
docker build -t csy9730/cheers2019 .
u盘写保护怎么去掉 无法格式化

## misc



design： source/download/install/quick-link







输出到屏幕（stdout/stderr）
支持中文
基于level输出到不同文件
基于日期输出到不同文件
自动删除过时日志文件
支持格式拼接，level+datetime+file+line+function+message
过滤/排序/搜索 查看日志


vscode
nodejs
qtcreator
msvc2015

hook 命名：

on_batch_start/on_batch_end
beforeBatch/afterBatch
batching/batched


 
 2019/03/29
传感器调研 2019/05/31
雨量传感器 数据分析

烟雾传感器串口演示demo界面。

使用PyQt + Qml框架
5/31 启用 pythonQt
6/20 添加设计界面 






mbedcrypto.lib(entropy_poll.obj):-1: error: LNK2019: 无法解析的外部符号
 __imp__CryptReleaseContext@8，该符号在函数 _mbedtls_platform_entropy_poll 中被引用



## sss
错误代码：
* 未设置路径
* 路径无效？
* 路径读取错误
* 进程调用失败
* 脚本调用失败






D:/projects/works/zalAiAll/lib/py/sensorBp3/数据集/手势
D:/projects/works/zalAiAll/lib/py/sensorBp3/models/fgr/fgr2.bin

D:\projects\githubs\PainterEngine-master\PainterEngine-master\PainterEngine



	
复制了anaconda.python  de 路径
考虑设置变量再执行

pfn = 'C:/ProgramData/Anaconda3/lib/site-packages'

Fatal Python error: Py_Initialize: unable to load the file system codec
python.dll 不匹配

ss="python D:\\projects\\my_lib\\py_misc_project\\base\\eThread\\eThread.py"
os.system(ss)


## work_record
https://www.sciencedirect.com/science/article/abs/pii/S0026269218308449
http://socialledge.com/sjsu/index.php/S15:_Hand_Gesture_Recognition_using_IR_Sensors
infrared gesture recognition

https://www.h2o.ai/products/h2o-driverless-ai/
用户名：sg_abc@163.com
密码：tHsXmEJN3D0KHoiZ


dell 显示屏  切换  vga hdmi 

C:\Program Files (x86)\360\Total Security


#### vsftpd
publicReader 555
publicWriter 
publicManager
privateManager

目录结构如何设置？用户是否共享一个根目录？


  
  777 > 755> 744>700
  
ftp/ftppub/
	/ftppub/pub  777
	/ftppub/
	/private

ftp(admin 750)	
ftp/private (admin 700)
ftp/user (user 755)
ftp/user/public( admin 755)
ftp/user/private  (user 700)
ftp/user/tmp( user 777)

，Linux系统中，预设的情況下，系统中所有的帐号与一般身份使用者，以及root的相关信 息， 都是记录在`/etc/passwd`文件中。每个人的密码则是记录在`/etc/shadow`文件下。 此外，所有的组群名称记录在`/etc/group`內！

linux文件的用户权限的分析图

![linux文件的用户权限的分析图](https://cdn.shortpixel.ai/client/q_glossy,ret_img,w_583,h_214/http://man.linuxde.net/wp-content/uploads/2013/11/chmod.gif)


### tmp

ERR_NAME_NOT_RESOLVED错误的解决
最后得出的解决方案是取消或者重新打开Chrome高级配置里面的“预提取资源，以便更快速的加载网页”选项。

闪退 vs emulator
 
 https://www.wandoujia.com/apps/280001/history_v16861
 
 

 

QUiLoader 

https://github.com/skywind3000/ECDICT

分别是“WpsNotifyTask_Administrator”和“WpsUpdateTask_Administrator”。

通过监视任务计划实现



https://leetcode-cn.com/problems/super-egg-drop/




各位大大，救救小弟。这几天被这个算法折磨疯了。要求是要把一些不一样大小的矩形，排列在一个宽度一定，高度无限的矩形里，使得所用的高度最小。大小不一的矩形在排版时可用横排或者竖排。

https://github.com/Shellbye/Shellbye.github.io/issues/42

https://en.wikipedia.org/wiki/Fractional_cascading

H:\githubs\desktop-development\docs\technical\adding-tests.md

##
## 记录安装日志
# 安装jieba


开机时出现：系统无法让您登录，请确定您的用户名及域无误的解决办法
如果是XP的机器.
1：运行->输入“control userpasswords2”->选上“要使用本机，用户必须输入用户名和密码”
2：运行-输入regedit
展开到[HKEY_LOCAL_MACHINE\\
SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon ]
删除AutoAdminLogon项“开始”菜单－－“运行”，输入“rundll32.exe netplwiz.dll,UsersRunDll ”，点确定
(注意大小写,按照上面的严格输入,或者复制过去)
然后就弹出了“高级用户配置”的窗口 ，把“用户必须输入用户名和密码的勾”去掉（没有勾，点上勾再取消），点应用
然后输入正确的用户名和密码，点确定
最后，重启电脑就可以了。
开机时显示“系统无法让您登陆，请确定您的用户名及域名无误，然后再输入密码，密码的字母必须使用正确的大小写”这是怎么回事（但点击确定后输入密码一样能进入系统正常运作）??
注：我电脑设了开机密码的,但把密码取消掉后上面那个提示又没了能正常开机,一设密码又有那个提示。 
解决办法：
如果是Win XP系统和Windows server 2003系统的机器，请用以下方法之一：
方法1：运行-->输入“control userpasswords2”->选上“要使用本机，用户必须输入用户名和密码”
方法2：运行-->输入“regedit”
展开到[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon ]
删除“AutoAdminLogon”项，或者这项的值改为“0”也是可以的。
如果你是登陆不了系统，请你在你的登陆窗口的用户名的位置输入“Administration”密码为空，然后直接回车就看到电脑桌面了 ！！ “Administration”其中“A”是大写的！！
然后回到上边的步骤进行操作！



1、先确认两台电脑联网要能拼通，若不通，请关不windows防火墙（在控制面板中的windows防火墙关闭）和杀毒软件及杀毒软件的防火墙。
2、将远程连接开启，win7下右击我的电脑选择属性，属性窗口zhidao选择左边的远程设置，远程协议勾选，远程桌面回选择允许任意版本远程桌面的计算机连接。若想两边都可以远程，两台机器都要开启。
3、在开始菜单栏选择运行，输入mstsc、mstsc -admin、mstsc /console均可，后两个为主用户登录。弹出连接框，输入IP地址【要连接机器答的IP】、点击连接、【第一次会输入用户名、密码、这里的用户名、密码是被连接机器的用户名、密码】、确认、完成，可以远程操控机器了。




## 1

SSH Channel:open failed:connect failed:Connection timed out

在Hyper-V的虚拟机里面运行Linux网络性能果真要比KVM差一些，当然此间原因很多：驱动、NAT转换效率等等。这次Kaijia遇到的大量“open failed: connect failed: Connection timed out”问题，最后看来也是连接性能原因。

我用SSH转Socket连接到不同地区的IP，然后进行检测和数据采集，同时所有连接同时有流量传输，一开始一切正常，但是Socket运行时间久后就会慢慢出现“open failed: connect failed: Connection timed out”错误提示。


于是开启调试模式分析了一下错误信息，看到了很多类似以下的信息：

debugx: channel x: open confirm rwindow ?? rmax ??
channel x: open failed: connect failed: Connection timed out
debugx: channel x: free: direct-tcpip: listening port xxxxx for xxx.xxx.xxx.xxx port 80, connect from 172.16.1.xxx port xxxxx to 172.16.1.xxx port xxxxx, nchannels x
debugx: channel x: zombie
debugx: channel x: garbage collecting
debugx: channel x: read failed
debugx: channel x: close_read
debugx: channel x: input open -> drain
debugx: channel x: ibuf empty
debugx: channel x: send eof
debugx: channel x: input drain -> closed


结合错误提示，网上搜了一些，很好理解即连接在允许的时间内没有收到任何信息，于是发送了EOF结束，返回了连接超时错误，因此可以说是连接的性能问题。根本上解决问题是比较困难的，涉及到很多方面因素，比较现实的解决方法便是延长等待时间，避免连接超时（Timeout）以增加收到数据包的概率。

需要延长等待时间需要在两个方面进行调整，首先是链接Socket的程序（这里就不说了），其次是SSH Socket本身。延长SSH客户端等待时间的方式有很多，测了一下以下两个参数组合后效果比较好：


1.ConnectTimeout，文档解释为“Specifies the timeout (in seconds) used when connecting to the SSH server, instead of using the default system TCP timeout. This value is used only when the target is down or really unreachable, not when it refuses the connection.”（连接到SSH服务器时，设置一个以秒为单位的超时时间以代替系统默认的TCP超时。此值仅在目标无法连接时生效，在目标拒绝连接时无效）。此参数即设定在长时间未收到请求的数据情况下超时。

2.ServerAliveInterval，文档解释为“Sets a timeout interval in seconds after which if no data has been received from the server, ssh(1) will send a message through the encrypted channel to request a response from the server. The default is 0, indicating that these messages will not be sent to the server, or 300 if the BatchMode option is set.”（设置一个以秒为单位的超时时间，如果客户端未在此时间内收到服务器数据的话，ssh将会通过加密通道发送一包信息以请求服务器响应。默认值为0，表示不会发送此类信息，在BatchMode启用的情况下为300）。此参数即在长时间无数据的情况主动发送一包避免连接被断开。


两者结合使用，可以直接写入/etc/ssh/ssh_config文件中，也可以使用-o参数加入到命令行中，即：

ssh -oConnectTimeout=60 -oServerAliveInterval=120 ...


上例设置在请求发起60秒钟后未收到响应则超时，120秒内无数据通过则发送一个请求避免断开，这样设置之后此类错误提示就会有大幅减少。

# misc

 barad_agent进程是干啥用的？
 监控agent有2个进程，只有两个进程正常安装才上报数据。
stargate进程负责监控barad_agent进程，barad_agent负责采集和上报。

```
Set ws = CreateObject("Wscript.Shell")   
ws.run "cmd /c 批处理的完整路径",vbhide

“%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\frps.vbs”
ws.Run "d:\frpc.exe -c d:\frpc_net.ini",0

echo "ws.Run '%~dp0\frpc.exe' -c  '%~dp0\frpc2.ini' ,0"

echo "wer"
echo wer ert^,
echo we^"r ert^, 4545 678
echo "wer""ert^,""4545 678"

echo ^"^"这是一个 参数^"^"

set ws=WScript.CreateObject('WScript.Shell')
ws.Run 'H:\greensoftware\misc\frp_0.32.0_windows_amd64\frpc.exe' -c  'H:\greensoftware\misc\frp_0.32.0_windows_amd64\frpc2.ini' ,0 
```
命令行  转义 双引号



系统启动时间:     2020/3/27, 20:39:57


qt 5.11 :-1: error: Unknown module(s) in QT: webenginewidgets
scons 

由于 win10 的 linux 子系统无法原生支持使用图形界面，


https://github.com/mygit03/DoJS
https://github.com/lgxZJ/Miscellaneous/tree/master/Qt/QtScript
https://www.cnblogs.com/lgxZJ/archive/2017/12/31/8158132.html


如何 可以在虚拟机 无权限打包使用 


该编码方式和一般采用的 application/x-www-form-urlencoded MIME 
base64,utf-8 
& = 

https://help.aliyun.com/document_detail/67818.html?spm=a2c4g.11186623.2.11.47a179bbtNStMh


手机文件同步，权限管理：DCIM，tencent/download/，生成snap，计算更新量。


自动化就是如此的简单。不需要Ansiable、也不需要Salt stack，一个MobaXterm足够了。
Window下有很多强大的工具，比如office，按键精灵等，可以支持强大的宏功能，把一些需要重复性的操作，录制为脚本，以后就可以重复执行了，减轻手的负担。

一个节点对应一个简单分类器/拟合器（线性分类器/区间方波/relu），如何判断 一个SISO无状态的数据拟合，需要多少个节点，在区间内需要多少密度的数据点？
ctrl+b PageUp/PageDown





任务管理器在详情页展示列表的标题栏上右键，选择“选择列”，在弹出的列表中勾选“平台”，即可展示软件位数

整个软件集成脚本、模型、数据、python环境和二进制文件，打包过于巨大，发布和部署存在体积过大的问题



DOS的时间基准是1980年1月1日，
Unix的时间基准是1970年1月1日上午12 点，
Linux的时间基准是1970年1月1日凌晨0点。
Windows的时间基准是1601年1月1日。

Chrome的时间基准是1601年1月1日。
``` python
	datetime.datetime(1601, 1, 1) + datetime.timedelta(microseconds=13220383158057917)
```

``` bash
# 环境部署太难了，尤其是现在网络不好，最好集成环境，但集成环境太大了。
conda config --add channels https://repo.continuum.io/pkgs/free/win-64/
conda config --add channels https://repo.continuum.io/pkgs/main/win-64/
```

``` c++
	QFileInfo fi(st);                  
	if (!fi.isFile()) {
        qWarning() << st<<" not found";
		return -1;
	}
```
qt 绑定 objectName
``` c++
QLabel *macLabel = new QLabel(this);
macLabel->setObjectName("mac");
 
//查找这个控件的时候
QLabel *macLabel = yourWidget->findChild<QLabel*>("mac");
qDebug() << macLabel->text();
```
总结：ObjectName主要是用于外界来访问内部的控件成员的，如果外界不需要访问这个成员，则理论上无需设置它的ObjectName。


数组 
字典
分隔符
``` ini
lst=3,4,5,6
lst=[3,4,5,"6"]

lst_1 =3
lst_2 =4
lst_3 =5
lst_4 =6

sensor.fit
sensor_fit
sensor:fit

[modules]
key_1=sensor_classify
key_1=sensor_fit
key_1=sensor_fit
key_1=sensor_fi
```
相对路径没用对，注意INCLUDEPATH  和 LIBS后接的相对路径是不一样的。
include后接的相对路径./代表是源代码文件目录
libs 后接的相对路径./代表的是执行文件exe所在目录
可以用这个$$PWD当前目录，这样不会混淆。

手机权限 管理 流氓
appops破解版

ss: G 大文件 传输方法

手机 清除  通讯录 安卓 
**Q**: 20200301 百度网盘（PC版）锁定后打不开
**A**: 重新下载百度网盘，设置中关闭自动锁定

c:\windows\System32\drivers\etc\hosts

Windows下caffe安装详解

https://github.com/BVLC/caffe

https://www.cnblogs.com/hhh5460/p/6681363.html



## C++程序分类
您在开发C++程序呀？

哪个系统啊？Win、Linux……

谁家编译器啊？VC、GCC、MinGW、clang++……

啥语言版本啊？98、03、11、14、17、20……

目标平台呢？x86、x64、arm64、cross……

目标文件咧？exe、lib、dll、c、asm……

开优化/分析不？Debug、Release、O123、-g、-pg……

函数调用方式？cdecl、stdcall、fastcall……

数据存储方式？auto、static、const、constexpr、extern、mutable、volatile、register、thread_local……

要线程不？ML/MT/MD……

异常模型用的啥？SJLJ、SEH、DW2……

字符集涅？MBCS、Unicode……

char带符号不？

wchar_t是2字节还是4字节？

用了模板？传说有module、export、import呢

客户还要兼容XP啊？v141_xp + WinSDK7考虑一下……

困难？还行吧，小时候指针还分near、far、huge呢
