# [使用XUL开发跨平台桌面应用 - otherhill - 博客园](http://cache.baiducontent.com/c?m=WFXaNrUfr4S73laGq60KXsynrqTojWdKBrNXv1Kn4TTuMukAH_UPn6atcT2jHVJmlqhomunin0Zj8GqJf-S9fe93uILCjMkc2Yq8qPI1ulzlwJRZlzs09HtEeSsvRqu-VI2pHzMVApeyIyH4eO4uPYMhtgOB7X1vt8SnpGIk_JW&p=8d65c64ad49c11a058e8d13e5f5e&newp=9b769a4786cc41aa17abc836565f92695803ed6338d7d601298ffe0cc4241a1a1a3aecbf2c251505d4c2776102a84e5dedf23072300634f1f689df08d2ecce7e&s=eccbc87e4b5ce2fe&user=baidu&fm=sc&query=xul+%D7%C0%C3%E6%BF%AA%B7%A2&qid=e30eaa8f00002ec1&p1=5)

 一、基本概念

   XUL 是一个[Mozilla](http://www.mozilla.org/)使用XML来描述用户界面的一种技术，使用XUL你可以快速的创建出跨平台，基于因特网的应用程序。

   XULRunner是一个由Mozilla基金会开发运行时环境，用来为XUL和XPCOM应用程序提供统一的后端运行环境。所有基于XUL的应用程序都是运行在XULRunner之上的，比如我们比较常用的Firefox和Thunderbird。

   Gecko是套开放原始码的、以C++编写的网页排版引擎，目前为Mozilla家族网页浏览器以及Netscape 6以后版本浏览器所使用，XULRunner使用的也是它。

二、搭建开发环境

   1、XULRunner为XUL应用程序提供了后端运行环境，下载[XULRunner SDK](http://ftp.mozilla.org/pub/mozilla.org/xulrunner/releases/)，由于XULRunner自带Gecko引擎，因此不必再单独下载。

​     本人下载的是XULRunner sdk 2.0 for windows版本，下面的开发主要以XULRunner sdk 2.0 for windows为主，如果下载的是XULRunner2.0以前的版本则下面的内容有的则需要修改。

   2、配置环境变量，这个可选只是为了方便，解压XULRunner sdk 2.0，添加xulrunner.exe所在的目录到环境变量，如：D:\xulrunner2.0\bin;

三、手工创建XUL应用程序

   1、创建XUL应用程序所需目录及文件，结构如下:



```
      -HelloXUL
           application.ini
           chrome.manifest
           -defaults
               -preferences
                    prefs.js
           -chrome
               -content
                    HelloXUL.xul
```



   2、编辑application.ini

​     application.ini中包含此应用程序的基本信息，Gecko的版本信息，也是应用程序启动的入口;HelloXUL的信息如下:



```
     [App]
     Name=HelloXUL
     ID=lintclr@126.com 
     Version=1.0.0.0
     BuildID=20120204
     Vendor=
     [Gecko]
     MinVersion=1.8
     MaxVersion=2.0.0.*
     [XRE]
```



   3、编辑chrome.manifest

​     chrome.manifest包含XUL应用程序的组织结构;HelloXUL的信息如下：

​     content     HelloXUL    chrome/content/

​     具体其他选项参照：<https://developer.mozilla.org/en/Chrome_Registration>

   4、编辑prefs.js

​      此文件主要包括应用程序的配置信息;HelloXUL配置如下：



```
pref("toolkit.defaultChromeURI", "chrome://HelloXUL/content/HelloXUL.xul");

/* debugging prefs */
pref("browser.dom.window.dump.enabled", true);
pref("javascript.options.showInConsole", true);
pref("javascript.options.strict", true);
pref("nglayout.debug.disable_xul_cache", true);
pref("nglayout.debug.disable_xul_fastload", true);

/* added to allow <label class="text-links" ... /> to work */
pref("network.protocol-handler.expose.http", false);
pref("network.protocol-handler.warn-external.http", false);
```



   5、编辑HelloXUL.xul

​     以下代码创建一个窗口，一个按钮，点击按钮弹出提示框，显示HelloXUL。



```
<?xml version="1.0"?>
<?xml-stylesheet href="chrome://global/skin/" type="text/css"?>
<window xmlns="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul" style="width: 500px; height: 300px;">
      <hbox>
            <button label="HelloXUL" oncommand="alert('HelloXUL')"/>
      </hbox>
</window>
```



   6、运行应用程序

​     进入应用程序主目录即HelloXUL目录，输入：xulrunner application.ini，然后回车，第一个应用程序成功运行。

四、使用IDE工具创建XUL应用程序 

   1、下载最新版[XUL Explorer](https://developer.mozilla.org/en/XUL_Explorer)工具

   2、双击安装程序,按照步骤依次安装，安装成功后运行XUL Explorer，按照以下步骤创建应用程序:

​     ![img](https://pic002.cnblogs.com/images/2012/339657/2012020916315712.png)

![img](https://pic002.cnblogs.com/images/2012/339657/2012020916334328.png)

![img](https://pic002.cnblogs.com/images/2012/339657/2012020916343322.png)

![img](https://pic002.cnblogs.com/images/2012/339657/2012020916350557.png)

 注：由于我们XULRunner版本为2.0故，此处最大版本改为2.0.0.*;

![img](https://pic002.cnblogs.com/images/2012/339657/2012020916354145.png)

![img](https://pic002.cnblogs.com/images/2012/339657/2012020916360350.png)

​     点击Finish完成。

  3、进入创建应用程序目录可以看到和我们手工创建的应用程序结构一样，用上面一样的方法运行，程序成功运行。

  4、如果创建时发生"0x80004002 (NS_NOINTERFACE)"错误进行以下操作：

​    (1)将 XUL Explorer 中 chrome 目录下的 en-US.jar 解压，目录名为“en-US”，其中的目录层次要和en-US.jar中的完全一致。

​    (2)修改 en-US.manifest 文件，将 locale explorer en-US jar:en-US.jar!/ 改为 locale explorer en-US file:en-US/

五、应用程序实现双击运行

  1、在应用程序根目录创建xulrunner目录，将xulrunner sdk中bin目录里的内容复制到该目录。

  2、将xulrunner目录中的xulrunner-stub.exe和mozcrt19.dll复制到应用程序的根目录，双击xulrunner-stub.exe应用程序成功运行。



分类: [Mozilla开发](https://www.cnblogs.com/ourroad/category/353307.html)