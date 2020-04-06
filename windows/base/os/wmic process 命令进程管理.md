wmic process 命令进程管理 【转】
netstat -an -b -o    //获取进程名称 端口 pid
wmic process list brief >> d:\process.txt  //获取进程摘要信息

结束一个进程(可根据进程对应的PID)
wmic process where name="notepad.exe" delete
wmic process where name="notepad.exe" terminate
wmic process where pid="123" delete
wmic path win32_process where "name='notepad.exe'" delete

创建一个进程
wmic process call create "c:\windows\system32\calc.exe"

查询进程的启动路径(将得到的信息输出)
wmic process get name,executablepath,processid
wmic /output:c:\process.html process get processid,name,executablepath /format:htable.xsl

查询指定进程的信息
wmic process where name="notepad.exe" get name,executablepath,processid

在远程计算上创建进程
wmic /node:192.168.8.10 /user:administrator /password:xiongyefeng process call create "c:\windows\notepad.exe"

查询远程计算机上的进程列表
wmic /node:192.168.8.10 /user:administrator /password:xiongyefeng process get name,executablepath,processid

将获得到的远程计算机进程列表保存到本地

wmic /output:c:\process.html /node:192.168.8.10 /user:administrator /password:xiongyefeng process get processid,name,executablepath /format:htable.xsl

结束远程计算上的指定进程
wmic /node:192.168.8.10 /user:administrator /password:xiongyefeng process where name="notepad.exe" delete

重启远程计算机
wmic /node:192.168.8.10 /user:administrator /password:xiongyefeng process call create "shutdown -r -f"

关闭远程计算机
wmic /node:192.168.8.10 /user:administrator /password:xiongyefeng process call create "shutdown -s -f"

高级应用：

结束可疑的进程
wmic process where "name='explorer.exe' and executablepath <> '%systemdrive%\\windows\\explorer.exe'" delete
wmic process where "name='svchost.exe' and executablepath <> '%systemdrive%\\windows\\system32\\svchost.exe'" call terminate

======对磁盘的管理========
查看磁盘的属性
wmic logicaldisk list brief

根据磁盘的类型查看相关属性
wmic logicaldisk where drivetype=3 list brief

使用get参数来获得自己想要参看的属性
wmic logicaldisk where drivetype=3 get deviceid,size,freespace,description,filesystem

只显示c盘的相关信息
wmic logicaldisk where name="c:" get deviceid,size,freespace,description,filesystem

更改卷标的名称
wmic logicaldisk where name="c:" set volumename=lsxq

获得U盘的盘符号
wmic logicaldisk where drivetype='2' get deviceid,description

--------------------------------------------------

------------------------------------------------

BIOS - 基本输入/输出服务 (BIOS) 管理
::查看bios版本型号
wmic bios get Manufacturer,Name

COMPUTERSYSTEM - 计算机系统管理
::查看系统启动选项,boot的内容
wmic COMPUTERSYSTEM get SystemStartupOptions
::查看工作组/域
wmic computersystem get domain
::更改计算机名abc为123
wmic computersystem where "name='abc'" call rename 123
::更改工作组google为MyGroup
wmic computersystem where "name='google'" call joindomainorworkgroup "","","MyGroup",1

CPU - CPU 管理
::查看cpu型号
wmic cpu get name

DATAFILE - DataFile 管理
::查找e盘下test目录(不包括子目录)下的cc.cmd文件
wmic datafile where "drive='e:' and path='\\test\\' and FileName='cc' and Extension='cmd'" list
::查找e盘下所有目录和子目录下的cc.cmd文件,且文件大小大于1K
wmic datafile where "drive='e:' and FileName='cc' and Extension='cmd' and FileSize>'1000'" list
::删除e盘下文件大小大于10M的.cmd文件
wmic datafile where "drive='e:' and Extension='cmd' and FileSize>'10000000'" call delete
::删除e盘下test目录(不包括子目录)下的非.cmd文件
wmic datafile where "drive='e:' and Extension<>'cmd' and path='test'" call delete
::复制e盘下test目录(不包括子目录)下的cc.cmd文件到e:\,并改名为aa.bat
wmic datafile where "drive='e:' and path='\\test\\' and FileName='cc' and Extension='cmd'" call copy "e:\aa.bat"
::改名c:\hello.txt为c:\test.txt
wmic datafile "c:\\hello.txt" call rename c:\test.txt
::查找h盘下目录含有test,文件名含有perl,后缀为txt的文件
wmic datafile where "drive='h:' and extension='txt' and path like '%\\test\\%' and filename like '%perl%'" get name

