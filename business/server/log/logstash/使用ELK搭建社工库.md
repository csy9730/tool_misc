# [使用ELK搭建社工库](https://blog.agppp.cn/shi-yong-elkda-jian-she-gong-ku/)

 [agppp](https://blog.agppp.cn/author/a/)  2 YEARS AGO (2018-11-20) 

手里有一些平时收集的社工信息，想自己搭建一个小社工裤把数据用起来，考虑到检索速度问题，没有使用传统的数据库+web程序的模式，使用了一个开源的文本检索框架elasticstatic，简单记录一下搭建过程。

ELK Stack是elasticsearch、logstash、kibana是三个开源软件的组合。Logstash是一款开源的日志收集处理框架，负责数据的采集和格式化，搭建社工库用不到，不用关心。Elasticsearch是一个开源的分布式搜索引擎，用于数据的快速索引存储，用于存储社工库数据，Kibana负责提供web展示功能。

### 背景

关于ELK背景以及相关知识介绍可以参考以下几个网站
<https://es.xiaoleilu.com/index.html>
<https://www.gitbook.com/book/looly/elasticsearch-the-definitive-guide-cn/details>
<https://github.com/13428282016/elasticsearch-CN/wiki>

### 配置

[elastic官网](https://www.elastic.co/) 下载最新版本的elasticsearch、kibana，搭建时下载的为elasticsearch5.3和kibana5.3。
如果没有特殊需求，解压下载文件后无需修改配置文件，一切默认即可
elasticsearch5.3需要安装jdk1.8+才能运行，下载后，运行双击`\bin\elasticsearch.bat`,访问`127.0.0.1:9200`，服务器返回json结果，启动成功，然后解压kibana5.3，双击`\bin\kibana.bat`,访问`127.0.0.1:5601`

### 创建社工库

由于开始时没有创建和配置索引，所以访问kibana提示如下：
![img](https://blog.agppp.cn/content/images/2017/04/--.PNG)
因此第一步需要创建一个社工库的index，kibana提供了一个elasticsearch rest接口的操作界面，点击左侧的Dev tools，打开rest api的web访问界面，在左侧输入如下命令：

```
PUT  /information/user/1
{
  "name":"测试",
  "email":"test@126.com",
  "tel":"18888888888",
  "idcard":"130123456789012345",
  "user_id":"test",
  "password":"123456",
  "salt":"0000",
  "card_no":"6226111100001111",
  "other":"something",
  "data_from":"test",
  "address":"hhhhhhh"
  
}
```

以上命令创建了一个名为information的index（相当于数据库）和名为uesr的type（相当于表）,并插入了一条id为1的测试数据，type无需事先定义列，会根据插入数据自动生成，每次插入的列的名称和数量均可不同
输入`GET /information/user/1?pretty`或`GET /information/user/_search`可查询插入的数据
删除index使用命令`DELETE information`
删除指定id的数据使用命令`DELETE /information/user/1?pretty`

插入数据，不指定id

```
POST  /information/user/
{
  "name":"测试",
  "email":"test@126.com",
  "tel":"18888888888",
  "idcard":"130123456789012345",
  "user_id":"test",
  "password":"123456",
  "salt":"0000",
  "card_no":"6226111100001111",
  "other":"something",
  "data_from":"test"
  
}
```

创建index后可以对kibana进行配置，返回kibana主页面，配置默认index，在Index name or pattern输入`information`，将复选框全部取消，点击create， 创建完成，再次点击左侧的Discover，即可进行查询，查询语法可参考
<https://segmentfault.com/a/1190000002972420>

### api查询删除操作

根据条件进行查询，查询data_from中包含test的记录

```
GET /information/user/_search
{
    "query" : {
        "match" : {
            "data_from": "test"
        }
    }
}
```

精确查询，查询email为22222@163.com的记录

```
GET /information/user/_search
{
  "query": { 
    
    "match_phrase":{
      
        "email": "22222@163.com" 
    }
  }
}
```

修改数据

```
POST /information/user/1/_update?pretty
{
  "doc":{
  "email":"test@163.com",
  "tel":"18877777777"
  }
}
```

根据查询条件删除数据（不同版本的elasticstatic命令不同）

```
POST  /information/user/_delete_by_query
{
    "query" : {
        "match" : {
            "data_from": "YY"
        }
    }
}
```

查询所有index

```
GET /_cat/indices?v
```

### 数据批量导入

```
POST /information/user/_bulk?pretty 
{ "index" : { "_index" : "information", "_type" : "user", "_id" : "1" } }
{"password": "19790330", "user_id": "qzzzse", "data_from": "test"}
{ "index" : {} }
{"password": "quzhou", "user_id": "qzzwl@189.com", "data_from": "test"}
```

每条数据占两行，第一行指定index type和id，由于路径中已经指定了index和type，且希望id自动生成，因此第一行也已改为`{ "index" : {} }`

文件批量导入需要使用curl命令 `curl -XPOST localhost:9200/_bulk --data-binary @data.json`,API 可以是 `/_bulk`, `/{index}/_bulk`, 或 `/{index}/{type}/_bulk` 这三种形式，当索引或类型已经指定后，数据文件中如不明确指定或申明的内容，就会默认使用API中的值从data.json文件使用utf-8编码，内容格式为：

```
{ "index" : { "_index" : "information", "_type" : "user", "_id" : "1" } }
{"password": "19790330", "user_id": "qzzzse", "data_from": "test"}
{ "index" : {} }
{"password": "quzhou", "user_id": "qzzwl@189.com", "data_from": "test"}
```

单个导入文件大小建议为10M左右

### 优化

使用单机只有一个node，因此无法创建备份分片，所以index的状态为yellow，可以使用如下命令关闭备份分片

```
PUT /_settings
{  "number_of_replicas" : 0 }
```

查询结果默认显示_id,_type,_inde,可以在Management-》advanced Setting中，编辑metaFields的值，将除`_source`的值删除即可

### 性能

单个index最多导入20亿条左右的数据，如果数据量大建议创建多个index
为了考虑便捷性，搭建的时候单机部署，且将系统放在了移动硬盘上，机械移动硬盘写入1亿行数据后IO吞吐率会达到将近100%，使用移动固态硬盘，5亿条数据后会出现问题，没有细看是io的问题还是内存，如果数据量超过5亿条，最好还是考虑分布式部署。



发表于：2018-11-20作者：agppp