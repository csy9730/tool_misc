2、用wimic 后面直接跟命令运行，如wmic process 就显示了所有的进程了。这两种运行方法就是：交互模式(Interactive mode)和非交互模式(Non-Interactive mode)

下面我们能过一些实例来说明用法：
=====================================================================
显示进程的详细信息
输入 process where name="maxthon.exe" list full
将显示出mxathon.exe进程所有的信息如下：
CommandLine="D:\mytools\Maxthon2\Maxthon.exe"
CSName=CHINA-46B1E8590
Description=Maxthon.exe
ExecutablePath=D:\mytools\Maxthon2\Maxthon.exe
ExecutionState=
Handle=684
HandleCount=2296
InstallDate=
KernelModeTime=3495000000
MaximumWorkingSetSize=1413120
MinimumWorkingSetSize=204800
Name=Maxthon.exe
OSName=Microsoft Windows XP Professional|C:\WINDOWS|
OtherOperationCount=307814
OtherTransferCount=60877207
PageFaults=1367971
PageFileUsage=89849856
ParentProcessId=1924
PeakPageFileUsage=90091520
PeakVirtualSize=385802240
PeakWorkingSetSize=94031872
Priority=8
PrivatePageCount=89849856
ProcessId=684
QuotaNonPagedPoolUsage=43496
QuotaPagedPoolUsage=257628
QuotaPeakNonPagedPoolUsage=72836
QuotaPeakPagedPoolUsage=271372
ReadOperationCount=85656
ReadTransferCount=121015982
SessionId=0
Status=
TerminationDate=
ThreadCount=57
UserModeTime=1778750000
VirtualSize=353206272
WindowsVersion=5.1.2600
WorkingSetSize=93716480
WriteOperationCount=30940
WriteTransferCount=24169673
******************************************************************************
停止、暂停和运行服务功能
启动服务startservice,
停止服务stopservice,
暂停服务pauseservice
Service where caption="windows time" call stopservice ------停止服务
Service where caption="windows time" call startservice ------启动服务
Service where name="w32time" call stopservice          ------停止服务,注意name和caption的区别。
caption 显示服务名name服务名称，如： telnet服务的显示名称是telnet 服务名称是tlntsvr，还有Windows Time服务的名称是w32time 显示名称是"Windows Time"要用引号引起来，主要是有一个空格。
好了具体看一下：输入Service where caption="windows time" call startservice后有一个确认输入y就可以了，返回ReturnValue = 0;表示成功
wmic:root\cli>Service where caption="windows time" call startservice
执行 (\\CHINA-46B1E8590\ROOT\CIMV2:Win32_Service.Name="W32Time")->startservice()
方法执行成功。
输出参数:
instance of __PARAMETERS
{
        ReturnValue = 0;
};

wmic:root\cli>
================================================================================================
显示出BIOS信息 wmic bios list full
大家可能注意到了上面命令行中还有两个参数list和full。list决定显示的信息格式与范围，它有Brief、Full、Instance、 Status、System、Writeable等多个参数，full只是它的一个参数，也是list的缺省参数，表示显示所有的信息。其他几个参数顾名思义，如Brief表示只显示摘要信息，Instance表示只显示对象实例，Status表示显示对象状态，Writeable表示只显示该对象的可写入的属性信息等。

************************************************************************=====================
停止进程的操作
例如，执行下面的命令将关闭正在运行的QQ.exe：
例1、wmic process where name='QQ.exe' call terminate
命令运行结束后，WMIC命令行提示出如下结果：
C:\>wmic process where name='QQ.exe' call terminate
执行 (\\CHINA-46B1E8590\ROOT\CIMV2:Win32_Process.Handle="728")->terminate()
方法执行成功。
输出参数:
instance of __PARAMETERS
{
        ReturnValue = 0;
};

例2、wmic process where name="qq.exe" delete
命令运行结束后，WMIC命令行提示出如下结果：

C:\>wmic process where name="qq.exe" delete
删除范例 \\CHINA-46B1E8590\ROOT\CIMV2:Win32_Process.Handle="2820"
范例删除成功。
======================================================================
列出所有的进程   wmic process
==================================================================

