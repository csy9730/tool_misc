# StackStorm: 什么是 StackStorm ?

[![Alick](https://pic1.zhimg.com/v2-dbef45c87efefb08aaa189cda1c490af_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/Alick.Li)

[Alick](https://www.zhihu.com/people/Alick.Li)



NTT Training Instructor



6 人赞同了该文章

这篇文章是StackStorm 的中文入门教程，希望这篇文章能让大家获取到新的知识。

## 什么是 StackStorm ?

StackStorm 是一个自动化平台。

这个自动化平台将您现有的基础设施和应用程序环境联系在一起来让你更容易地实现自动化。

![img](https://pic4.zhimg.com/v2-2b4e88c721e69c43b2c4327452a85c7b_b.jpg)

## 我们为什么要学习 StackStorm ?

当我们进行自动化网络的设计时，引入 StackStorm 来执行时间驱动和事件驱动的控制将会让你的网络或应用的设计更加完善。

## StackStorm 的主要用途有哪些 ？

- **更加便利的排除故障（Facilitated Troubleshooting） -** StackStorm 可以用来处理 Nagios，Sensu，New Relic 和其他监控系统捕获的系统故障，然后在物理节点、OpenStack 或Amazon Instances 和应用程序组件上运行一系列诊断检查，并将结果发布到HipChat, Jira 等共享通信环境中。
- **自动修复（Automated remediation） -** 识别和验证 OpenStack 计算节点上的硬件故障，并正确清空实例和向管理员发送关于潜在停机时间的电子邮件，在运行中如果出现任何问题，就会冻结这个 workflow 通过 PagerDuty 工具来通知技术人员来手动修复。
- **持续部署 （Continuous deployment）-** 与 Jenkins 一起合作来进行构建和测试，配置新的AWS集群，使用基于 NewRelic 的应用程序性能数据来激活负载均衡的一些流量负载功能，并执行配置前滚或回滚的操作。

## StackStorm 是如何工作的？

**STEP01** 通过 push 或者 pull 的方式来通过 Sensors 来传递各个平台的 event 到 StackStorm。

![img](https://pic4.zhimg.com/80/v2-096c2993136722029e9528cf24cbef8f_1440w.jpg)

**STEP02** 在不同的 Trigger 之间来比较 Events，之后再生成相对应的行为规则。

![img](https://pic2.zhimg.com/80/v2-35d3223b42820b65beb23e7f2bc3ded1_1440w.jpg)

**STEP03** 处理 RabbitMQ message queue 中的 workflows。如果是 Mistral workflows， 那么就通过 Mistral Service 来处理。行为规则会通过不同的平台来进行 workflow 的执行操作。

![img](https://pic3.zhimg.com/80/v2-9d76836e5ba9b97bcc8bd4a31f041246_1440w.jpg)

**STEP04** RabbitMQ 产生的 queueLog 和 Audit History 会推送到 MongoDB 数据库来保存

![img](https://pic3.zhimg.com/80/v2-f76c13a7d98fbb8e67e56dbfdc24b34e_1440w.jpg)

**STEP05** 处理过的结果会通过 rules engine 来发送回 RabbitMQ Message Queue 来等待下一次的处理

![img](https://pic2.zhimg.com/80/v2-5bd7244486495a4efa33d77de05378c5_1440w.jpg)

## StackStorm 有哪些基础组件呢？

- **传感器（Sensors）**是一个集成的Python插件。这个插件用来接收或监测入站或出站的传输数据或事件。 如果来自外部系统的事件发生并且通过传感器（Sensors）来进行了处理， StackStorm 就会发射一个触发器（Triggers）到系统中。
- **触发器（Triggers）**是 StackStorm 的外部事件表示形式。 触发器分为两种，第一种通用触发器（比如：timers，webhooks）。第二种是集成触发器（比如，Sensu alert，JIRA issue updates）。 可以通过传感器插件来创建新的触发器类型。
- **动作（Actions）**是 StackStorm 的整合出站行为。 动作分为三种，为通用动作（ssh，REST调用），集成动作（OpenStack，Docker，Puppet）和自定义操作这三种。 动作可以是Python插件或者是任何脚本，我们通过添加几行 metadata 的数据来将脚本调用到 StackStorm中。 动作可以由用户通过 CLI 或 API 来直接调用，或者作为 rules 和 workflows的一部分来使用。
- **规则（Rules）**将触发器（Triggers）映射到动作（或 workflows），应用匹配条件并将触发器加载到动作的输入中。
- **工作流（Workflows**）多个动作的组合。将动作拼接成“超级动作”。 在 workflow 中可以定义动作的顺序，转换条件以及如何传递数据的规则。 大多数自动化 workflow 都不仅仅局限于一步，因此需要多个动作。 工作流就像“原子”动作一样，可在Action库中使用，并且可以手动调用或由规则触发。
- **包(Packs)** 是内容部署的单位。 它们通过对集成（触发器和动作）和自动化（规则和工作流）进行分组，简化了StackStorm可插拔内容的管理和共享。 StackStorm Exchange上有越来越多的包可用。 用户可以创建自己的包，在Github上共享它们，或者提交给StackStorm Exchange.
- **审计跟踪（Audit Trail）**记录并存储手动或自动操作执行的审计跟踪，并存储触发上下文和执行结果的全部细节。 它还被记录在审计日志中，用于集成外部日志记录和分析工具，比如：LogStash，Splunk，statsd 和 syslog

发布于 2020-07-11 22:48

DevOps

网络编程

运维自动化