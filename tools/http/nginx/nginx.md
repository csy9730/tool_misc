# [nginx 服务器重启命令，关闭](https://www.cnblogs.com/apexchu/p/4119252.html)


## misc





``` bash
# 启动nginx:
nginx -c /path/to/nginx.conf

nginx -s reload # 修改配置后重新加载生效

nginx -s reopen  # 重新打开日志文件
nginx -t -c /path/to/nginx.conf # 测试nginx配置文件是否正确
```

#### 关闭nginx
关闭nginx：
```
nginx -s stop  :快速停止nginx
nginx -s  quit  ：完整有序的停止nginx
```

#### 杀死nginx
杀死nginx 方式：
``` bash
ps -ef | grep nginx

kill -QUIT 主进程号     ：从容停止Nginx
kill -TERM 主进程号     ：快速停止Nginx
kill -9 nginx          ：强制停止Nginx

# 杀死全部的nginx进程
killall nginx 
```

### nginx.conf
/etc/nginx/nginx.conf

