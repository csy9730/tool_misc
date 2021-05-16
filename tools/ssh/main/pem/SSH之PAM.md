# [SSH之PAM](https://www.pythondesign.cn/959.html)

作者：[A哥](https://www.pythondesign.cn/author/hanwei) 发布时间： 2020-03-11   1.3K 人阅读  本文共计1099个字，预计阅读时长4分钟。

登录时的PAM验证机制流程如下



第一阶段：验证阶段

1.经过pam_securetty.so判断，看用户是什么，如果是root，读取/etc/

securetty的配置

2.经过pam_env.so配置额外的环境变量

3.透过pam_unix.so验证口令

4.3验证不通过则pam_deny.so判断UID是不是大于500.小于500则返回失败

5.由pam_deny.so拒绝连接



第二阶段：授权阶段

1. 先以 pam_nologin.so 判断 /etc/nologin 是否存在，若存在则不许一般使用者登陆；
2. 以 pam_unix 进行账号管理，
3. pam_succeed_if.so 判断 UID 是否小于 500 ，若小于 500 则不记录登录信息。
4. 最后以 pam_permit.so 允许该账号登陆。

第三阶段：口令阶段

1. 先以 pam_cracklib.so 配置口令仅能尝试错误 3 次；
2. 接下来以pam_unix.so 透过 md5, shadow 等功能进行口令检验，若通过则回报 login 程序，若不通过则
3. 以 pam_deny.so 拒绝登陆。

第四阶段：会议阶段

1. 先以 pam_selinux.so 暂时关闭 SELinux；
2. 使用 pam_limits.so 配置好用户能够操作的系统资源；
3. 登陆成功后开始记录相关信息在登录文件中；
4. 以 pam_loginuid.so 规范不同的 UID 权限；
5. 开启 pam_selinux.so 的功能。

​    总之，就是依据验证类别 (type) 来看，然后先由 login 的配置值去查阅，如果出现『 include system-auth 』就转到 system-auth 文件中的相同类别，去取得额外的验证流程就是了。然后再到下一个验证类别，最终将所有的验证跑完！就结束这次的 PAM 验证啦！

​    经过这样的验证流程，现在知道为啥 /etc/nologin 存在会有问题，也会知道为何你使用一些远程联机机制时，老是无法使用 root 登陆的问题了吧？没错！这都是 PAM 模块提供的功能啦！

例题：

为什么 root 无法以 telnet 直接登陆系统，但是却能够使用 ssh 直接登陆？

答：一般来说， telnet 会引用 login 的 PAM 模块，而 login 的验证阶段会有 /etc/securetty 的限制！由于远程联机属于 pts/n (n 为数字) 的动态终端机接口装置名称，并没有写入到 /etc/securetty ，因此 root 无法以 telnet 登陆远程主机。至于 ssh 使用的是 /etc/pam.d/sshd 这个模块，你可以查阅一下该模块，由于该模块的验证阶段并没有加入 pam_securetty ，因此就没有 /etc/securetty 的限制！故可以从远程直接联机到服务器端。