连接远程电脑

★★连接远程的电脑，不过好象对要开一些相应的服务

wmic /node:"192.168.203.131" /password:"" /user:"administrator"

BIOS - 基本输入/输出服务 (BIOS) 管理
★★查看bios版本型号
wmic bios get Manufacturer,Name

WMIC设置IP地址
★★配置或更新IP地址：
wmic nicconfig where index=0 call enablestatic("192.168.1.5"), ("255.255.255.0") ；index=0说明是配置网络接口1。
配置网关（默认路由）：
wmic nicconfig where index=0 call setgateways("192.168.1.1"),(1)

COMPUTERSYSTEM - 计算机系统管理
★★查看系统启动选项,boot的内容
wmic COMPUTERSYSTEM get SystemStartupOptions
★★查看工作组/域
wmic computersystem get domain
★★更改计算机名abc为123
wmic computersystem where "name='abc'" call rename 123
★★更改工作组google为MyGroup
wmic computersystem where "name='google'" call joindomainorworkgroup "","","MyGroup",1

CPU - CPU 管理
★★查看cpu型号
wmic cpu get name

DATAFILE - DataFile 管理
★★查找e盘下test目录(不包括子目录)下的cc.cmd文件
wmic datafile where "drive='e:' and path='\\test\\' and FileName='cc' and Extension='cmd'" list
★★查找e盘下所有目录和子目录下的cc.cmd文件,且文件大小大于1K
wmic datafile where "drive='e:' and FileName='cc' and Extension='cmd' and FileSize>'1000'" list
★★删除e盘下文件大小大于10M的.cmd文件
wmic datafile where "drive='e:' and Extension='cmd' and FileSize>'10000000'" call delete
★★删除e盘下test目录(不包括子目录)下的非.cmd文件
wmic datafile where "drive='e:' and Extension<>'cmd' and path='test'" call delete
★★复制e盘下test目录(不包括子目录)下的cc.cmd文件到e:\,并改名为aa.bat
wmic datafile where "drive='e:' and path='\\test\\' and FileName='cc' and Extension='cmd'" call copy "e:\aa.bat"
★★改名c:\hello.txt为c:\test.txt
wmic datafile "c:\\hello.txt" call rename c:\test.txt
★★查找h盘下目录含有test,文件名含有perl,后缀为txt的文件
wmic datafile where "drive='h:' and extension='txt' and path like '%\\test\\%' and filename like '%perl%'" get name

DESKTOPMONITOR - 监视器管理
★★获取屏幕分辨率
wmic DESKTOPMONITOR where Status='ok' get ScreenHeight,ScreenWidth

DISKDRIVE - 物理磁盘驱动器管理
★★获取物理磁盘型号大小等
wmic DISKDRIVE get Caption,size,InterfaceType

ENVIRONMENT - 系统环境设置管理
★★获取temp环境变量
wmic ENVIRONMENT where "name='temp'" get UserName,VariableValue
★★更改path环境变量值,新增e:\tools
wmic ENVIRONMENT where "name='path' and username='<system>'" set VariableValue="%path%;e:\tools"
★★新增系统环境变量home,值为%HOMEDRIVE%%HOMEPATH%
wmic ENVIRONMENT create name="home",username="<system>",VariableValue="%HOMEDRIVE%%HOMEPATH%"
★★删除home环境变量
wmic ENVIRONMENT where "name='home'" delete

FSDIR - 文件目录系统项目管理
★★查找e盘下名为test的目录
wmic FSDIR where "drive='e:' and filename='test'" list
★★删除e:\test目录下除过目录abc的所有目录
wmic FSDIR where "drive='e:' and path='\\test\\' and filename<>'abc'" call delete
★★删除c:\good文件夹
wmic fsdir "c:\\good" call delete
★★重命名c:\good文件夹为abb
wmic fsdir "c:\\good" rename "c:\abb"

LOGICALDISK - 本地储存设备管理
★★获取硬盘系统格式、总大小、可用空间等
wmic LOGICALDISK get name,Description,filesystem,size,freespace

