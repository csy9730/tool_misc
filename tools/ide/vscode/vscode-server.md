# vscode server

[https://github.com/coder/code-server](https://github.com/coder/code-server)


- Code on any device with a consistent development environment
- Use cloud servers to speed up tests, compilations, downloads, and more
- Preserve battery life when you're on the go; all intensive tasks run on your server





## install

https://github.com/coder/code-server/releases


```
csy@DESKTOP-VF3C7E5:~/download$ sudo dpkg --install code-server_4.16.1_amd64.deb
Selecting previously unselected package code-server.
(Reading database ... 42126 files and directories currently installed.)
Preparing to unpack code-server_4.16.1_amd64.deb ...
Unpacking code-server (4.16.1) ...
Setting up code-server (4.16.1) ...
csy@DESKTOP-VF3C7E5:~/download$ which code-server
/usr/bin/code-server
csy@DESKTOP-VF3C7E5:~/download$ code-server
[2023-08-18T02:32:43.926Z] info  Wrote default config file to ~/.config/code-server/config.yaml
[2023-08-18T02:32:45.123Z] info  code-server 4.16.1 94ef3776ad7bebfb5780dfc9632e04d20d5c9a6c
[2023-08-18T02:32:45.125Z] info  Using user-data-dir ~/.local/share/code-server
[2023-08-18T02:32:45.214Z] info  Using config file ~/.config/code-server/config.yaml
[2023-08-18T02:32:45.215Z] info  HTTP server listening on http://127.0.0.1:8080/
[2023-08-18T02:32:45.215Z] info    - Authentication is enabled
[2023-08-18T02:32:45.215Z] info      - Using password from ~/.config/code-server/config.yaml
[2023-08-18T02:32:45.215Z] info    - Not serving HTTPS
[2023-08-18T02:32:45.215Z] info  Session server listening on /home/csy/.local/share/code-server/code-server-ipc.sock
```

显示这个，说明运行成功了。



#### Syntax error near unexpected token 'newline' error while installing .deb packages offline [duplicate]


Whenever I try to install some .deb packages which I downloaded before (e.g. Atom, BP-tools etc.) I receive this error in Ubuntu 17.10:
```
./bp-tools_17.12_amd64_Xenial_free.deb 
./bp-tools_17.12_amd64_Xenial_free.deb: line 1: syntax error near
unexpected token `newline' ./bp-tools_17.12_amd64_Xenial_free.deb:
line 1: `!<arch>'
can anyone help, please?
```

```
Try installing the software with

dpkg --install <Package_Name>
Like in your case just cd into the directory and then type the above command like

dpkg --install libpng12-0_1.2.50-2+deb8u3_amd64.deb
```
