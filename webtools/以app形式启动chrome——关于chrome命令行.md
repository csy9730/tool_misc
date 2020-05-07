# [以app形式启动chrome——关于chrome命令行](https://www.cnblogs.com/x_wukong/p/4910692.html)

转自：http://wiselyman.iteye.com/blog/2179043

转自：http://bbs.ithome.com/thread-589651-1-1.html

转自：http://www.cnblogs.com/dsky/archive/2013/05/14/3077484.html

 

客户希望我们开发的不是一个B/S系统，而是一个客户端应用。

还有在一些需要全屏的需求的B/S系统的时候，需要隐藏所有浏览器的相关的内容。

按F11的全屏不能满足要求。

 

只需做如下操作：

Java代码 ![收藏代码](http://wiselyman.iteye.com/images/icon_star.png)

1. "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app=http://www.baidu.com 

 若需最大化增加"--start-maximized"
![img](http://dl2.iteye.com/upload/attachment/0105/5381/bdabc413-7f59-3442-941b-3748b1746077.png)

 

效果如下：


![点击查看原始大小图片](http://dl2.iteye.com/upload/attachment/0105/5383/8f0b3803-6e49-3d69-9172-4f6473e980d1.png)

 

 

Chrome命令行参数畅谈（一）
命令行参数是Chromium提供的一种延伸功能的方法，Chrome和Chromium都支持在启动时使用命令行参数，有些参数会改变浏览器功能和行为方式，有些则是测试和调试用的。目前Chrome有1000个左右的命令行参数。

一、使用方法：

\1. 更改快捷方式，使用此法须要用此快捷方式启动chrome才会带参数；

在快捷方式的“目标”输入栏内chrome.exe之后，添加“空格--参数”；

 

![img](http://www.qixing123.com/tech/1.jpg)
                
[登录/注册后可看大图](http://bbs.ithome.com/member.php?mod=logging&action=login)

 

\2. 修改注册表，使用此法即使从其他程序调用chrome而非从快捷方式打开，也会带着参数启动。例如：

Windows RegistryEditor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\ChromeHTML\shell\open\command]

@="\"C:\\Users\\lenovo\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe\" --参数 --参数 -- \"%1\""

![img](http://www.qixing123.com/tech/2.jpg)
                
[登录/注册后可看大图](http://bbs.ithome.com/member.php?mod=logging&action=login)

 

二、目的和意义：

\1. 扩充可以自定义的选项范畴，如user-data-dir="D:\userdata"自定义用户数据位置；

\2. 实现某些调试功能，如user-agent="Chromium or whatever"，改变自己的user agent以伪装成其他浏览器；



![img](http://www.qixing123.com/tech/3.jpg)
                
[登录/注册后可看大图](http://bbs.ithome.com/member.php?mod=logging&action=login)



\3. 快速调整设置，如--lang=zh_TW，将显示语言改为繁体中文。



三、常用命令行参数介绍：

\1. --incognito，设置浏览器直接从隐身模式启动功能，您在隐身模式中浏览网页不会保留浏览器记录、Cookie存储库或搜索记录，会保留下载的文件和已存的书签。

\2. --start-maximized，启动时自动最大化窗口。

\3. --lang=en_US，设置语言为英语_美国（这里可以写各种语言代码），快速切换显示语言，而免去在设置中点击数次并重启的麻烦。

\4. --user-agent="thatis my user agent"（如果字符串不含空格则无需引号），设置伪造的用户代理字符串，可以验证网站对于不同浏览器采取的不同的行为。

\5. --user-data-dir=D:\userdata，设置自定义用户数据位置，对于系统盘空间较小，希望把用户数据（包含缓存）放在其他位置的用户非常有用。

\6. --disable-images，设置为禁止图像，对于流量有限制，或者其他不想看图的人群非常有用。

\7. --no-sandbox，不使用沙箱，在和某些杀毒软件有冲突时，可以关闭沙箱。

\8. --trusted-plugins，仅使用信任的插件。

\9. --restore-last-session，启动时恢复最近的会话。



四、分类

Chrome依据参数的功能和性质，把所有参数分成了11个大类，接下来，我们会依次介绍这些类别中比较有意思的命令行参数。



五、Chrome命令行参数之基础类

\1. --debug-on-start，如果程序包含基础/调试/debug_on_start_win.h，（仅限于Windows），该过程将自启动JIT系统注册的调试器，并会等待60秒钟，让调试器连接到自身并打一个断点。

\2. --disable-breakpad，禁用崩溃报告。

\3. --wait-for-debugger，在60秒之内，等待一个调试器接入Chrome。

4.--test-child-process，当运行特定的派生子进程的测试，此开关会告诉测试框架，当前进程是一个子进程。

5.--enable-crash-reporter，表示崩溃报告应该启用。由辅助进程不能访问到所需文件的平台作出这个决定，此标志由内部产生。

6.--enable-crash-reporter-for-testing，用于在调试环境中打开Breakpad（一个非常实用的跨平台的崩溃转储和分析模块）崩溃报告，崩溃报告在那里通常会被编译，但被禁用了。

7.--full-memory-crash-report，生成全部内存崩溃报告。

8.--enable-low-end-device-mode，改写低端设备检测，启用低端设备的优化。

9.--disable-low-end-device-mode，改写低端设备检测，禁止低端设备的优化。

 

附其它收集命命令行参数：

disable-accelerated-compositing  禁用加速
disable-winsta  禁用渲染备用窗口
disable-application-cache  禁用应用程序缓存
disable-apps 禁用应用程序
disable-audio  禁用音频
disable-auth-negotiate-cname-lookup
disable-background-networking 禁用后台联网
disable-backing-store-limit  禁用存储数量限制，可以防止在打开大量的标签窗口时，页面出现闪烁的现象。
disable-byte-range-support  禁用缓存的支持字节范围
disable-click-to-play  禁用点击播放
disable-connect-backup-jobs  如果超过指定的时间，则禁用建立备份的TCP连接
disable-content-prefetch  禁用内容预取
disable-custom-jumplist  禁用Windows 7的JumpList自定义功能
disable-databases  禁用HTML5的数据库支持
disable-desktop-notifications  禁用桌面通知（默认窗口启用）
disable-dev-tools  禁用所有页面的渲染检测
disable-device-orientation  禁用设备向导
disable-webgl  禁用WebGL实验功能
disable-extensions  禁用扩展
disable-extensions-file-access-check  禁用扩展文件访问检查
disable-geolocation  禁用地理位置的JavaScript API
disable-glsl-translator  禁用GLSL翻译
disable-hang-monitor  禁止任务管理器监视功能
disable-internal-flash  禁用内部的Flash Player
disable-ipv6  禁用IPv6
disable-preconnect  禁用TCP/IP协议
disable-javascript  禁用JS
disable-java  禁用Java
disable-local-storage   禁用本地存储
disable-logging  禁用调试记录
disable-new-tab-first-run 禁用新标签显示的通知
disable-outdated-plugins  禁用过时的插件
disable-plugins  禁止插件
disable-popup-blocking  禁用阻止弹出窗口
disable-prompt-on-repost
disable-remote-fonts  禁用远程字体
disable-renderer-accessibility  禁用渲染辅助功能
disable-restore-background-contents  当浏览器重新启动后之前的网址被记录
disable-session-storage  禁用会话存储
disable-shared-workers  禁用共享，功能尚未完成
disable-site-specific-quirks  禁用指定站点设置的WebKit兼容性问题。
disable-speech-input  禁用语音输入
disable-ssl-false-start  禁用SSL的虚假启动
disable-sync  禁用同步
disable-sync-apps  禁用同步应用程序
disable-sync-autofill  禁用同步自动填表
disable-sync-bookmarks  禁用同步书签
disable-sync-extensions  禁用同步扩展
disable-sync-passwords  禁用同步密码
disable-sync-preferences  禁用同步偏好设置
disable-sync-sessions  禁用同步会话
disable-sync-themes  禁用同步主题（皮肤）
disable-sync-typed-urls  禁用同步输入网址
disable-tab-closeable-state-watcher  
disable-translate  禁用翻译
disable-web-resources  禁用网络资源后台加载服务
disable-web-security  禁用网络安全提示?
disable-web-sockets  禁用网络接口
safebrowsing-disable-auto-update 禁用自动升级(安全浏览)
disable-tls  禁用设置XMPP协议的客户端同步控制
disable-flash-core-animation  禁用Flash核心动画
disable-hole-punching  禁用Punching
disable-seccomp-sandbox  禁用沙盒
no-sandbox    启动无沙盒模式运行