NIC - 网络界面控制器 (NIC) 管理

OS - 已安装的操作系统管理
★★设置系统时间
wmic os where(primary=1) call setdatetime 20070731144642.555555+480

PAGEFILESET - 页面文件设置管理
★★更改当前页面文件初始大小和最大值
wmic PAGEFILESET set InitialSize="512",MaximumSize="512"
★★页面文件设置到d:\下,执行下面两条命令
wmic pagefileset create name='d:\pagefile.sys',initialsize=512,maximumsize=1024
wmic pagefileset where"name='c:\\pagefile.sys'" delete

PROCESS - 进程管理
★★列出进程的核心信息,类似任务管理器
wmic process list brief
★★结束svchost.exe进程,路径为非C:\WINDOWS\system32\svchost.exe的
wmic process where "name='svchost.exe' and ExecutablePath<>'C:\\WINDOWS\\system32\\svchost.exe'" call Terminate
★★新建notepad进程
wmic process call create notepad

PRODUCT - 安装包任务管理
★★安装包在C:\WINDOWS\Installer目录下
★★卸载.msi安装包
wmic PRODUCT where "name='Microsoft .NET Framework 1.1' and Version='1.1.4322'" call Uninstall
★★修复.msi安装包
wmic PRODUCT where "name='Microsoft .NET Framework 1.1' and Version='1.1.4322'" call Reinstall

SERVICE - 服务程序管理
★★运行spooler服务
wmic SERVICE where name="Spooler" call startservice
★★停止spooler服务
wmic SERVICE where name="Spooler" call stopservice
★★暂停spooler服务
wmic SERVICE where name="Spooler" call PauseService
★★更改spooler服务启动类型[auto|Disabled|Manual] 释[自动|禁用|手动]
wmic SERVICE where name="Spooler" set StartMode="auto"
★★删除服务
wmic SERVICE where name="test123" call delete

SHARE - 共享资源管理
★★删除共享
wmic SHARE where name="e$" call delete
★★添加共享
WMIC SHARE CALL Create "","test","3","TestShareName","","c:\test",0

SOUNDDEV - 声音设备管理
wmic SOUNDDEV list

STARTUP - 用户登录到计算机系统时自动运行命令的管理
★★查看msconfig中的启动选项
wmic STARTUP list

SYSDRIVER - 基本服务的系统驱动程序管理
wmic SYSDRIVER list

USERACCOUNT - 用户帐户管理
★★更改用户administrator全名为admin
wmic USERACCOUNT where name="Administrator" set FullName="admin"
★★更改用户名admin为admin00
wmic useraccount where "name='admin" call Rename admin00


================================================获取补丁信息
★★查看当前系统打了哪些补丁
/node:legacyhost qfe get hotfixid

查看CPU当前的速度
★★cpu当前的速度
wmic cpu get CurrentClockSpeed

远程计算机的远程桌面连接
★★WMIC命令开启远程计算机的远程桌面连接
执行wmic /node:192.168.1.2 /USER:administrator
PATH win32_terminalservicesetting WHERE (__Class!="") CALL SetAllowTSConnections 1
具体格式：
wmic /node:"[full machine name]" /USER:"[domain]\[username]"
PATH win32_terminalservicesetting WHERE (__Class!="") CALL SetAllowTSConnections 1
wmic 获取进程名称以及可执行路径:
wmic process get name,executablepath

wmic 删除指定进程(根据进程名称):
wmic process where name="qq.exe" call terminate
或者用
wmic process where name="qq.exe" delete

wmic 删除指定进程(根据进程PID):
wmic process where pid="123" delete

wmic 创建新进程
wmic process call create "C:\Program Files\Tencent\QQ\QQ.exe"

在远程机器上创建新进程：
wmic /node:192.168.201.131 /user:administrator /password:123456 process call create cmd.exe

关闭本地计算机
wmic process call create shutdown.exe

重启远程计算机
wmic /node:192.168.1.10/user:administrator /password:123456 process call create "shutdown.exe -r -f -m"

更改计算机名称
wmic computersystem where "caption='%ComputerName%'" call rename newcomputername

