# Windows下gogs迁移后，push时报错remote: hooks/pre-receive路径问题


直接拷贝gogs-repositories导致项目中的hooks文件下的post-receive pre-receive update三个脚本中的调用路径与实际不符，导致

remote: hooks/pre-receive: line 2: <path>: No such file or directory


解决办法
在gogs-repositories仓库中找到每个工程的hooks文件夹，修改post-receive pre-receive update三个脚本中的调用路径。

有两个路径，第一个路径改为 .../Git/gogs/gogs.exe
第二个路径改为…/Git/gogs/custom/cof/app.ini







## misc

remote: hooks/pre-receive: line 2: gogs.exe: command not found



###  zalFindpeak
! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'http://192.168.224.1:3000/misc/zalFindpeak'

```
$ git push
Logon failed, use ctrl+c to cancel basic credential prompt.
Username for 'http://192.168.224.1:3000': abc
error: unable to read askpass response from 'C:/Program Files/Git/mingw64/libexec/git-core/git-gui--askpass'
Password for 'http://abc@192.168.224.1:3000':
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 6 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 265 bytes | 265.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0)
remote: hooks/pre-receive: line 2: E:\greensoftware\misc\gogs\gogs.exe: command not found
To http://192.168.224.1:3000/misc/zalFindpeak
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'http://192.168.224.1:3000/misc/zalFindpeak'
(base)
```



H:\Project\repos\zalfindpeak.git\hooks\pre-receive

```
#!/usr/bin/env bash
"E:\greensoftware\misc\gogs\gogs.exe" hook --config='E:\greensoftware\misc\gogs\custom\conf\app.ini' pre-receive
```





```
$ git push
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 6 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 259 bytes | 259.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0)
error: RPC failed; HTTP 403 curl 22 The requested URL returned error: 403
fatal: the remote end hung up unexpectedly
fatal: the remote end hung up unexpectedly
Everything up-to-date
(base)

```

