# linux中Jenkins启动/重启/停止命令


简要记录一下Linux 中Jenkins启动/重启/停止命令

``` bash
# 启动
service jenkins start

# 重启
service jenkins restart

# 停止
service jenkins stop
```
此外，还有直接使用url的方式，不过当然不包括启动（此时服务还未启动）,只需要在访问jenkins服务器的网址url地址就可以了
此处假定 jenkins部署在本机，端口为 8080

```
# 浏览器进入Jenkins，登录
http://localhost:8080/

# 关闭Jenkins
http://localhost:8080/exit 

# 重启Jenkies
http://localhost:8080/restart 

# 重新加载配置信息
http://localhost:8080/reload 
```