更改帐户名
wmic USERACCOUNT where "name='%UserName%'" call rename newUserName

wmic 结束可疑进程（根据进程的启动路径）

wmic process where "name='explorer.exe' and executablepath<>'%SystemDrive%\\windows\\explorer.exe'" delete

wmic 获取物理内存
wmic memlogical get TotalPhysicalMemory|find /i /v "t"

wmic 获取文件的创建、访问、修改时间

@echo off
for /f "skip=1 tokens=1,3,5 delims=. " %%a in ('wmic datafile where name^="c:\\windows\\system32\\notepad.exe" get CreationDate^,LastAccessed^,LastModified') do (
set a=%%a
set b=%%b
set c=%%c
echo 文件: c:\windows\system32\notepad.exe
echo.
echo 创建时间: %a:~0,4% 年 %a:~4,2% 月 %a:~6,2% 日 %a:~8,2% 时 %a:~10,2% 分 %a:~12,2% 秒
echo 最后访问: %b:~0,4% 年 %b:~4,2% 月 %b:~6,2% 日 %b:~8,2% 时 %b:~10,2% 分 %b:~12,2% 秒
echo 最后修改: %c:~0,4% 年 %c:~4,2% 月 %c:~6,2% 日 %c:~8,2% 时 %c:~10,2% 分 %c:~12,2% 秒
)
echo.
pause

wmic 全盘搜索某文件并获取该文件所在目录
for /f "skip=1 tokens=1*" %i in ('wmic datafile where "FileName='qq' and extension='exe'" get drive^,path') do (set "qPath=%i%j"&@echo %qPath:~0,-3%)

获取屏幕分辨率 wmic DESKTOPMONITOR where Status='ok' get ScreenHeight,ScreenWidth

wmic PageFileSet set InitialSize="512",MaximumSize="512"

设置虚拟内存到E盘，并删除C盘下的页面文件,重启计算机后生效

wmic PageFileSet create name="E:\\pagefile.sys",InitialSize="1024",MaximumSize="1024"
wmic PageFileSet where "name='C:\\pagefile.sys'" delete

获得进程当前占用的内存和最大占用内存的大小：

wmic process where caption='filename.exe' get WorkingSetSize,PeakWorkingSetSize

以KB为单位显示

@echo off
for /f "skip=1 tokens=1-2 delims= " %%a in ('wmic process where caption^="conime.exe" get WorkingSetSize^,PeakWorkingSetSize') do (
set /a m=%%a/1024
set /a mm=%%b/1024
echo 进程conime.exe现在占用内存：%m%K；最高占用内存：%mm%K
)
pause

远程打开计算机远程桌面

wmic /node:%pcname% /USER:%pcaccount% PATH win32_terminalservicesetting WHERE (__Class!="") CALL SetAllowTSConnections 1

===========================================================================

