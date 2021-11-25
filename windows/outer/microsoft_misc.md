# misc

- ubuntu 18 ltsc
- microsoft shop
- hyperv
- wsl
- Windows Sandbox

### Windows Sandbox
Windows Sandbox是一个独立的临时桌面环境，你可以在其中运行不受信任的软件，而不必担心会对PC造成持久影响。Windows Sandbox中安装的任何软件仅保留在沙箱中，不会影响你的主机。Windows Sandbox关闭后，将永久删除包含的所有文件和软件状态。


### windows defender

windows 8
```
0x800700E1: 无法成功完成操作，因为文件包含病毒 解决方法

0x800700E1:Operation did not complete successfully because the file contains a virus.
0x800700E1: 因為檔案包含病毒，所以作業未順利完成。
```
今天用windows 8拷贝文件 ,提示这个问题

查了半天

发现是自带windows defender 的问题。

解决方法就是 关闭windows defender就可以了。