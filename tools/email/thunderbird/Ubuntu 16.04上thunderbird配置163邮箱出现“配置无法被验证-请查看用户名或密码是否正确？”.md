# [Ubuntu 16.04上thunderbird配置163邮箱出现“配置无法被验证-请查看用户名或密码是否正确？”](https://www.cnblogs.com/25th-engineer/p/10264492.html)

　　在Ubuntu 16.04 上用thunderbird配置163免费邮箱时出现的提示信息如图1：

![img](https://img2018.cnblogs.com/blog/830478/201901/830478-20190113225103499-584210570.png)

图1 提示信息

　　网上有不少方法都说是将接收和发出的主机名分别改为 imap.ym.163.com 和 smtp.ym.163.com，但是我试过了，还是会出现一样的提示信息。而且我确认我的POP3/SMTP/IMAP服务都是开启的。

![img](https://img2018.cnblogs.com/blog/830478/201901/830478-20190113225457901-1076378364.png)

图2 开启POP3/SMTP/IMAP服务

　　几经摸索，我发现在第三端（除了网易的官方应用外）配置163邮箱时，需要输入的不是你在网页登录邮箱时的密码，而是被称作“授权码”的一串由数字和字母组成的字符。获取授权码的方法是，在网页端的设置->客户端授权密码中，勾选“设置客户端授权码”的“开启”复选项，再点击“重置授权码”，这时可能需要验证身份。

![img](https://img2018.cnblogs.com/blog/830478/201901/830478-20190113232102931-221290391.png)

　　图3 网易邮箱授权码

　　

　　之后按照提示操作便行，当出现授权码（授权码只显示一次！）时，将其复制粘贴到thunderbird对应区域再点击“完成”就配置成功了。

　　重要的事情强调三遍：授权码只显示一次！授权码只显示一次！授权码只显示一次！

　　值得一提的是，是否为SSL协议对应的端口号是不同的，设置不当也会引发错误。

![img](https://img2018.cnblogs.com/blog/830478/201901/830478-20190118212224973-1676278495.png)

图4 服务器与对应协议端口号

　　一番周折后总算大功告成！ 

 

![img](https://img2018.cnblogs.com/blog/830478/201901/830478-20190113232122101-1020631470.png)　　图5 配置成功



标签: [刁肥宅手笔](https://www.cnblogs.com/25th-engineer/tag/%E5%88%81%E8%82%A5%E5%AE%85%E6%89%8B%E7%AC%94/), [thunderbird配置](https://www.cnblogs.com/25th-engineer/tag/thunderbird%E9%85%8D%E7%BD%AE/), [Ubuntu 16.04配置thunderbird](https://www.cnblogs.com/25th-engineer/tag/Ubuntu%2016.04%E9%85%8D%E7%BD%AEthunderbird/), [配置无法被验证-请查看用户名或密码是否正确？](https://www.cnblogs.com/25th-engineer/tag/%E9%85%8D%E7%BD%AE%E6%97%A0%E6%B3%95%E8%A2%AB%E9%AA%8C%E8%AF%81-%E8%AF%B7%E6%9F%A5%E7%9C%8B%E7%94%A8%E6%88%B7%E5%90%8D%E6%88%96%E5%AF%86%E7%A0%81%E6%98%AF%E5%90%A6%E6%AD%A3%E7%A1%AE%EF%BC%9F/)