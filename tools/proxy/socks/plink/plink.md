# plink
putty是windows下开源的ssh工具，附带plink工具快速地建立socks服务器

windows的配置方法：
1. 要有putty（含plink）
2. 在命令行下执行命令, 相当于开启远程转发到本地的1080端口 `plink.exe -C -N -D 127.0.0.1:1080 user@host  -pw password `
3. 配置本地的Firefox

- SOCKS主机：127.0.0.1
- 端口：1080
- 选择 SOCKS v5
- 复选 远程DNS


如果是在内网（ssh连接需要通过代理），那么可以在putty中配置好一个session，该session下设置好代理
在上面第2步的命令行中，将host改成putty中配置的session name就可以了
