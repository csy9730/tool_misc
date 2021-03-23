# Filebeat + Redis 管理 LOG日志实践

> **引用 转载 请注明出处**

```
某早上，领导怒吼声远远传来，空空的办公区放大吼声的“狰狞”程度。“xxxxxx ... ...重量级的日志管理工具不能用，xxxx不代表要自己造轮子。拥抱开源不只是口号，xxxx 要行动啊。... ...”
```

伴着少儿不宜哔哔哔声音，我开启了探索轻量级开源日志管理工具航程。Filebeat等一干开源日志管理软件进入我的视野。所有说：别人的愤怒时刻，也许是你发现新大陆开端。

[之前提到的开源日志管理工具对比文章](https://www.jianshu.com/p/caec22625a09)，本文适用于轻量级应用的日志管理。准确点说：如何使用Filebeat将java服务生成log采集到redis服务里。

#### Filebeat简介

`Filebeat`是elastic公司*Beats平台*系列产品中的一个日志采集、入库、路由工具。官方提供功能列表：



![img](https://upload-images.jianshu.io/upload_images/1655206-ded484272c0f801f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1005/format/webp)

Filebeat introduction

简言之，Filebeat`简化日志采集流程`，`完美接入数据库`，`轻量级的开源产品`。**轻量级**符合我们期望，**支持redis库**兼容我们当前服务，因此是我们的选择。

本文是一篇教程，分为三部分：安装、配置、运行。我们以这个顺序进行介绍。**注**：*因实施场景原因，Filebeat参数只涉及一部分。*

#### 关于版本说明

> 软件版本号：
>
> 1. Filebeat 6.5 (发布版)
> 2. Linux x86_64 x86_64 GNU/Linux(os版本)
> 3. redis_version: 5.0.0 (redis使用单节点模式，对可用性要求高要采用集群或sentinel模式)

#### 如何安装

Filebeat可安装在主流的OS上，也支持docker、k8s方式进行部署，是典型的“麻雀虽小五脏俱全”的工具。

[下载传送门](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.elastic.co%2Fdownloads%2Fbeats%2Ffilebeat)

linux下安装包是`gz`的压缩包。解压即安装：

> ```
> tar xzvf filebeat-5.1.1-darwin-x86_64.tar.gz
> ```



![img](https://upload-images.jianshu.io/upload_images/1655206-e566c2f9a89a7350.png?imageMogr2/auto-orient/strip|imageView2/2/w/336/format/webp)

安装目录一览

让我们分别介绍目录的功能：

- `data` 存储Filebeat实例的uuid号，以及日志读取历史记录。
- `kibana` 接入kibana时，其提供可视化配置功能
- `logs` Filebeat 运行日志
- `module` `module.d` 配置参数:用于快速启动功能
- `fields.yml` Filebeat提供针对不同组件，采集的参数名称 类型等
- `filebeat` 可执行文件
- `filebeat.reference.yml` Filebeat支持的参数手册，所有支持配置参数都在这
- `filebeat.yml` 启动Filebeat需要配置文件。后面我们会重点解析

#### 如何配置

下面描述如何怎样配置，以及配置什么的问题。

1. Filebeat如何配置?
   它提供三种配置方式：

   - Kibana 。它提供Filebeat参数配置界面。和其它管理功能。只是需要引入Kibana组件。
   - Filebeat提供默认配置模块，调用命令可以完成配置
   - 按需手动配置文件 `filebeat.yml`。程序猿喜欢的姿势,也是我们认知软件必经之路。我们以这种方式开始。

2. Filebeat配置哪些参数？

   A.我们先说运行必须的、最小配置参数：

   - 配置输入数据类型(log-back生成的log)

```bash
filebeat.inputs:
        - type: log     #采集的数据格式 log
        enabled: true  #激活log采集功能
        paths: #采集路径
        - /var/log/*.log
        - /var/path2/*.log
```

**注： 配置文件格式是yaml语言写成，一种置标语言类似json**

- 配置输出数据参数

```bash
output.redis:
         hosts: ["localhost"] #单机版 redis
         port： 6379  #port
         password: "my_password" #用户名和密码
         key: "filebeat" # filebeat是数据的key
         db: 0 #数据写入的库
```

**以上配置实现日志导入Redis的基本配置了**。Filebeat又有哪些特殊参数？如何实现特色的需求哪？这些在其它配置中一一说明。

B. 其它配置说明

Filebeat输出数据的格式是**json**。类似这样：

> {
> "@timestamp": "2018-12-18T08:33:01.604Z", #采集时间 UTC
> "@metadata": {....}, #描述beat的信息
> "message": "日志内容", ### 数据主体
> "source": "/var/log/run.log", #数据来源
> "prospector": { "type": "log"},
> "input": {"type": "log" }, #数据类型
> "beat": {.... },
> "host": {.... }, #系统信息 ip 系统版本 名称等
> "offset": 244 #偏移
> }

输出数据格式除包含数据主体`message`外，还包括部分附加信息。对于不需要信息，如何进行过滤和转换哪？这涉及Filebeat不算强大的数据过滤功能。

- Filebeat数据过滤

  - 过滤内容

    ```bash
    exclude_lines: ['^INFO']　#exclude_lines关键字排除包含内容INFO
     include_lines: ['^ERR', '^WARN']
     exclude_files: ['.gz/pre>] #排查压缩文件
     multiline.pattern: ^\[ #内容拼接，用户异常堆栈输出多行 拼接成一条
     过滤内容和内容拼接，需要日志的格式是json,否则不生效
    ```

- 过滤json中输出字段

Filebeat提供类似管道功能的处理器(processors)，来指定生成字段,如下形式。

```rust
event -> filter1 -> event1 -> filter2 ->event2 ...
```

每次数据采集是一个事件，每个filter是一个处理器。让我们自己定义一个处理器，如下：

```csharp
processors:
            - drop_fields:
            when:
            has_fields:  ['source']
            fields: ["input_type"]
```

功能：过滤器功能删除字段(drop_fields)，条件是当存在source字段时，删除input_type字段。

更多Filebeat处理器和过滤器:[链接](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.elastic.co%2Fguide%2Fen%2Fbeats%2Ffilebeat%2Fcurrent%2Fdefining-processors.html)

- 新增字段和列

```bash
fields: #字段的类型可以是不同类型或者 list，也可以自定义
             level: debug
             review: 1
             selfDefine: xxxxx
```

官方文档提示fields 可以用来过滤 json文件，但我*尝试没有成功*。

- Redis Key 如何设计

Filebeat提供有限度自定义redis key的功能。如果输入数据是json格式,可以提取Json的字段作为redis的key。我们的key的定义是数据入库时间。配置如下：

```key
            when.contains: 
            message: "INFO"
            key: "debug_list"  # send to debug_list if `message` field contains DEBUG
```

*令人遗憾是*：时间不是北京时间，而是UTC时间。即不支持修改，且时间输出有错误。

- 日志文件扫描参数

```bash
max_bytes: 10485760  #10M 缓存层，一次采集数据超出10M 数据会丢弃
   harvester_buffer_size: 16384 #收割器大小
   scan_frequency: 10s #文件扫描频率
   harvester_limit: 0 #采集器数量， 0 表示无限制
   close_inactive: 5m #5m 无活动，关闭采集器
```

使用配置过程也表明：Filebeat易于配置和使用、过滤和转换功能稍显单一的组件。和logstash相比，各有侧重，但对于大多数采集层而言已然够用。

#### 如何启动

> ./filebeat -e #简单到让人发指启动命令

#### 后记和求助

Filebeat+ redis实践过程完毕，我们发现作为配置非常简单。甚至不需要关注输入段内容、以及输出端的redis，这才是中间件应有的样子。

**Filebeat不足输出端支持的数据库太少**，社区也没有计划支持更多的数据库。

最近在看golang，萌生了写一个输出到postgres插件的想法。
**如果开发输出到postgres插件，有什么思路，希望各位看官指点一二。感激不尽。。**