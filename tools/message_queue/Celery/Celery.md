# Celery

Celery是Python开发的分布式任务调度模块，今天抽空看了一下，果然接口简单，开发容易，5分钟就写出了一个异步发送邮件的服务。

Celery本身不含消息服务，它使用第三方消息服务来传递任务，目前，Celery支持的消息服务有RabbitMQ、Redis甚至是数据库，当然Redis应该是最佳选择。

### 安装Celery

用pip或easy_install安装：

```
$ sudo pip install Celery
```

或着：

```
$ sudo easy_install Celery
```

使用Redis作为Broker时，再安装一个celery-with-redis。

开始编写tasks.py：

``` python
# tasks.py
import time
from celery import Celery

celery = Celery('tasks', broker='redis://localhost:6379/0')

@celery.task
def sendmail(mail):
    print('sending mail to %s...' % mail['to'])
    time.sleep(2.0)
    print('mail sent.')
```

然后启动Celery处理任务：

```
$ celery -A tasks worker --loglevel=info
```

上面的命令行实际上启动的是Worker，如果要放到后台运行，可以扔给supervisor。

如何发送任务？非常简单：

```
>>> from tasks import sendmail
>>> sendmail.delay(dict(to='celery@python.org'))
<AsyncResult: 1a0a9262-7858-4192-9981-b7bf0ea7483b>
```

可以看到，Celery的API设计真的非常简单。

然后，在Worker里就可以看到任务处理的消息：

```
[2013-08-27 19:20:23,363: WARNING/MainProcess] celery@MichaeliMac.local ready.
[2013-08-27 19:20:23,367: INFO/MainProcess] consumer: Connected to redis://localhost:6379/0.
[2013-08-27 19:20:45,618: INFO/MainProcess] Got task from broker: tasks.sendmail[1a0a9262-7858-4192-9981-b7bf0ea7483b]
[2013-08-27 19:20:45,655: WARNING/PoolWorker-4] sending mail to celery@python.org...
[2013-08-27 19:20:47,657: WARNING/PoolWorker-4] mail sent.
[2013-08-27 19:20:47,658: INFO/MainProcess] Task tasks.sendmail[1a0a9262-7858-4192-9981-b7bf0ea7483b] succeeded in 2.00266814232s: None
```

Celery默认设置就能满足基本要求。Worker以Pool模式启动，默认大小为CPU核心数量，缺省序列化机制是pickle，但可以指定为json。由于Python调用UNIX/Linux程序实在太容易，所以，用Celery作为异步任务框架非常合适。

Celery还有一些高级用法，比如把多个任务组合成一个原子任务等，还有一个完善的监控接口，以后有空再继续研究。