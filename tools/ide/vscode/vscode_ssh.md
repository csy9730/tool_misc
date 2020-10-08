# vscode ssh


vscode在windows下，支持远程机是openssh for windows，不支持msys-ssh。
```
Unsupported architecture: MSYS_NT-6.1-7601 x86_64
> 4eba9e07d2ed##27##


```


Can't connect to remote SSH host 
VS Code shows an error at right-bottom: Failed to connect to the remote extension host server (Error: Connection error: Unauthorized client refused.

You could try reinstalling by deleting the folder ~/.vscode-remote from the remote machine

## code-server


[code-server](https://github.com/cdr/code-server/releases)



将下载的code-server二进制包解压缩，在终端运行 ./code-server 即可在服务器端启动VScode，然后在chrome中输入`https://localhost:8443` 并输入密码即可运行。

浏览器中,点击f11键可以进入全屏模式,可以避免快捷键冲突
打包成chrome app也可以全屏运行.