批处理的api--WMIC学习体会
在这篇文章里也许你看不到很多奇特有用的的实际例程，但是呢，授人以鱼不如授人以渔，希望我的文章能让你通俗易懂的了解一些wmic的基本知识，可以有一个学习的兴趣，让自己继续深研一下wmic。
在WINDOWS\Help目下，wmic.chm文档是这样解释wmi的：Windows Management Instrumentation (WMI) 是“基于 Web 的企业管理倡议 (WBEM)”（这是一个旨在建立在企业网络上访问和共享管理信息的标准的工业倡议）的 Microsoft 的实现。有关 WBEM 的详细信息，请访问 WBEM。XOXWMI 为公用信息模型 (CIM)（该数据模型描述存在于管理环境中的对象）提供完整的支持。WMI 包括对象储备库和 CIM 对象管理器，其中对象储备库是包含对象定义的数据库，对象管理器负责处理储备库中对象的收集和操作并从 WMI 提供程序 (WMI provider) 收集信息。WMI 提供程序 (WMI provider) 在 WMI 和操作系统、应用程序以及其他系统的组件之间充当中介。例如，注册表提供程序从注册表中提供信息，而 SNMP 提供程序则从 SNMP 设备中提供数据和事件。提供程序提供关于其组件的信息，也可能提供一些方法，这些方法可以操作可设置的组件、属性，或者操作可能警告您在组件中要发生更改的事件。Windows Management Instrumentation 命令行 (WMIC) 向您提供了简单的 Windows Management Instrumentation (WMI) 命令行界面，这样即可利用 WMI 来管理运行 Windows 的计算机。WMIC 与现有命令行程序和实用程序命令相互操作，且很容易通过脚本或其他面向管理的应用程序来扩展 WMIC。
以上的这些说法太专业了，通俗一点讲就是wmic.exe是一个命令行程序，可以用它这个接口来实现在命令行下直接管理计算机软硬件等方方面面的操作，相当于批处理的api了。
一、wmic的基本命令格式简析
经常看网上的相关资料的话，读者可能会对wmic有一个基本的认识，不过看得越多估计会越糊涂，起码我是这样认为的。其实简单总结一下，命令格式就是 “wmic+全局开关+别名+wql语句+动词+副词（或者说是动词的参数）+动词开关”而已了。这个命令格式可以根据需要来写全或者写部份格式，我这里依次对格式的每个名称按自己的理解来解释一下，不过肯定完全不符合微软专家的定义，只是让大家弄懂它们而已。
wmic就是wmic.exe，位于windows目录底下，是一个命令行程序。WMIC可以以两种模式执行：交互模式(Interactive mode)和非交互模式(Non-Interactive mode)，经常使用Netsh命令行的读者应该非常熟悉这两种模式。
交互模式。如果你在命令提示符下或通过"运行"菜单只输入WMIC，都将进入WMIC的交互模式，每当一个命令执行完毕后，系统还会返回到WMIC提示符下，如"Root\cli"，交互模式通常在需要执行多个WMIC指令时使用。交互模式有时还会对一些敏感的操作要求确认，比如删除操作，最大限度地防止用户操作出现失误。
非交互模式。非交互模式是指将WMIC指令直接作为WMIC的参数放在WMIC后面，当指令执行完毕后再返回到普通的命令提示符下，而不是进入到WMIC上下文环境中。WMIC的非交互模式主要用于批处理或者其他一些脚本文件中，我在本文中一律用●非交互模式●示例。
开关有以下的全局开关，打入wmic.exe /?可以看到的（这里我们先不讨论每个开关的具体意思，具体用法看示例）：
★
/NAMESPACE 别名使用的名称空间路径。
/ROLE 包含此别名定义的角色路径。
/NODE 别名使用的服务器。
/IMPLEVEL 客户模拟级别。
/AUTHLEVEL 客户身份验证级别。
/LOCALE 客户应用的语言识别符。
/PRIVILEGES 启用或禁用所有特权。
/TRACE 将调试信息输出到 stderr。
/RECORD 将所有输入命令和输出写入日志。
/INTERACTIVE 设置或重设交互模式。
/FAILFAST 设置或重置 FailFast 模式。
/USER 会话期间使用的用户。
/PASSWORD 用于会话登录的密码。
/OUTPUT 为输出重新定向指定模式。
/APPEND 为输出重新定向指定模式。
/AGGREGATE 设置或重置集合模式。
/AUTHORITY Specifies the <authority type> for the connection.
/?[:<BRIEF|FULL>] Usage information.
★


至于别名啦，就是给主板、服务、系统、进程啦这些和计算机相关的东东起了个英文名，在wmic.exe /?命令行下也可以看到。
wql语句和我们平常用的注入时的sql语句的语法几乎是一模一样，甚至更简单。一般是where name="xxx" and 之类的，不过有时候要把name＝“xxx"这样的格式换成"name='xxx'"或者是where(name='xxx')这样，反正正常情况下不行的话就换个写法。
动词呢，就那么简单几个assoc、call、CREATE、DELETE、GET、LIST、SET，从英文名字上应当可以看出它们是用来干什么的。不过说实话，assoc我真的还没用到过。
至于副词（动词的参数），就是得到用动词+它的参数得到对象的属性。像属于list动词的副词，就是显示个什么样的呀,例如显示详细状态或简要状态。
动词开关就好比显示个横表格式的或者显示个竖表格式的或者输出个什么样格式的文件，或者是几秒来重复显示信息等等，有的动词并没有开关。

