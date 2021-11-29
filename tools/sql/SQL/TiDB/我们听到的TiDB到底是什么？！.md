# 我们听到的TiDB到底是什么？！

[![路大路](https://pic1.zhimg.com/v2-dc223f2345166c59e6fb8ccf1766d583_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/lu-da-lu-31)

[路大路](https://www.zhihu.com/people/lu-da-lu-31)

TiDB 培训



79 人赞同了该文章

Java架构大师2019-04-22 10:28:33

最近TiDB掀起了一波分布式数据库的热潮，公司也在着手准备TiDB的培训工作，前几天也参与了几场公司针对TiDB的培训，下面我们了解一下关于TiDB。

## **TiDB 是什么？**

TiDB 是一个分布式 NewSQL 数据库。它支持水平弹性扩展、ACID 事务、标准 SQL、MySQL 语法和 MySQL 协议，具有数据强一致的高可用特性，是一个不仅适合 OLTP 场景还适OLAP 场景的混合数据库。

## **TiDB怎么来的？**

开源分布式缓存服务 Codis 的作者，**PingCAP** 联合创始人& CTO ，资深 infrastructure 工程师的**黄东旭**，擅长分布式存储系统的设计与实现，开源狂热分子的技术大神级别人物。即使在互联网如此繁荣的今天，在数据库这片边界模糊且不确定地带，他还在努力寻找确定性的实践方向。

2012 年底，他看到 Google 发布的两篇论文，得到了很大的触动，这两篇论文描述了 Google 内部使用的一个海量关系型数据库 F1/Spanner ，解决了关系型数据库、弹性扩展以及全球分布的问题，并在生产中大规模使用。“如果这个能实现，对数据存储领域来说将是颠覆性的”，黄东旭为完美方案的出现而兴奋， PingCAP 的 TiDB 在此基础上诞生了。

## **TiDB架构**

TiDB在整体架构基本是参考 Google Spanner 和 F1 的设计，上分两层为 **TiDB** 和 **TiKV** 。 TiDB 对应的是 Google F1， 是一层无状态的 SQL Layer ，兼容绝大多数 MySQL 语法，对外暴露 MySQL 网络协议，负责解析用户的 SQL 语句，生成分布式的 Query Plan，翻译成底层 Key Value 操作发送给 TiKV ， TiKV 是真正的存储数据的地方，对应的是 Google Spanner ，是一个分布式 Key Value 数据库，支持弹性水平扩展，自动的灾难恢复和故障转移（高可用），以及 ACID 跨行事务。值得一提的是 TiKV 并不像 HBase 或者 BigTable 那样依赖底层的分布式文件系统，在性能和灵活性上能更好，这个对于在线业务来说是非常重要。

![img](https://pic2.zhimg.com/80/v2-8bcb9a66c2b95b9599588a43570c3c51_1440w.jpg)

所以一套集群是又这样的3类角色共同组建而成。每个部分的解释如下：

**TiDB Server**

TiDB Server 负责接收 SQL 请求，处理 SQL 相关的逻辑，并通过 PD 找到存储计算所需数据的 TiKV 地址，与 TiKV 交互获取数据，最终返回结果。 TiDB Server 是无状态的，其本身并不存储数据，只负责计算，可以无限水平扩展，可以通过负载均衡组件（如LVS、HAProxy 或 F5）对外提供统一的接入地址。

**PD Server**

Placement Driver (简称 PD) 是整个集群的管理模块，其主要工作有三个： 一是存储集群的元信息（某个 Key 存储在哪个 TiKV 节点）；二是对 TiKV 集群进行调度和负载均衡（如数据的迁移、Raft group leader 的迁移等）；三是分配全局唯一且递增的事务 ID。 PD 是一个集群，需要部署奇数个节点，一般线上推荐至少部署 3 个节点。

**TiKV Server**

TiKV Server 负责存储数据，从外部看 TiKV 是一个分布式的提供事务的 Key-Value 存储引擎。存储数据的基本单位是 Region，每个 Region 负责存储一个 Key Range （从 StartKey 到 EndKey 的左闭右开区间）的数据，每个 TiKV 节点会负责多个 Region 。TiKV 使用 Raft 协议做复制，保持数据的一致性和容灾。副本以 Region 为单位进行管理，不同节点上的多个 Region 构成一个 Raft Group，互为副本。数据在多个 TiKV 之间的负载均衡由 PD 调度，这里也是以 Region 为单位进行调度。 当然做这件事情，我是认真的，而不是简单试一下就完事了。我列了一个基本的计划，来看看是否能够满足一些痛点，改进一些情况。

## **TiDB开发语言**

在 TiDB 研发语言的选择过程中，放弃了 Java 而采用 Go 。TiDB整个项目分为两层，TiDB 作为 SQL 层，采用 Go 语言开发， TiKV 作为下边的分布式存储引擎，采用 Rust 语言开发。在架构上确实类似 FoundationDB，也是基于两层的结构。 FoundationDB 的 SQL Layer 采用 Java ，底层是 C++ ，不过在去年，被 Apple 收购了。 在选择编程语言并没有融入太多的个人喜好偏向， SQL 层选择 Go 相对 Java 来说：

第一是 他们团队的背景使用 Go 的开发效率更高，而且性能尚可，尤其对于高并发程序而言，可以使用 goroutine / channel 等工具用更少的代码写出正确的程序；

第二是 在标准库中很多包对网络程序开发非常友好，这个对于一个分布式系统来说非常重要；

第三是 在存储引擎底层对于性能要求很高，Go 毕竟是一个带有 GC 和 Runtime 的语言，在 TiKV 层可以选择的方案并不多，过去基本只有 C 或 C++，不过近两年随着 Rust 语言的成熟，又在经过长时间的思考和大量实验，最终他们团队选择了 Rust（ Rust是Mozilla开发的注重安全、性能和并发性的编程语言。“Rust”，由web语言的领军人物**Brendan Eich**（js之父），Dave Herman以及Mozilla公司的Graydon Hoare 合力开发。）。

## **与 MySQL 兼容性对比**

TiDB 支持包括跨行事务，JOIN 及子查询在内的绝大多数 MySQL 的语法，用户可以直接使用现有的 MySQL 客户端连接。如果现有的业务已经基于 MySQL 开发，大多数情况不需要修改代码即可直接替换单机的 MySQL。

包括现有的大多数 MySQL 运维工具（如 PHPMyAdmin, Navicat, MySQL Workbench 等），以及备份恢复工具（如 mysqldump, mydumper/myloader）等都可以直接使用。

不过一些特性由于在分布式环境下没法很好的实现，目前暂时不支持或者是表现与 MySQL 有差异。

一些 MySQL 语法在 TiDB 中可以解析通过，但是不会做任何后续的处理，例如 Create Table 语句中 Engine 以及 Partition 选项，都是解析并忽略。更多兼容性差异请参考具体的文档。

**不支持的特性**

存储过程

视图

触发器

自定义函数

外键约束

全文索引

空间索引

非 UTF8 字符集

## **TiDB 基本操作**

下面具体介绍 TiDB 中基本的增删改查操作。

**创建、查看和删除数据库**

```text
使用 CREATE DATABASE 语句创建数据库。语法如下：
CREATE DATABASE db_name [options];
例如，要创建一个名为 samp_db 的数据库，可使用以下语句：
CREATE DATABASE IF NOT EXISTS samp_db;
使用 SHOW DATABASES 语句查看数据库：
SHOW DATABASES;
使用 DROP DATABASE 语句删除数据库，例如：
DROP DATABASE samp_db;
```

**创建、查看和删除表**

```text
使用 CREATE TABLE 语句创建表。语法如下：
CREATE TABLE table_name column_name data_type constraint;
例如：
CREATE TABLE person (
number INT(11),
name VARCHAR(255),
birthday DATE
);
如果表已存在，添加 IF NOT EXISTS 可防止发生错误：
CREATE TABLE IF NOT EXISTS person (
number INT(11),
name VARCHAR(255),
birthday DATE
);
使用 SHOW CREATE 语句查看建表语句。例如：
SHOW CREATE table person;
使用 SHOW FULL COLUMNS 语句查看表的列。 例如：
SHOW FULL COLUMNS FROM person;
使用 DROP TABLE 语句删除表。例如：
DROP TABLE person;
或者
DROP TABLE IF EXISTS person;
使用 SHOW TABLES 语句查看数据库中的所有表。例如：
SHOW TABLES FROM samp_db;
```

**创建、查看和删除索引**

```text
对于值不唯一的列，可使用 CREATE INDEX 或 ALTER TABLE 语句。例如：
CREATE INDEX person_num ON person (number);
或者
ALTER TABLE person ADD INDEX person_num (number);
对于值唯一的列，可以创建唯一索引。例如：
CREATE UNIQUE INDEX person_num ON person (number);
或者
ALTER TABLE person ADD UNIQUE person_num on (number);
使用 SHOW INDEX 语句查看表内所有索引：
SHOW INDEX from person;
使用 ALTER TABLE 或 DROP INDEX 语句来删除索引。与 CREATE INDEX 语句类似，DROP INDEX 也可以嵌入 ALTER TABLE 语句。例如：
DROP INDEX person_num ON person;
ALTER TABLE person DROP INDEX person_num;
```

**增删改查数据**

```text
使用 INSERT 语句向表内插入数据。例如：
INSERT INTO person VALUES("1","tom","20170912");
使用 SELECT 语句检索表内数据。例如：
SELECT * FROM person;
+--------+------+------------+
| number | name | birthday |+--------+------+------------+
| 1 | tom | 2017-09-12 |+--------+------+------------+
使用 UPDATE 语句修改表内数据。例如：
UPDATE person SET birthday='20171010' WHERE name='tom';
SELECT * FROM person;
+--------+------+------------+
| number | name | birthday |+--------+------+------------+
| 1 | tom | 2017-10-10 |+--------+------+------------+
使用 DELETE 语句删除表内数据：
DELETE FROM person WHERE number=1;
SELECT * FROM person;
Empty set (0.00 sec)
```

**创建、授权和删除用户**

```text
使用 CREATE USER 语句创建一个用户 tiuser，密码为 123456：
CREATE USER 'tiuser'@'localhost' IDENTIFIED BY '123456';
授权用户 tiuser 可检索数据库 samp_db 内的表：
GRANT SELECT ON samp_db.* TO 'tiuser'@'localhost';
查询用户 tiuser 的权限：
SHOW GRANTS for tiuser@localhost;
删除用户 tiuser：
DROP USER 'tiuser'@'localhost';
```



## **TiDB资料**

**TiDB中文简介（墙裂推荐）**

> [https://pingcap.com/docs-cn](https://link.zhihu.com/?target=https%3A//pingcap.com/docs-cn)

**TiDB最佳实践等PPT**

> [https://eyun.baidu.com/s/3huniXE0#sharelink/path=%2F](https://link.zhihu.com/?target=https%3A//eyun.baidu.com/s/3huniXE0%23sharelink/path%3D%2F)

**开源项目地址**

> [https://github.com/pingcap/tidb](https://link.zhihu.com/?target=https%3A//github.com/pingcap/tidb)

**TiDB 部署指导**

> [https://github.com/pingcap/docs-cn/blob/master/op-guide/binary-deployment.md#%E5%8D%95%E8%8A%82%E7%82%B9%E6%96%B9%E5%BC%8F%E5%BF%AB%E9%80%9F%E9%83%A8%E7%BD%B2](https://link.zhihu.com/?target=https%3A//github.com/pingcap/docs-cn/blob/master/op-guide/binary-deployment.md%23%E5%8D%95%E8%8A%82%E7%82%B9%E6%96%B9%E5%BC%8F%E5%BF%AB%E9%80%9F%E9%83%A8%E7%BD%B2)

**TiDB整体架构**

> [https://github.com/pingcap/docs-cn/blob/master/overview.md#tidb-%E6%95%B4%E4%BD%93%E6%9E%B6%E6%9E%84](https://link.zhihu.com/?target=https%3A//github.com/pingcap/docs-cn/blob/master/overview.md%23tidb-%E6%95%B4%E4%BD%93%E6%9E%B6%E6%9E%84)

**TiDB：支持 MySQL 协议的分布式数据库解决方案**

> [http://www.sohu.com/a/55958574_255273](https://link.zhihu.com/?target=http%3A//www.sohu.com/a/55958574_255273)

发布于 2019-06-27 16:07

TiDB

分布式数据库

MySQL

赞同 79

13 条评论

分享