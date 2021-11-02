# 为什么说 Prometheus 是足以取代 Zabbix 的监控神器？


[Kuberneteschina](https://www.zhihu.com/people/kuberneteschina)

致力于提供最权威的 Kubernetes 技术、案例与Meetup！

95 人赞同了该文章

> 作者：陈晓宇
> 来源：[dbaplus 社群](https://mp.weixin.qq.com/s/PrGM0kO9oyM2sJ3F7g0qNA)
> 校对：[Bot](https://mp.weixin.qq.com/s/rugFY_j0fojDfJ9fnqjDCQ)（才云）、[星空下的文仔](https://mp.weixin.qq.com/s/rugFY_j0fojDfJ9fnqjDCQ)（才云）

Kubernetes 自从 2012年开源以来便以不可阻挡之势成为容器领域调度和编排的领头羊。Kubernetes 是 Google Borg 系统的开源实现，于此对应，Prometheus 则是 Google BorgMon 的开源实现。

Prometheus 是由 SoundCloud 开发的开源监控报警系统和时序列数据库。从字面上理解，Prometheus 由两个部分组成，**一个是监控报警系统，另一个是自带的时序数据库（TSDB）**。

2016 年，由 Google 发起的 Linux 基金会旗下的云原生计算基金会（CNCF）将 Prometheus 纳入作为其第二大开源项目。Prometheus 在开源社区也十分活跃，在 GitHub 上拥有两万多 Star，并且系统每隔一两周就会有一个小版本的更新。

## **各种监控工具对比**

其实，在 Prometheus 之前，市面已经出现了很多的监控系统，如 Zabbix、Open-Falcon、Nagios 等。那么 Prometheus 和这些监控系统有啥异同呢？我们先简单回顾一下这些监控系统。

**Zabbix**

Zabbix 是由 Alexei Vladishev 开源的分布式监控系统，支持多种采集方式和采集客户端，同时支持 SNMP、IPMI、JMX、Telnet、SSH 等多种协议。它将采集到的数据存放到数据库中，然后对其进行分析整理，如果符合告警规则，则触发相应的告警。

Zabbix 核心组件主要是 Agent 和 Server。其中 **Agent 主要负责采集数据并通过主动或者被动的方式将采集数据发送到 Server/Proxy**。除此之外，为了扩展监控项，Agent 还支持执行自定义脚本。**Server 主要负责接收 Agent 发送的监控信息，并进行汇总存储、触发告警等**。

Zabbix Server 将收集的监控数据存储到 Zabbix Database 中。Zabbix Database 支持常用的关系型数据库，如 MySQL、PostgreSQL、Oracle 等（默认是 MySQL），并提供 Zabbix Web 页面（PHP 编写）数据查询。

由于使用了关系型数据存储时序数据，**Zabbix在监控大规模集群时常常在数据存储方面捉襟见肘**。所以从 4.2 版本后 Zabbix开始支持 TimescaleDB 时序数据库，不过目前成熟度还不高。

**Open-Falcon**

Open-Falcon 是小米开源的企业级监控工具，用 Go 语言开发而成。这是一款灵活、可扩展并且高性能的监控方案，包括小米、滴滴、美团等在内的互联网公司都在使用它。它的主要组件包括：

**Falcon-agent**：这是用 Go 语言开发的 Daemon 程序，运行在每台 Linux 服务器上，用于采集主机上的各种指标数据，主要包括 CPU、内存、磁盘、文件系统、内核参数、Socket 连接等，目前已经支持 200 多项监控指标。并且，Agent 支持用户自定义的监控脚本。

**Hearthbeat server**：简称 HBS 心跳服务。每个 Agent 都会周期性地通过 RPC 方式将自己的状态上报给 HBS，主要包括主机名、主机 IP、Agent 版本和插件版本，Agent 还会从 HBS 获取自己需要执行的采集任务和自定义插件。

**Transfer**：负责接收 Agent 发送的监控数据，并对数据进行整理，在过滤后通过一致性 Hash 算法发送到 Judge 或者 Graph。

**Graph**：这是基于 RRD 的数据上报、归档、存储组件。Graph 在收到数据以后，会以 rrdtool 的数据归档方式来存储，同时提供 RPC 方式的监控查询接口。

**Judge 告警模块**：Transfer 转发到 Judge 的数据会触发用户设定的告警规则，如果满足，则会触发邮件、微信或者回调接口。这里为了避免重复告警引入了 Redis 暂存告警，从而完成告警的合并和抑制。

**Dashboard**：这是面向用户的监控数据查询和告警配置界面。

**Nagios**

![img](https://pic4.zhimg.com/80/v2-9a5cfbaa3f70f4903f7efaaa802c7413_1440w.jpg)



Nagios 原名为 NetSaint，由 Ethan Galstad 开发并维护。Nagios 是一个老牌监控工具，由 C 语言编写而成，**主要针对主机监控**（CPU、内存、磁盘等）**和网络监控**（SMTP、POP3、HTTP 和 NNTP 等），**当然也支持用户自定义的监控脚本**。

它还支持一种更加通用和安全的采集方式：NREP（Nagios Remote Plugin Executor）。它会先在远端启动一个 NREP 守护进程，用于在远端主机上运行检测命令，在 Nagios 服务端用 check nrep 的 plugin 插件通过 SSL 对接到 NREP 守护进程执行相应的监控行为。相比 SSH 远程执行命令的方式，这种方式更加安全。**4Prometheus**

**![img](https://pic3.zhimg.com/80/v2-cd46b35a8881071db78ee39f2af58662_1440w.jpg)**

**Prometheus 的基本原理是通过 HTTP 周期性抓取被监控组件的状态**。任意组件只要提供对应的 HTTP 接口并且符合 Prometheus 定义的数据格式，就可以接入 Prometheus 监控。

Prometheus Server 负责定时在目标上抓取 metrics（指标）数据并保存到本地存储。它采用了一种 Pull（拉）的方式获取数据，不仅降低客户端的复杂度，客户端只需要采集数据，无需了解服务端情况，也让服务端可以更加方便地水平扩展。

如果监控数据达到告警阈值，Prometheus Server 会通过 HTTP 将告警发送到告警模块 alertmanger，通过告警的抑制后触发邮件或者 Webhook。Prometheus 支持 PromQL 提供多维度数据模型和灵活的查询，通过监控指标关联多个 tag 的方式，将监控数据进行任意维度的组合以及聚合。

**综合对比**

![img](https://pic1.zhimg.com/80/v2-d3105d39c3a01948dea97dbaefc56d64_1440w.jpg)

综合对比如上面的表格，**从开发语言上看，为了应对高并发和快速迭代的需求，监控系统的开发语言已经慢慢从 C 语言转移到 Go**。不得不说，Go 凭借简洁的语法和优雅的并发，在 Java 占据业务开发、C 占领底层开发的情况下，准确定位中间件开发需求，在当前开源中间件产品中被广泛应用。

**从系统成熟度上看**，Zabbix 和 Nagios 都是老牌的监控系统：Nagios 是在 1999 年出现的，Zabbix 是在 1998 年出现的，系统功能比较稳定，成熟度较高。而 Prometheus 和 Open-Falcon 都是最近几年才诞生的，虽然功能还在不断迭代更新，但站在巨人的肩膀之上，在架构设计上借鉴了很多老牌监控系统的经验。

**从系统扩展性方面看**，Zabbix 和 Open-Falcon 都可以自定义各种监控脚本，并且 Zabbix 不仅可以做到主动推送，还可以做到被动拉取。Prometheus 则定义了一套监控数据规范，并通过各种 exporter 扩展系统采集能力。

**从数据存储方面来看**，Zabbix 采用关系数据库保存，这极大限制了 Zabbix 的采集性能；Nagios 和 Open-Falcon 都采用 RDD 数据存储，Open-Falcon 还加入了一致性 hash 算法分片数据，并且可以对接到 OpenTSDB；而 Prometheus 则自研了一套高性能的时序数据库，在 V3 版本可以达到每秒千万级别的数据存储，通过对接第三方时序数据库扩展历史数据的存储。

**从配置复杂度上看**，Prometheus 只有一个核心 server 组件，一条命令便可以启动。相比而言，其他系统配置相对麻烦，尤其是 Open-Falcon。

**从社区活跃度上看**，目前 Zabbix 和 Nagios 的社区活跃度比较低，尤其是 Nagios；Open-Falcon 虽然也比较活跃，但基本都是国内公司在参与；**Prometheus 在这方面占据绝对优势**，社区活跃度最高，并且受到 CNCF 的支持，后期的发展值得期待。

**从容器支持角度看**，由于 Zabbix 和 Nagios 出现得比较早，当时容器还没有诞生，它们对容器的支持自然比较差；Open-Falcon 虽然提供了容器的监控，但支持力度有限；Prometheus 的动态发现机制，不仅可以支持 Swarm 原生集群，还支持 Kubernetes 容器集群的监控，是目前容器监控最好解决方案；Zabbix 在传统监控系统中，尤其是在服务器相关监控方面，占据绝对优势；而 Nagios 则在网络监控方面有广泛应用。伴随着容器的发展，Prometheus 已开始成为主导及容器监控方面的标配，并且在未来可见的时间内将被广泛应用。

总体来说，对比各种监控系统的优劣，Prometheus 可以说是目前监控领域最锋利的“瑞士军刀”了。

## **Prometheus 功能介绍**

下图是 Prometheus 的整体架构图。**左侧是各种数据源，主要是各种符合 Prometheus 数据格式的 exporter**。除此之外，为了支持推送数据的 Agent，你可以通过 Pushgateway 组件，将 Push 转化为 Pull。Prometheus 甚至可以从其它的 Prometheus 获取数据，这点在后面介绍联邦的时候详细解释。

![img](https://pic3.zhimg.com/80/v2-18bdf9a34987735754b917d76b55b976_1440w.jpg)

**图片的上侧是服务发现**。Prometheus 支持监控对象的自动发现机制，从而可以动态获取监控对象。虽然 Zabbix 和 Open-Falcon 也支持动态发现机制，但 Prometheus 的支持最完善。

**图片中间是核心：通过 Retrieval 模块定时拉取数据，通过 Storage 模块保存数据**。PromQL 是 Prometheus 提供的查询语法，PromQL 通过解析语法树，查询 Storage 模块获取监控数据。**图片右侧是告警和页面展现**，页面查看除了 Prometheus 自带的 WebUI，还可以通过 Grafana 等组件查询 Prometheus 监控数据。

Prometheus 指标格式分为两个部分：一是指标名称，另一个是指标标签。格式如下：

![img](https://pic3.zhimg.com/80/v2-0789f9b1aba942661a972f757705c8f2_1440w.jpg)

标签可体现指标的维度特征。例如，对于指标 http_request_total，可以有 {status="200", method="POST"} 和 {status="200", method="GET"} 这两个标签。在需要分别获取 GET 和 POST 返回 200 的请求时，可分别使用上述两种指标；在需要获取所有返回 200 的请求时，可以通过 http_request_total{status="200"} 完成数据的聚合，非常便捷和通用。Prometheus 指标类型有四种：

- **Counter（计数器）**：计数统计，累计多长或者累计多少次等。它的特点是只增不减，譬如 HTTP 访问总量；
- **Gauge（仪表盘）**：数据是一个瞬时值，如果当前内存用量，它随着时间变化忽高忽低；
- **Histogram（直方图）**：服务端分位，不同区间内样本的个数，譬如班级成绩，低于 60 分的 9 个，低于 70 分的 10 个，低于 80 分的 50 个。
- **Summary（摘要）**：客户端分位，直接在客户端通过分位情况，还是用班级成绩举例：0.8 分位的是，80 分，0.9 分位的是 85 分，0.99 分位的是 98 分。

*注：关于 Gauge：如果需要了解某个时间段内请求的响应时间，通常做法是使用平均响应时间，但这样做无法体现数据的长尾效应。例如，一个 HTTP 服务器的正常响应时间是 30ms，但有很少几次请求耗时 3s，通过平均响应时间很难甄别长尾效应，所以 Prometheus 引入了 Histogram 和 Summary。

![img](https://pic4.zhimg.com/80/v2-5a7dfcf445908a879245b011b3ad1317_1440w.jpg)

Prometheus 通过 HTTP 接口的方式从各种客户端获取数据，这些客户端必须符合 Prometheus 监控数据格式。通常它有两种方式，**一种是侵入式埋点监控**，通过在客户端引入Prometheus go client，提供 /metrics 接口查询 Kubernetes API 各种指标。**另一种是通过 exporter 方式**，在外部将原来各种中间件的监控支持转化为 Prometheus 的监控数据格式，如 Redis Exporter 将 Redis 指标转化为 Prometheus 能够识别的 HTTP 请求。**Prometheus 并没有采用 JSON 的数据格式，而是采用 text/plain 纯文本的方式 ，这是它的特殊之处**。HTTP 返回 Header 和 Body 如上图所示，指标前面两行 # 是注释，**标识指标的含义和类型**。指标和指标的值通过空格分割，开发者通常不需要自己拼接这种个数的数据， Prometheus 提供了各种语言的 SDK 支持。

![img](https://pic1.zhimg.com/80/v2-f39a7f33cb44901e7fc63b52ccaadce8_1440w.jpg)

Prometheus 为了支持各种中间件以及第三方的监控提供了 exporter，大家可以把它理解成监控适配器，**将不同指标类型和格式的数据统一转化为 Prometheus 能够识别的指标类型**。譬如 Node Exporter 主要通过读取 Linux 的 /proc 以及 /sys 目录下的系统文件获取操作系统运行状态，Redis Exporter 通过 Redis 命令行获取指标，MySQL Exporter 通过读取数据库监控表获取 MySQL 的性能数据。他们将这些异构的数据转化为标准的 Prometheus 格式，并提供 HTTP 查询接口。

![img](https://pic3.zhimg.com/80/v2-9939026166d1a6b65f9c182a457cf3ae_1440w.jpg)

Prometheus 提供了两种数据持久化方式：**一种是本地存储，通过 Prometheus 自带的 TSDB（时序数据库），将数据保存到本地磁盘**，为了性能考虑，建议使用 SSD。但本地存储的容量毕竟有限，建议不要保存超过一个月的数据。Prometheus 本地存储经过多年改进，自 Prometheus 2.0 后提供的 V3 版本，TSDB 的性能已经非常高，可以支持单机每秒 1000 万个指标的收集。**另一种是远端存储，适用于大量历史监控数据的存储和查询**。通过中间层的适配器的转化，Prometheus 将数据保存到远端存储。适配器实现 Prometheus 存储的 remote write 和 remote read 接口，并把数据转化为远端存储支持的数据格式。目前，远端存储主要包括 OpenTSDB、InfluxDB、Elasticsearch、M3db、Kafka 等，其中 M3db 是目前非常受欢迎的后端存储。

![img](https://pic1.zhimg.com/80/v2-2d857f91c4b1f71828935f7a6b2ba960_1440w.jpg)

和关系型数据库的 SQL 类似，Prometheus 也内置了数据查询语言 PromQL，它提供对时间序列数据丰富的查询，聚合以及逻辑运算的能力。一条 PromQL 主要包括指标名称、过滤器以及函数和参数。指标可以进行数据运算，包括 +（加）、-（减）、*（乘）、/（除）、%（求余）、^（幂运算），聚合函数包括 sum（求和）、min（最小值）、max（最大值）、avg（平均值）、stddev（标准差）、count（计数）、topk（前 n 条）、quantile（分布统计）等。查询数据通过 HTTP GET 请求发送 PromQL 查询语句。形式如下：

![img](https://pic2.zhimg.com/80/v2-58cda720a741a3188ea97e5ff14cff29_1440w.jpg)

其中 query 参数就是一条 PromQL 表达式。除此之外还支持范围查询 query_range，需要额外添加 start（起始时间）、end（结束时间）、step（查询步长）这三个参数。**无论是 Prometheus 自带的 WebUI 还是通过 Grafana，它们本质上都是通过 HTTP 发送 PromQL 的方式查询 Prometheus 数据**。整个解析流程如下所示：

![img](https://pic2.zhimg.com/80/v2-9ceec0f3c39189126ae3f647982e41e9_1440w.jpg)

当 Prometheus 接收请求后，通过 PromQL 引擎解析 PromQL，确定查询时间序列和查询时间范围，通过 TSDB 接口获取对应数据块，最后根据聚合函数处理监控数据并返回。

![img](https://pic4.zhimg.com/80/v2-d8ba81e26d1340885306a96d2f5a75cf_1440w.jpg)

**Prometheus 告警配置也是通过 YAML 文件配置，核心是上面的 expr 参数**（告警规则），和查询一样，这也是一个 PromQL 表达式。for 代表持续时间，如果在 for 时间内持续触发，Prometheus 才发出告警至 alertmanger。告警组件 alertmanger 地址是在 Prometheus 的配置文件中指定，告警经过 alertmanger 去重、抑制等操作，最后执行告警动作，目前支持邮件、Slack、微信和 Webhook，如果是对接钉钉，可以通过 Webhook 方式触发钉钉的客户端发送告警。

![img](https://pic4.zhimg.com/80/v2-bca720c5acde0b7eecfcb615ea5a17d3_1440w.jpg)

**Prometheus 配置监控对象有两种方式，一种是通过静态文件配置，另一种是动态发现机制，自动注册监控对象**。Prometheus 动态发现目前已经支持 K8s、etcd、Consul 等多种服务发现机制。动态发现机制可以减少运维人员手动配置，在容器运行环境中尤为重要：容器集群通常在几千甚至几万的规模，如果每个容器都需要单独配置监控项不仅需要大量工作量，而且容器经常变动，后续维护更是异常麻烦。针对 K8s 环境的动态发现，Prometheus 通过 watch Kubernetes API 动态获取当前集群所有服务和容器情况，从而动态调整监控对象。

![img](https://pic3.zhimg.com/80/v2-520318abd10c8876162faa85a685d6f2_1440w.jpg)

**为了扩展单个 Prometheus 的采集能力和存储能力，Prometheus 引入了“联邦”的概念**。多个 Prometheus 节点组成两层联邦结构，如图所示，上面一层是联邦节点，负责定时从下面的 Prometheus 节点获取数据并汇总，部署多个联邦节点是为了实现高可用。下层的 Prometheus 节点又分别负责不同区域的数据采集，在多机房的事件部署中，下层的每个 Prometheus 节点可以被部署到单独的一个机房，充当代理。**K8sMeetup**

## **总结**

最后我想表达，**Prometheus 也并非银弹**。

首先，Prometheus 只针对性能和可用性监控，并不具备日志监控等功能，**并不能通过 Prometheus 解决所有监控问题**。

其次，Prometheus 认为只有最近的监控数据才有查询的需要，所有 Prometheus 本地存储的设计初衷只是保持短期（一个月）的数据，**并非针对大量的历史数据的存储**。如果需要报表之类的历史数据，则建议使用 Prometheus 的远端存储，如 OpenTSDB、M3db 等。

Prometheus 还有一个小瑕疵是**没有定义单位**，这里需要使用者自己去区分或者事先定义好所有监控数据单位，避免数据缺少单位问题。

## **Q & A**

**Q1：Prometheus 能替代 Zabbix 吗？**

**A**：在我们的实际生产环境中，Prometheus 完全可以替代 Zabbix。并且由于我个人主要负责容器云的建设，我对 Prometheus 更加青睐。

**Q2：如何对 Prometheus 进行权限限制？类似于 Zabbix 的用户密码校验。A**：其实 Prometheus 本身没有任何的权限限制，因为作为一套监控系统，它认为这种权限的管理应该属于上面管理权限的系统去维护，而不应该在它这样一套监控系统里做，所以 Prometheus 本身在设计上就没有做任何的权限管理。**Q3：Prometheus 可以监控 Web 地址吗？类似于 Zabbix 的 Web 场景。**

**A**：Prometheus 结合 blockbox 可以去监控一些 Web 站点是不是健康，它会定时去调用一些你们提供的 Web 接口，然后通过分析接口返回码或者是返回体，判断 Web 服务是否健康，可以作为站点监控。除此之外它还支持 TCP、DNS、ICMP 以及 HTTPS。

**Q4：Prometheus 和 Ansible 有相同作用么？**

**A**：我理解的 Ansible 其实还是一种自动化运维工具，它虽然有一些简单监控，但是核心并不在监控上面，而是自动化部署和运维上的一些能力，而 Prometheus 本身只是一个单纯的监控和告警的组件。

**Q5：请对比下 InfluxDB 和 Prometheus，个人觉得 InfluxDB 易用性更好。**

**A**：InfluxDB 本身没有任何监控数据的能力，InfluxDB 的商业版本是集群的，可以存储大量的数据，但是开源版本是单机的，不建议使用。Prometheus 不但具有数据存储能力，还有数据指标采集能力，而单纯的 InfluxDB 只有数据存储能力。

**Q6：老师你们公司内部只用 Prometheus 做监控吗？还用其他产品配合吗？**

**A**：我们公司内部之前使用的是 Zabbix 监控，目前正在从 Zabbix 监控切换到 Prometheus 监控。

**Q7：哪种监控工具更适合做业务指标监控？**

**A**：我个人接触过的业务指标监控主要是通过 Graphite、Prometheus 以及 UAV 监控，通常的业务指标监控都是通过埋点完成，大同小异。

**Q8：Prometheus 监控 Oracle、MySQL 数据库方便吗？A**：现在由于各种 Prometheus export 非常丰富，针对这些中间件，如 Oracle、MySQL 这种监控是非常方便的，目前支持得也比较好。在我们自己的环境里面，我们通过 Kafka 的 export、MySQL 的 export、Redis 的 export 分别去监控我们自己的组件状态，如果你有一些自己定制的监控指标，也可以去定制一些 export，这些东西都比较简单，并不是很困难。**Q9：Prometheus 用什么存储比较好？本地存储容量有限。**

**A**：在我们实际生产环境中，本地存储只保留一个月数据，历史数据都放到 M3db 中保存。

**Q10：我目前监控一种类型的对象，就需要一个 exporter，对象越多 exporter 的量也不断增长，怎么解决？**

**A**：大部分监控对象都需要特定类型 exporter，因为每种类型的监控指标的数据格式不一样，都要特定的 exporter 去解析这种指标，并且转换为 Prometheus 识别的指标类型。至于说 exporter 的量非常多，exporter 本身是很轻量级的，虽然多，但是在我们自己部署的环境里面，有的时候就和我们的应用捆绑到一个 Pod 去部署，其实非常方便维护，本身也不会有什么负载压力。exporter 本身很稳定，维护起来也非常简单。

**Q11：非容器化部署的中间件也能监控吗？**

**A**：其实 Prometheus 采集数据的时候，只看采集数据的监控格式是否满足它的需求，它本身并不关心被监控对象是不是在容器里面，没有任何关系。只要对外暴露的监控数据格式符合 Prometheus 的要求就可以。

**Q12：Prometheus 能把时序数据实时发送到 Kafka 吗？**

**A**：可以的，目前社区已经有一个 Kafka 的 exporter，可以把监控数据写到 Kafka 里。

**Q13：Prometheus 除了联邦集群的方式，是否存在心跳或者类似集群化的部署？**

**A**：Improbable 开源的 Thanos 提供了 Prometheus 集群化能力，感兴趣的朋友可以深入了解一下。

**Q14：Prometheus 配置网络设备时，有什么简易方式吗？设备类型跟 OID 有一定差异的情况下，有什么简易方式？**

**A**：Prometheus 通过 SNMP exporter 监控网络设备时，OID 也需要单独配置，目前没有啥好办法。

**Q15：如何更好地阅读 Prometheus 的源码？Prometheus 的源码质量如何？**

**A**：Prometheus 代码包结构清晰，学习 Go 语言的朋友可以深度读一遍。建议首先看数据采集和 PromQL 解析，最后看 TSDB。

**Q16：Prometheus 未来会向哪个方向发展？**

**A**：Prometheus 目前正在慢慢成为基于 HTTP 监控的规范，目前在容器领域和 Kubernetes 一起，已经确定了领导地位，越来越多的中间件也开始原生支持 Prometheus 监控。Prometheus 3.x 即将发布，主要增强集群能力、数据存储能力以及安全性。

## **作者简介**

**陈晓宇**

宜信容器云架构师

- 负责宜信 PaaS 平台的设计和推广，帮助企业从传统应用迁移至云原生；
- 在云计算相关行业具有丰富的研发与架构经验，参与多个社区开源项目，如 Openstack、Kubernetes、Harbor 等；
- 曾参与编写《深入浅出 Prometheus》一书。

编辑于 2019-11-11

[IT 运维](https://www.zhihu.com/topic/19590394)

[Zabbix](https://www.zhihu.com/topic/19674013)

[运维](https://www.zhihu.com/topic/19560830)