二、一步一步来完成我们的wmic命令行

wmic里有个别名是logicaldisk，就是对磁盘进行管理。我们先按照最简单的格式来写，在cmd命令行下输入●wmic logicaldisk list●（wmic.exe+别名+list动词），稍等一会儿屏幕上会出现本地硬盘的各式各样的数据，看上去杂乱无章。这样子太不方便看了，我们来改写一下，改成●wmic logicaldisk list brief●,在list动词后加个brief参数，也就是brief副词，显示的就会很整齐，效果如下：
★
DeviceID brief FreeSpace ProviderName Size VolumeName
A: 2
C: 3 2925694976 6805409792 WINXP
D: 3 1117487104 1759936512 WORK
E: 5
★
大家可能注意到了上面命令行中有动词list和副词brief。list动词决定显示的信息格式与范围，它有Brief、Full、Instance、 Status、System、Writeable等多个参数(副词)，full只是它的一个参数，也是list的缺省参数，表示显示所有的信息。其他几个参数顾名思义，如Brief表示只显示摘要信息，Instance表示只显示对象实例，Status表示显示对象状态，Writeable表示只显示该对象的可写入的属性信息等。
我们再来把语句加点东东，在上边磁盘返回信息当中的DeviceID的值为3时表示是本地硬盘的分区，如果是5为光区，为2则是移动磁盘了。我们把语句改一下，加入wql语句，只显示本地磁盘。语句改成●wmic logicaldisk where "DriveType=3" list brief●或者是●wmic logicaldisk where(DriveType=3)　list brief●,显示效果都是下边的样子：
★
DeviceID DriveType FreeSpace ProviderName Size VolumeName
C: 3 2925686784 6805409792 WINXP
D: 3 1117487104 1759936512 WORK
★
但是上边的格式呢显示的我们还是不太满意，ProviderName不知是个什么东东也给显示出来了，我们只想要我们想要的东东，像卷标 VolumeName之类的我们也不要它，再把语句改一下，换个get动词，命令改为●wmic logicaldisk where "DriveType=3" get DeviceID,Size,FreeSpace,Description,FileSystem●，返回信息如下：
★
DeviceID,Size,FreeSpace,Description,FileSystem
Description DeviceID FileSystem FreeSpace Size
本地固定磁盘 C: FAT32 2925686784 6805409792
本地固定磁盘 D: FAT 1117487104 1759936512
★
至于get动词后面跟的参数你可以先用list来查看一下就明白了。好了，这回可以得到我们想要的结果了。不过命令里的开关我们还没用到呢，加几个全局开关吧。先来加个/OUTPUT吧，让它把显示信息输出到一个文件中，命令如下：●wmic /output:a.html logicaldisk where "DriveType=3" get DeviceID,Size,FreeSpace,Description,FileSystem●，这样一来刚才屏幕上返回的信息就到当前目录的 a.htm里了。但是a.htm打开看看后，根本就像一个记事本一样，没有任何样式，看起来也不美观，我们给它指定一个样式，就要用到format这个动词开关了，命令改为●wmic /output:a.html logicaldisk where "DriveType=3" get DeviceID,Size,FreeSpace,Description,FileSystem /format:htable●，这样一来a.htm里就花花绿绿的用表格显示我们本地磁盘的信息了。也许你要问,htable是什么东东，其实这是一个文件，你想要上边的a.html什么格式，就可以在C:\WINDOWS\system32\wbem这里找一个你想要的格式的文件名，具体有以下一些文件：
★
CSV
HFORM
HMOF
HTABLE
HXML
LIST
TABLE
VALUE
htable-sortby
htable-sortby.xsl
texttablewsys
texttablewsys.xsl
wmiclimofformat
wmiclimofformat.xsl
wmiclitableformat
wmiclitableformat.xsl
wmiclitableformatnosys
wmiclitableformatnosys.xsl
wmiclivalueformat
wmiclivalueformat.xsl
★
还有人也许要问了，我只想显示c:盘的，不要其它盘的可以做到吗？当然可以，这就要用到wql语句的name这个变量了。你可以先用●wmic logicaldisk list Instance●看到name的具体名字，然后更改上边的wql语句。好啦，我们改一下，改成●wmic /output:a.html logicaldisk where "name='c:'" get DeviceID,Size,FreeSpace,Description,FileSystem /format:htable或者wmic /output:a.html logicaldisk where(name='c:') get DeviceID,Size,FreeSpace,Description,FileSystem /format:htable●就可以了。值得注意的是我们在DriveType=3的没有用到单引号是因为3是数字型的，而c:是字符型的所以要用单引号或双引号。不过要注意的是如果在wql语句中用到了and，请用()或者""把语句引起来。
这样一来，我们最后的语句基本符合了我文章开头说的wmic的命令格式是“wmic+开关+别名+wql语名+动词+副词（或者说是动词的参数）+动词开关”。不过wmic可不只能对本机操作，还可以对远程机器进行操作，我们再来加三个全局开关，让我们的这条命令对远程格式进行操作，命令就是：
●WMIC /node:"192.168.8.100" /user:"administrator" /password:"lcx" /output:a.html logicaldisk where "name='c:'" get DeviceID,Size,FreeSpace,Description,FileSystem /format:htable●
其中node开关表示对哪台机器进行访问，user和password当然是远程机器的用户名和密码了，这个命令有了以上的讲解，大家应当一目了然了吧。到现在为止，我们的动词只用到了get和list，我们再加一个set来改变c:盘的卷标。命令如下：●WMIC logicaldisk where "name='c:'" set VolumeName ="lcx"●，这样大家就更进一步清楚了这个格式的用法。写了这么多字，也许你要问到我wmic最有用的开关是什么，当然是"？"了，如果那个命令不会用，可以用wmic /? 、WMIC logicaldisk /?、WMIC logicaldisk　list /?、WMIC logicaldisk set /?这样仪次来查询用法。

