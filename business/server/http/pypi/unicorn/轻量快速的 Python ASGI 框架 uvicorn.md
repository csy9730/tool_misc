# 轻量快速的 Python ASGI 框架 uvicorn

![img](https://upload.jianshu.io/users/upload_avatars/14270006/035d532e-68ab-4b86-9701-f9bae3b0b6cf.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[羋虹光](https://www.jianshu.com/u/7e4039d5a162)关注

2020.08.17 15:08:32字数 1,360阅读 6,108

### 什么是 Uvicorn ？

> **答：Uvicorn 是基于 uvloop 和 httptools 构建的非常快速的 ASGI 服务器。**

### 什么是 uvloop 和 httptools ？

> **答： uvloop 用于替换标准库 asyncio 中的事件循环，使用 Cython 实现，它非常快，可以使 asyncio 的速度提高 2-4 倍。asyncio 不用我介绍吧，写异步代码离不开它。**

> **httptools 是 nodejs HTTP 解析器的 Python 实现。**

### 什么是 ASGI 服务器？

> **答： 异步网关协议接口，一个介于网络协议服务和 Python 应用之间的标准接口，能够处理多种通用的协议类型，包括 HTTP，HTTP2 和 WebSocket。**

### 请简单介绍下 Uvicorn

> **答：目前，Python 仍缺乏异步的网关协议接口，ASGI 的出现填补了这一空白，现在开始，我们能够使用共同的标准为所有的异步框架来实现一些工具，ASGI 帮助 Python 在 Web 框架上和 Node.JS 及 Golang 相竟争，目标是获得高性能的 IO 密集型任务，ASGI 支持 HTTP2 和 WebSockets，WSGI 是不支持的。**

> **Uvicorn 目前支持 HTTP1.1 和 WebSocket，计划支持 HTTP2。**

## 使用方法：

```ruby
$ pip install uvicorn
```

##### 创建一个文件 example.py

```python
async def app(scope, receive, send):
    assert scope['type'] == 'http'
    await send({
        'type': 'http.response.start',
        'status': 200,
        'headers': [
            [b'content-type', b'text/plain'],
        ]
    })
    await send({
        'type': 'http.response.body',
        'body': b'Hello, world!',
    })
```

##### 启动 Uvicorn

```ruby
$ uvicorn example:app
```

##### 你也可以不使用命令行，直接运行你的脚本也是可以的，如下：

```python
import uvicorn

async def app(scope, receive, send):
    ...

if __name__ == "__main__":
    uvicorn.run("example:app", host="127.0.0.1", port=5000, log_level="info")
```

------

------

------

## FastAPI使用uvicorn

```python
import uvicorn
from fastapi import FastAPI
 
app = FastAPI()
 
@app.get("/")
async def root():
    return {"message": "Hello World"}
 
if __name__ == '__main__':
    uvicorn.run(app=app)
```

##### 深入到`uvicorn.run()`方法里面，看到一个：

```python
def run(app, **kwargs):
    config = Config(app, **kwargs)
    server = Server(config=config)
 
    if (config.reload or config.workers > 1) and not isinstance(app, str):
        logger = logging.getLogger("uvicorn.error")
        logger.warn(
            "You must pass the application as an import string to enable 'reload' or 'workers'."
        )
        sys.exit(1)
 
    if config.should_reload:
        sock = config.bind_socket()
        supervisor = StatReload(config, target=server.run, sockets=[sock])
        supervisor.run()
    elif config.workers > 1:
        sock = config.bind_socket()
        supervisor = Multiprocess(config, target=server.run, sockets=[sock])
        supervisor.run()
    else:
        server.run()
```

##### 再深入到 config = Config(app, **kwargs)里面，就看到一些很多的相关的配置信息项：

```kotlin
class Config:
    def __init__(
        self,
        app,
        host="127.0.0.1",
        port=8000,
        uds=None,
        fd=None,
        loop="auto",
        http="auto",
        ws="auto",
        lifespan="auto",
        env_file=None,
        log_config=LOGGING_CONFIG,
        log_level=None,
        access_log=True,
        use_colors=None,
        interface="auto",
        debug=False,
        reload=False,
        reload_dirs=None,
        workers=None,
        proxy_headers=True,
        forwarded_allow_ips=None,
        root_path="",
        limit_concurrency=None,
        limit_max_requests=None,
        backlog=2048,
        timeout_keep_alive=5,
        timeout_notify=30,
        callback_notify=None,
        ssl_keyfile=None,
        ssl_certfile=None,
        ssl_version=SSL_PROTOCOL_VERSION,
        ssl_cert_reqs=ssl.CERT_NONE,
        ssl_ca_certs=None,
        ssl_ciphers="TLSv1",
        headers=None,
    ):
....
```

##### 所以还可以添加的参数可以看上面的几个配置的选项的信息来填：

##### 于是乎还可以修改为：

```php
uvicorn.run(app=app, host="127.0.0.1", port=8000, reload=True, debug=True)
```

##### 发现本来想热更新代码，结果呐？有告警信息提示：

```python
WARNING:  You must pass the application as an import string to enable 'reload' or 'workers'.
```

##### 翻译过来就是说： 警告：必须将应用程序作为导入字符串传递，才能启用“重新加载” 然后呢： 我修改为：

```php
  uvicorn.run(app='app', host="127.0.0.1", port=8000, reload=True, debug=True)
```

##### 又提示：

```tsx
ERROR:    Error loading ASGI app. Import string "app" must be in format "<module>:<attribute>".
```

##### 好吧，我再看看官方文档说是：

##### 在命令行下是需要：模块加app名称：刚好上面的错误提示也是说需要:

```php
    uvicorn.run(app='main:app', host="127.0.0.1", port=8000, reload=True, debug=True)
```

##### 这样之后就可以启动热更新重启服务了！

## 使用命令行时，你可以使用 uvicorn --help 来获取帮助。

```ruby
Usage: uvicorn [OPTIONS] APP

Options:
  --host TEXT                     Bind socket to this host.  [default:
                                  127.0.0.1]
  --port INTEGER                  Bind socket to this port.  [default: 8000]
  --uds TEXT                      Bind to a UNIX domain socket.
  --fd INTEGER                    Bind to socket from this file descriptor.
  --reload                        Enable auto-reload.
  --reload-dir TEXT               Set reload directories explicitly, instead
                                  of using the current working directory.
  --workers INTEGER               Number of worker processes. Defaults to the
                                  $WEB_CONCURRENCY environment variable if
                                  available. Not valid with --reload.
  --loop [auto|asyncio|uvloop|iocp]
                                  Event loop implementation.  [default: auto]
  --http [auto|h11|httptools]     HTTP protocol implementation.  [default:
                                  auto]
  --ws [auto|none|websockets|wsproto]
                                  WebSocket protocol implementation.
                                  [default: auto]
  --lifespan [auto|on|off]        Lifespan implementation.  [default: auto]
  --interface [auto|asgi3|asgi2|wsgi]
                                  Select ASGI3, ASGI2, or WSGI as the
                                  application interface.  [default: auto]
  --env-file PATH                 Environment configuration file.
  --log-config PATH               Logging configuration file.
  --log-level [critical|error|warning|info|debug|trace]
                                  Log level. [default: info]
  --access-log / --no-access-log  Enable/Disable access log.
  --use-colors / --no-use-colors  Enable/Disable colorized logging.
  --proxy-headers / --no-proxy-headers
                                  Enable/Disable X-Forwarded-Proto,
                                  X-Forwarded-For, X-Forwarded-Port to
                                  populate remote address info.
  --forwarded-allow-ips TEXT      Comma separated list of IPs to trust with
                                  proxy headers. Defaults to the
                                  $FORWARDED_ALLOW_IPS environment variable if
                                  available, or '127.0.0.1'.
  --root-path TEXT                Set the ASGI 'root_path' for applications
                                  submounted below a given URL path.
  --limit-concurrency INTEGER     Maximum number of concurrent connections or
                                  tasks to allow, before issuing HTTP 503
                                  responses.
  --backlog INTEGER               Maximum number of connections to hold in
                                  backlog
  --limit-max-requests INTEGER    Maximum number of requests to service before
                                  terminating the process.
  --timeout-keep-alive INTEGER    Close Keep-Alive connections if no new data
                                  is received within this timeout.  [default:
                                  5]
  --ssl-keyfile TEXT              SSL key file
  --ssl-certfile TEXT             SSL certificate file
  --ssl-version INTEGER           SSL version to use (see stdlib ssl module's)
                                  [default: 2]
  --ssl-cert-reqs INTEGER         Whether client certificate is required (see
                                  stdlib ssl module's)  [default: 0]
  --ssl-ca-certs TEXT             CA certificates file
  --ssl-ciphers TEXT              Ciphers to use (see stdlib ssl module's)
                                  [default: TLSv1]
  --header TEXT                   Specify custom default HTTP response headers
                                  as a Name:Value pair
  --help                          Show this message and exit.
```

## 使用进程管理器

**使用进程管理器确保你以弹性方式运行运行多个进程，你可以执行服务器升级而不会丢弃客户端的请求。**

**一个进程管理器将会处理套接字设置，启动多个服务器进程，监控进程活动，监听进程重启、关闭等信号。**

**Uvicorn 提供一个轻量级的方法来运行多个工作进程，比如 --workers 4，但并没有提供进行的监控。**

### 使用 Gunicorn

**Gunicorn 是成熟的，功能齐全的服务器，Uvicorn 内部包含有 Guicorn 的 workers 类，允许你运行 ASGI 应用程序，这些 workers 继承了所有 Uvicorn 高性能的特点，并且给你使用 Guicorn 来进行进程管理。**

**这样的话，你可能动态增加或减少进程数量，平滑地重启工作进程，或者升级服务器而无需停机。**

**在生产环境中，Guicorn 大概是最简单的方式来管理 Uvicorn 了，生产环境部署我们推荐使用 Guicorn 和 Uvicorn 的 worker 类：**

```python
gunicorn example:app -w 4 -k uvicorn.workers.UvicornWorker
```

**执行上述命令将开户 4 个工作进程，其中 UvicornWorker 的实现使用 uvloop 和httptools 实现。在 PyPy 下运行，你可以使用纯 Python 实现，可以通过使用UvicornH11Worker 类来做到这一点。**

```css
gunicorn -w 4 -k uvicorn.workers.UvicornH11Worker
```

**Gunicorn 为 Uvicorn 提供了不同的配置选项集，但是一些配置暂不支持，如--limit-concurrency 。**

## 使用 Supervisor

**要supervisor用作流程管理器，您应该：**

> **使用其文件描述符将套接字移交给uvicorn，supervisor始终将其用作0，并且必须在本fcgi-program节中进行设置。**

> **或为每个uvicorn进程使用UNIX域套接字。**

**一个简单的主管配置可能看起来像这样： administratord.conf：**

```csharp
[supervisord]

[fcgi-program:uvicorn]
socket=tcp://localhost:8000
command=venv/bin/uvicorn --fd 0 example:App
numprocs=4
process_name=uvicorn-%(process_num)d
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
```

##### 然后运行`supervisord -n`。

## 使用 Circus

**要circus用作流程管理器，您应该：**

> **使用其文件描述符将套接字移交给uvicorn，马戏团可将其用作$(circus.sockets.web)。**
> **或为每个uvicorn进程使用UNIX域套接字。**

**使用 Circus 与 Supervisor 很类似。配置文件 circus.ini 如下：**

```csharp
[watcher:web]
cmd = venv/bin/uvicorn --fd $(circus.sockets.web) example:App
use_sockets = True
numprocesses = 4

[socket:web]
host = 0.0.0.0
port = 8000
```

**然后运行circusd circus.ini。**

## 与 Nginx 部署

**Nginx 作为 Uvicorn 进程的代理并不是必须的，你可以使用 Nginx 做为负载均衡。推荐使用 Nginx 时配置请求头，如 X-Forwarded-For,X-Forwarded-Proto，以便 Uvicorn 识别出真正的客户端信息，如 IP 地址，scheme 等。这里有一个配置文件的样例：**

```php
http {
  server {
    listen 80;
    client_max_body_size 4G;

    server_name example.com;

    location / {
      proxy_set_header Host $http_host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_redirect off;
      proxy_buffering off;
      proxy_pass http://uvicorn;
    }

    location /static {
      # path for static files
      root /path/to/app/static;
    }
  }

  upstream uvicorn {
    server unix:/tmp/uvicorn.sock;
  }

}
```

## 使用 HTTPS

**要使用https运行uvicorn，需要证书和私钥。推荐的获取方法是使用Let's Encrypt。**

**对于使用https进行本地开发，可以使用mkcert 生成有效的证书和私钥。**

```ruby
$ uvicorn example:app --port 5000 --ssl-keyfile=./key.pem --ssl-certfile=./cert.pem
```

## 使用 Gunicorn 也可以直接使用证书。

**也可以与uvicorn的工人一起使用证书来获取gunicorn**

```ruby
$ gunicorn --keyfile=./key.pem --certfile=./cert.pem -k uvicorn.workers.UvicornWorker example:app
```

### [学习来源1](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.uvicorn.org%2F)

### [学习来源2](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.uvicorn.org%2Fdeployment%2F)

### [学习来源3](https://links.jianshu.com/go?to=http%3A%2F%2Fwww.zyiz.net%2Ftech%2Fdetail-119883.html)