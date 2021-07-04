# Win10怎么设置开机自动拨号（宽带连接）上网？Win10开机自动宽带连接方法

时间:2016-05-19来源： 本站整理 浏览量：

虽然有了路由器已经不需要我们每次打开电脑都进行宽带连接了，不过还是有小部分用户没有使用路由器，每次开机都要宽带连接才可以，对于Win10系统来说设置开机宽带连接要比Win7下麻烦一些，如果有兴趣不妨看看下面的教程吧。

![img](http://www.w10zj.com/uploadfile/2016/0519/20160519111851730.png)


**具体操作步骤：**

**步骤一：**

1、在计算机中找到【C:\Windows\System32\rasphone.exe】（创建快捷方式放在桌面上方便）双击运行，也可以用“win+R ”打开“运行”输入“rasphone.exe”www.10zj.com
2、把这个快捷方式放到系统开机启动文件夹-【C:\ProgramData\Microsoft\Windows\Start Menu\Programs】下的“启动”里就可以开机启动了

**步骤二：**

1.打开记事本，输入 ：CreateObject("WScript.Shell").run"Rasdial 宽带连接 帐号 密码",0

2.将句中帐号密码改为你的宽带连接帐户和密码，将记事本另存为:自动拨号.vbs"

3.登录自己用户时才能开机启动的启动文件夹。这是我自己用户的启动文件夹的地址C:\Users\ray\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup（注意\ray是我自己用户的用户名，大家复制粘贴时要改为你们自己的用户名），大家复制这个地址到文件夹的地址栏里再按回车键就能进去启动文件夹。

4.把自动拨号.vbs文件拖到启动文件夹里去就可以开机自动连接了。

**步骤三、**

win10 ，从 10240 到 10586 都有一个 bug,就是，启动文件夹内，执行的 bat文件第一行，会自己出现乱码，不可使用，所以你只要，将bat文件的第一行，留空白，你自己要执行的命令，从第二行开始写，就可以正确的被系统识别，而可以在开机时，自动运行了。

启动文件夹位置 ->

C:\Users\你的用户名\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

拨号批次档内容，如下说明

第一行（留空白）

第二行（开始拨号命令行）Rasdial ADSL 你的帐号 你的密码



当然除了上面的方法，大家还可以使用一些第三方软件来实现，如：ADSL宽带拨号王 本文由W10之家整理~



## misc

~\AppData\Roaming\Microsoft\Network\Connections\Pbk\rasphone.pbk