# nginx deployment

Nginx安装结束后，yum默认安装位置在/etc/nginx中。配置文件位于：/etc/nginx/nginx.conf，可以修改处理器数量、日志路径、pid文件路径等，默认的日志。

- 错误日志 /var/log/nginx/error.log
- 访问日志 /var/log/nginx/access.log
- /usr/share/nginx/nginx.conf

### config

``` lua
worker_processes 2;

events {
    worker_connections 1024;
}
http {
    # include     mime.types;
    default_type application/octet-stream;
    keepalive_timeout 65;
    sendfile    on;
    server {
        listen    8088;
        server_name localhost;
        location / {
            root /root/Project/mylib/tool_misc;
            index index.html index.htm;
        }
    }
}
```

### 服务管理

``` bash
/usr/local/nginx/sbin/nginx -s reload            # 重新载入配置文件
/usr/local/nginx/sbin/nginx -s stop              # 停止 Nginx
nginx -t                    # 检查配置文件书写是否正确

netstat -tunpl | grep 80
ps -ef | grep nginx

pkill nginx # 杀死服务
nginx -s reload # 重新加载配置文件
```


``` bash
# 查看进程和对应用户
➜  _build git:(dev) ✗ ps -aux | grep nginx           
root     11462  0.0  0.1  39316  1892 ?        Ss   23:33   0:00 nginx: master process nginx -c nginx.conf
nginx    11713  0.0  0.1  39784  2060 ?        S    23:37   0:00 nginx: worker process
nginx    11714  0.0  0.1  39784  2060 ?        S    23:37   0:00 nginx: worker process
```

## misc
### 403 forbidden
```
tool_misc git:(dev) ✗ curl localhost:8088/index.html
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.20.1</center>
</body>
```

需要配置用户
- 使用root用户，虽然方便，但是有风险
- 使用nginx受限用户，虽然不方便，但是安全

推荐使用nginx用户。

1. 创建nginx用户：`useradd nginx` 
2. 使用nginx用户，
    - 需要把html目录拷贝到/var/lib/nginx目录下。
    - 通过chmod更改权限，chown更改所有权用户。
4. 更改配置nginx
5. 重启nginx服务

### 图片缺失
nginx 可以访问，但是图片缺失
这种情况是没有开启mime，需要开启mime支持。

``` lua
http {
    include      /etc/nginx/mime.types;
}
```