# [nginx与lua开发](https://www.cnblogs.com/crazymagic/articles/12267085.html)



### Lua及基础语法

Nginx与Lua环境

场景：用Nginx结合Lua实现代码的灰度发布

1、Lua

​    是一个简洁、轻量、可扩展的脚本语言

2、Nginx+Lua优势

​    充分的结合Nginx的并发处理epoll优势和Lua的轻量

​    实现简单的功能切高并发的场景。

Lua的基础语法

 变量

- a=[[alo123"]]
- a=‘alo\n123"’
- a=’\97lo\10\04923"’

布尔类型只有nil和false，数字0，空字符串(’ \0’)都是true

lua中的变量如果没有特殊说明，全是全局变量

while循环语句 和 for循环语句

```
`sum=0``num=1``while num<=100 do``  ``sum=sum+num``  ``num=num+1``end``print(``"sum="``,sum)``lua没有++或是+=这样的操作` `for``循环``sum=0``for` `i=1 100 do``  ``sum=sum+i``end`
```

if-else判断语句　　

```
`if` `age==40 and sex==``"male"` `then``    ``print(``"大于40男人"``)``elseif age>40 and sex~=``"female"` `then``    ``print(``"大于60非女人"``)``else``    ``local age=io.read()``    ``print(``"Your age is"``..age)   #字符串的拼接操作符``end`
```

教程 <https://www.runoob.com/lua/lua-tutorial.html>　　

## Nginx+Lua环境部署

   参考<https://blog.csdn.net/qq_38974634/article/details/81625075>

1、LuaJIT

```
`wget http:``//luajit.org/download/LuaJIT-2.0.2.tar.gz``tar -zxvf  LuaJIT-2.0.2.tar.gz``cd LuaJIT-2.0.2``make install PREFIX=/usr/local/LuaJIT` `/etc/profile 文件中加入环境变量``export LUAJIT_LIB=/usr/local/lib``export LUAJIT_INC=/usr/local/include/luajit-2.0`
```

2、ngx_devel_kit和lua-nginx-module　　

```
`cd /opt/download``wget https:``//github.com/simpl/ngx_devel_kit/archive/v0.3.0.tar.gz``wget https:``//github.com/openresty/lua-nginx-module/archive/v0.10.9rc7.tar.gz``分别解压,等待被添加安装`
```

3、重新编译Nginx　　



[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
下载nginx的源码包

cd /data
wget http://nginx.org/download/nginx-1.12.1.tar.gz
tar -zxvf nginx-1.12.1.tar.gz;cd nginx-1.12.1

安装依赖
 yum install openssl openssl-devel -y
 yum install zlib zlib-devel -y
 yum install pcre-devel –y

编译

./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie' --add-module=/data/ngx_devel_kit-0.3.0 --add-module=/data/lua-nginx-module-0.10.9rc7

make && make install

echo "/usr/local/lib" >> /etc/ld.so.conf

ldconfig
执行此 命令后,nginx -V 看下参数
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

#### 测试Lua

```
`# cd /etc/nginx/conf.d/default.conf 加入下面的location` `server {``    ``listen       80;``    ``server_name web01.fadewalk.com;` `    ``location /lua {``        ``set $test ``"hello,world"``;``        ``content_by_lua '``            ``ngx.header.content_type=``"text/plain"``            ``ngx.say(ngx.``var``.test)';` `    ``}` `}`
```

![img](https://img2018.cnblogs.com/i-beta/1256425/202002/1256425-20200205231821430-1675849364.png)

### Nginx调用lua模块指令

Nginx的可插拔模块化加载执行，共11个处理阶段

set_by_lua        设置nginx变量，可以实现复杂的赋值逻辑

set_by_lua_file

access_by_lua     请求访问阶段处理，用于访问控制

access_by_lua_file

content_by_lua    内容处理器，接收请求处理并输出响应

content_by_lua_file

ngx.var     nginx变量

ngx.req.get headers 获取请求头

ngx.req.get_uri_args 获取url请求参数

ngx.redirect    重定向

ngx.print    输出响应内容体

ngx.say 通ngx.print，但是会最后输出一个换行符

ngx.header 输出响应头

#### 灰度发布

- 按照一定的关系区别，分部分的代码进行上线，使代码的发布能平滑过渡上线。

- 用户的信息cookie等信息区别

- 根据用户的ip地址

dep.conf 配置

```
`server {``    ``listen       80;``    ``server_name  localhost;` `    ``#charset koi8-r;``    ``access_log  /``var``/log/nginx/log/host.access.log  main;``    ` `    ``location /hello {``        ``default_type ``'text/plain'``;``        ``content_by_lua ``'ngx.say("hello, lua")'``;``    ``}`` ` `    ``location /myip {``        ``default_type ``'text/plain'``;``        ``content_by_lua '``            ``clientIP = ngx.req.get_headers()[``"x_forwarded_for"``]``            ``ngx.say(``"IP:"``,clientIP)``            ``';``    ``}` `    ``location / {``        ``default_type ``"text/html"``;``        ``content_by_lua_file /opt/app/lua/dep.lua;``        ``#add_after_body "$http_x_forwarded_for";``    ``}` `    ``location @server{``        ``proxy_pass http:``//127.0.0.1:9090;``    ``}` `    ``location @server_test{``        ``proxy_pass http:``//127.0.0.1:8080;``    ``}` `    ``error_page   500 502 503 504 404  /50x.html;``    ``location = /50x.html {``        ``root   /usr/share/nginx/html;``    ``}``}`
```

dep.lua配置　　

```
`clientIP = ngx.req.get_headers()[``"X-Real-IP"``]``if` `clientIP == nil then``    ``clientIP = ngx.req.get_headers()[``"x_forwarded_for"``]``end``if` `clientIP == nil then``    ``clientIP = ngx.``var``.remote_addr``end``    ``local memcached = require ``"resty.memcached"``    ``local memc, err = memcached:new()``    ``if` `not memc then``        ``ngx.say(``"failed to instantiate memc: "``, err)``        ``return``    ``end``    ``local ok, err = memc:connect(``"127.0.0.1"``, 11211)``    ``if` `not ok then``        ``ngx.say(``"failed to connect: "``, err)``        ``return``    ``end``    ``local res, flags, err = memc:get(clientIP)``    ``ngx.say(``"value key: "``,res,clientIP)``    ``if` `err then``        ``ngx.say(``"failed to get clientIP "``, err)``        ``return``    ``end``    ``if`  `res == ``"1"` `then``        ``ngx.exec(``"@server_test"``)``        ``return``    ``end``    ``ngx.exec(``"@server"``)`
```

　　