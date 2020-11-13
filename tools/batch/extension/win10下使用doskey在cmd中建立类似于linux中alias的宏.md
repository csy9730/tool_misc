# win10下使用doskey在cmd中建立类似于linux中alias的宏



在linux系统中可以通过修改.bashrc文件十分简便的设置alias宏命令（macro)
在win10下cmd中实现相同的功能要复杂一点

# 新建宏文件

首先你需要一个文件存放宏，假设我们在C盘根目录下建立了文件**cmd-alias.bat**

# 修改注册表

然后你需要在启动cnd时自动加载文件中的宏，那么问题来了，怎么自动加载宏？修改注册表：
1、摁下win+R输入regedit回车
2、在菜单栏下的路径栏输入`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor`回车
3、右侧新建**字符串值**，数值名称填`AutoRun`，数值数据填**C:\cmd-alias.bat**（第一步那个文件的路径）
4、关闭即可。。

# 修改宏文件

右键第一步的文件，选择**编辑**（默认用记事本打开）

◎ 在windows系统下不是`alias`命令，而是`doskey`命令

> doskey程序路径为`C:\Windows\System32\doskey.exe`

◎ 与.bashrc文件一样，一行一个doskey，语句以`doskey`开头

◎ 以`@doskey`开头的宏在cmd打开时不会显示在屏幕上

## 单个命令的宏

`@doskey ls=dir`：列出当前目录下的子文件/子目录信息

> win10默认为**dir**，linux默认为ls，这里我们设置**ls**起到与dir相同的作用

`@doskey ls=dir $\*`：**$\***表示后面可能还有其他参数，参考**ls**

## 多个命令的宏

多个命令的宏用**$t**隔开，命令间不用加空格
`@doskey hexocgd=hexo clean$thexo g$thexo d`：顺序执行`hexo clean`, `hexo g`, `hexo d`

# doskey

`doskey /MACROS` 可查看所有已经定义的宏命令