# Cron 设置git自动提交脚本 不能 push



**1.自动提交的脚本**

```groovy
文件名： /home/user/project_path/push.sh
```

$: sudo chmod a+x push.sh

```perl
#bin/bash
cd project_path
GIT=`which git`
${GIT} add --all
time=`date`
${GIT} commit -m "提交的时间是: $time"
HOME=/home/user ${GIT} push  git_ssh_path master
```

**2.设置crontab定时任务（每天12点执行）**

$: crontab -e

```crystal
00 12 * * * /home/user/project_path/push.sh
```

$: sudo service cron restart

$: sudo service cron reload

**3.等到脚本执行后**

观察脚本 commit 都是正常的，只有最后一步不能push

最奇怪的是 我手动 提交的时候是能正常 push到远程的。

**4.打印cron任务日志（为什么crontab 不能自动提交到远程）**

00 12 * * * /home/user/project_path/push.sh >> /home/user/document/error.log 2>&1

**5.查看脚本log**

```vbscript
$ cat /home/user/document/error.log
[master 09b9f94] 提交的时间是: 2018年 04月 03日 星期二 11:32:01 CST
 2 files changed, 13 deletions(-)
 delete mode 100755 notebook.zim
 delete mode 100644 无标题文档
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0777 for '/home/user/.ssh/id_rsa' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "/home/user/.ssh/id_rsa": bad permissions
Permission denied (publickey).
fatal: Could not read from remote repository.
```

发现错误的是 id_rsa 的权限问题

**6. id_rsa 的权限是 700**

```javascript
sudo chmod 700 ~/.ssh/id_rsa
```

**7.完美解决问题，每天自动提交 ，我很满意**





```bash
#cat my.sh
# !/bin/bash
echo "HAHA begin" >> /tmp/log
git pull origin master >> /tmp/log || {echo "pull error" && exit 0}
echo "Done"

```

