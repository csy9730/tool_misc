# gogs


## install



## arch
### file arch


- gogs/custom/conf
- gogs/custom/https/
- gogs/log
- gogs/data
- gogs/gogs.exe


### 使用https

首先生成证书，可以使用 `gogs cert --host my_host.com`
将会生产 cert.pem, key.pem 两个文件。

然后在gogs文件夹目录下新建一个custom文件夹，用来存放配置文件和https证书

https文件夹下放你申请到的证书文件（一般有两个，一个是crt和key


修改custom/conf/app.ini文件的配置：
``` ini
[server]
DOMAIN           = my_host.com
HTTP_PORT        = 3000
PROTOCOL         = https
# ROOT_URL         = https://my_host.com:3000/
CERT_FILE        = custom/https/my_host.com.crt
KEY_FILE         = custom/https/my_host.com.key
```

## misc
### faq
#### cert.pem

```
2023/03/21 02:51:10 [ INFO] Listen on https://0.0.0.0:3000
2023/03/21 02:51:10 [FATAL] [gogs.io/gogs/internal/cmd/web.go:769 runWeb()] Failed to start server: open custom/https/cert.pem: no such file or directory
```
确保证书文件存在。

#### git ssl
让git忽略ssl证书错误
```
git config --global http.sslVerify false
```
#### gogs user name
```
admin@DS918Plus:~/Project/111/2022/0818$ git pull
Gogs: Internal error
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

避免使用敏感的保留字作为用户名，例如lib.