DESKTOPMONITOR - 监视器管理
::获取屏幕分辨率
wmic DESKTOPMONITOR where Status='ok' get ScreenHeight,ScreenWidth

DISKDRIVE - 物理磁盘驱动器管理
::获取物理磁盘型号大小等
wmic DISKDRIVE get Caption,size,InterfaceType

ENVIRONMENT - 系统环境设置管理
::获取temp环境变量
wmic ENVIRONMENT where "name='temp'" get UserName,VariableValue
::更改path环境变量值,新增e:\tools
wmic ENVIRONMENT where "name='path' and username='<system>'" set VariableValue="%path%;e:\tools"
::新增系统环境变量home,值为%HOMEDRIVE%%HOMEPATH%
wmic ENVIRONMENT create name="home",username="<system>",VariableValue="%HOMEDRIVE%%HOMEPATH%"
::删除home环境变量
wmic ENVIRONMENT where "name='home'" delete

FSDIR - 文件目录系统项目管理
::查找e盘下名为test的目录
wmic FSDIR where "drive='e:' and filename='test'" list
::删除e:\test目录下除过目录abc的所有目录
wmic FSDIR where "drive='e:' and path='\\test\\' and filename<>'abc'" call delete
::删除c:\good文件夹
wmic fsdir "c:\\good" call delete
::重命名c:\good文件夹为abb
wmic fsdir "c:\\good" rename "c:\abb"

LOGICALDISK - 本地储存设备管理
::获取硬盘系统格式、总大小、可用空间等
wmic LOGICALDISK get name,Description,filesystem,size,freespace

NIC - 网络界面控制器 (NIC) 管理

OS - 已安装的操作系统管理
::设置系统时间
wmic os where(primary=1) call setdatetime 20070731144642.555555+480

PAGEFILESET - 页面文件设置管理
::更改当前页面文件初始大小和最大值
wmic PAGEFILESET set InitialSize="512",MaximumSize="512"
::页面文件设置到d:\下,执行下面两条命令
wmic pagefileset create name='d:\pagefile.sys',initialsize=512,maximumsize=1024
wmic pagefileset where"name='c:\\pagefile.sys'" delete

PROCESS - 进程管理
::列出进程的核心信息,类似任务管理器
wmic process list brief
::结束svchost.exe进程,路径为非C:\WINDOWS\system32\svchost.exe的
wmic process where "name='svchost.exe' and ExecutablePath<>'C:\\WINDOWS\\system32\\svchost.exe'" call Terminate
::新建notepad进程
wmic process call create notepad

PRODUCT - 安装包任务管理
::安装包在C:\WINDOWS\Installer目录下
::卸载.msi安装包
wmic PRODUCT where "name='Microsoft .NET Framework 1.1' and Version='1.1.4322'" call Uninstall
::修复.msi安装包
wmic PRODUCT where "name='Microsoft .NET Framework 1.1' and Version='1.1.4322'" call Reinstall

SERVICE - 服务程序管理
::运行spooler服务
wmic SERVICE where name="Spooler" call startservice
::停止spooler服务
wmic SERVICE where name="Spooler" call stopservice
::暂停spooler服务
wmic SERVICE where name="Spooler" call PauseService
::更改spooler服务启动类型[auto|Disabled|Manual] 释[自动|禁用|手动]
wmic SERVICE where name="Spooler" set StartMode="auto"
::删除服务
wmic SERVICE where name="test123" call delete

SHARE - 共享资源管理
::删除共享
wmic SHARE where name="e$" call delete
::添加共享
WMIC SHARE CALL Create "","test","3","TestShareName","","c:\test",0

SOUNDDEV - 声音设备管理
wmic SOUNDDEV list

STARTUP - 用户登录到计算机系统时自动运行命令的管理
::查看msconfig中的启动选项
wmic STARTUP list

SYSDRIVER - 基本服务的系统驱动程序管理
wmic SYSDRIVER list

USERACCOUNT - 用户帐户管理
::更改用户administrator全名为admin
wmic USERACCOUNT where name="Administrator" set FullName="admin"
::更改用户名admin为admin00
wmic useraccount where "name='admin" call Rename admin00

没有这么多结果。简简单单，走好每一步路----belie8