三、总结

wmic是很强大的，像开2003的3389一句话就可以做到：●wmic RDTOGGLE WHERE ServerName='%COMPUTERNAME%' call SetAllowTSConnections 1●。不过呢，
这篇文章估计会有让观众上当受骗的感觉，一个wmic的磁盘命令写了这么长的篇幅，不过我想有了本文的基础，你研究wmic其它的别名像进程、服务、bios、主板呀，都会有一个切入点，具体的好的技巧如开3389等就要靠大家去研究发现了。

补充：

Windows WMIC命令详解

rem 查看cpu
wmic cpu list brief
rem 查看物理内存
wmic memphysical list brief
rem 查看逻辑内存
wmic memlogical list brief
rem 查看缓存内存
wmic memcache list brief
rem 查看虚拟内存
wmic pagefile list brief
rem 查看网卡
wmic nic list brief
rem 查看网络协议
wmic netprotocal list brief

【例】将当前系统BIOS，CPU，主板等信息输出到一个HTML网页文件，命令如下:

::得到系统信息.bat，运行bat文件即可
::系统信息输出到HTML文件,查看帮助: wmic /?
::wmic [系统参数名] list [brief|full] /format:hform >|>> [文件名]
wmic bios            list brief   /format:hform > PCinfo.html
wmic baseboard       list brief   /format:hform >>PCinfo.html
wmic cpu             list full    /format:hform >>PCinfo.html
wmic os              list full    /format:hform >>PCinfo.html
wmic computersystem  list brief   /format:hform >>PCinfo.html
wmic diskdrive       list full    /format:hform >>PCinfo.html
wmic memlogical      list full    /format:hform >>PCinfo.html
PCinfo.html
--------------------------------------------------------------------------------
WMIC命令参数帮助参考:
--------------------------------------------------------------------------------
ALIAS                    - 访问本地机器上的别名
BASEBOARD                - 基板 (也叫母板或系统板) 管理。
BIOS                     - 基本输入/输出服务 (BIOS) 管理。
BOOTCONFIG               - 启动配置管理。
CDROM                    - CD-ROM 管理。
COMPUTERSYSTEM           - 计算机系统管理。
CPU                      - CPU 管理。
CSPRODUCT                - SMBIOS 的计算机系统产品信息。
DATAFILE                 - DataFile 管理。
DCOMAPP                  - DCOM 程序管理。
DESKTOP                  - 用户桌面管理。
DESKTOPMONITOR           - 监视器管理。
DEVICEMEMORYADDRESS      - 设备内存地址管理。
DISKDRIVE                - 物理磁盘驱动器管理。
DISKQUOTA                - NTFS 卷磁盘空间使用情况。
DMACHANNEL               - 直接内存访问(DMA)频道管理。
ENVIRONMENT              - 系统环境设置管理。
FSDIR                    - 文件目录系统项目管理。
GROUP                    - 组帐户管理。
IDECONTROLLER            - IDE 控制器管理。
IRQ                      - 间隔请求线 (IRQ) 管理。
JOB                      - 提供对使用计划服务安排的工作的访问。
LOADORDER                - 定义执行依存的系统服务管理。
LOGICALDISK              - 本地储存设备管理。
LOGON                    - 登录会话。
MEMCACHE                 - 缓存内存管理。
MEMLOGICAL               - 系统内存管理 (配置布局和内存可用性)。
MEMPHYSICAL              - 计算机系统物理内存管理。
NETCLIENT                - 网络客户端管理。
NETLOGIN                 - (某一用户的)网络登录信息管理。
NETPROTOCOL              - 协议 (和其网络特点) 管理。
NETUSE                   - 活动网络连接管理。
NIC                      - 网络界面控制器 (NIC) 管理。
NICCONFIG                - 网络适配器管理。
NTDOMAIN                 - NT 域管理。
NTEVENT                  - NT 事件日志的项目
NTEVENTLOG               - NT 时间日志文件管理。
ONBOARDDEVICE            - 母板(系统板)内置普通设适配器设备的管理。
OS                       - 已安装的操作系统管理。
PAGEFILE                 - 虚拟内存文件对调管理。
PAGEFILESET              - 页面文件设置管理。
PARTITION                - 物理磁盘分区区域的管理。
PORT                     - I/O 端口管理。
PORTCONNECTOR            - 物理连接端口管理。
PRINTER                  - 打印机设备管理。
PRINTERCONFIG            - 打印机设备配置管理。
PRINTJOB                 - 打印工作管理。
PROCESS                  - 进程管理。
PRODUCT                  - 安装包任务管理。
QFE                      - 快速故障排除。
QUOTASETTING             - 设置卷的磁盘配额信息。
RECOVEROS                - 当操作系统失败时，将从内存收集的信息。
REGISTRY                 - 计算机系统注册表管理。
SCSICONTROLLER           - SCSI 控制器管理。
SERVER                   - 服务器信息管理。
SERVICE                  - 服务程序管理。
SHARE                    - 共享资源管理。
SOFTWAREELEMENT          - 安装在系统上的软件产品元素的管理。
SOFTWAREFEATURE          - SoftwareElement 的软件产品组件的管理。
SOUNDDEV                 - 声音设备管理。
STARTUP                  - 用户登录到计算机系统时自动运行命令的管理。
SYSACCOUNT               - 系统帐户管理。
SYSDRIVER                - 基本服务的系统驱动程序管理。
SYSTEMENCLOSURE          - 物理系统封闭管理。
SYSTEMSLOT               - 包括端口、插口、附件和主要连接点的物理连接点管理。
TAPEDRIVE                - 磁带驱动器管理。
TEMPERATURE              - 温度感应器的数据管理 (电子温度表)。
TIMEZONE                 - 时间区域数据管理。
UPS                      - 不可中断的电源供应 (UPS) 管理。
USERACCOUNT              - 用户帐户管理。
VOLTAGE                  - 电压感应器 (电子电量计) 数据管理。
VOLUMEQUOTASETTING       - 将某一磁盘卷与磁盘配额设置关联。
WMISET                   - WMI 服务操作参数管理。