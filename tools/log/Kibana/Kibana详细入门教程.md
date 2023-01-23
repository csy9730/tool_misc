# [Kibana详细入门教程](https://www.cnblogs.com/chenqionghe/p/12503181.html)



目录

- [一、Kibana是什么](https://www.cnblogs.com/chenqionghe/p/12503181.html#一kibana是什么)
- [二、如何安装](https://www.cnblogs.com/chenqionghe/p/12503181.html#二如何安装)
- [三、如何加载自定义索引](https://www.cnblogs.com/chenqionghe/p/12503181.html#三如何加载自定义索引)
- [四、如何搜索数据](https://www.cnblogs.com/chenqionghe/p/12503181.html#四如何搜索数据)
- [五、如何切换中文](https://www.cnblogs.com/chenqionghe/p/12503181.html#五如何切换中文)
- [六、如何使用控制台](https://www.cnblogs.com/chenqionghe/p/12503181.html#六如何使用控制台)
- [七、如何使用可视化](https://www.cnblogs.com/chenqionghe/p/12503181.html#七如何使用可视化)
- [八、如何使用仪表盘](https://www.cnblogs.com/chenqionghe/p/12503181.html#八如何使用仪表盘)



# 一、Kibana是什么

Kibana 是为 Elasticsearch设计的开源分析和可视化平台。你可以使用 Kibana 来搜索，查看存储在 Elasticsearch 索引中的数据并与之交互。你可以很容易实现高级的数据分析和可视化，以图表的形式展现出来。
使用前我们肯定需要先有Elasticsearch啦，安装使用Elasticsearch可以参考[Elasticsearch构建全文搜索系统](https://www.cnblogs.com/chenqionghe/p/12496827.html)

下面分别演示一下Kibana的安装、自定义索引，搜索，控制台调用es的api和可视化等操作，特别需要注意的是，控制台可以非常方便的来调用es的api，强烈推荐使用

# 二、如何安装

直接下载对应平台的版本就可以，参考地址[Installing Kibana](https://www.elastic.co/guide/en/kibana/current/install.html)
我里我直接下载了mac平台的[kibana-7.6.1-darwin-x86_64.tar.gz](https://artifacts.elastic.co/downloads/kibana/kibana-7.6.1-darwin-x86_64.tar.gz)
解压完画风如下
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316124923813-499003277.png)

配置可以参考[Configring Kibana](https://www.elastic.co/guide/cn/kibana/current/settings.html)
设置监听端口号、es地址、索引名
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316124933015-381228497.png)

默认情况下，kibana启动时将生成随机密钥，这可能导致重新启动后失败，需要配置多个实例中有相同的密钥
设置

```avrasm
xpack.reporting.encryptionKey: "chenqionghe"
xpack.security.encryptionKey: "122333444455555666666777777788888888"
xpack.encryptedSavedObjects.encryptionKey: "122333444455555666666777777788888888"
```

启动

```bash
./bin/kibana
```

打开http://localhost:5601，画风如下
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316124941303-817937361.png)

提示我们可以使用示例数据，也可以使用自己已有的数据，我把示例数据都下载了，单击侧面导航中的 Discover 进入 Kibana 的数据探索功能：
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316124947014-1689568981.png)

可以看到数据已经导入了，我们可以直接使用查询栏编写语句查询
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316124952198-613982968.png)

# 三、如何加载自定义索引

接下来演示加载已经创建book索引
单击 Management 选项
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125002324-1761768512.png)

然后单击 Index Patterns 选项。
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125008549-1126155590.png)

点击Create index pattern定义一个新的索引模式。
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125012923-171985027.png)

点击Next step
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125016914-557679240.png)

点击Create index pattern
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125023366-1540814218.png)

出来如下界面，列出了所有index中的字段
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125029588-742105904.png)

接下来，我们再来使用一下kibana查看已经导入的索引数据
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125035741-317517608.png)
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125040327-1265830382.png)

可以看到，已经能展示和检索出我们之前导入的数据，奥利给！

# 四、如何搜索数据

![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125057330-1304119143.png)
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316130346946-609181862.png)

可以看到，我们能很方便地搜索栏使用Llucene查询，查询语法可以参考[Lucene查询语法汇总](https://www.cnblogs.com/chenqionghe/p/12501218.html)

# 五、如何切换中文

在`config/kibana.yml`添加

```avrasm
i18n.locale: "zh-CN"
```

重新启动，即可生效
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125109335-1109503028.png)

# 六、如何使用控制台

控制台插件提供一个用户界面来和 Elasticsearch 的 REST API 交互。控制台有两个主要部分： editor ，用来编写提交给 Elasticsearch 的请求； response 面板，用来展示请求结果的响应。在页面顶部的文本框中输入 Elasticsearch 服务器的地址。默认地址是：“localhost:9200”。
点击左侧栏的[Dev Tools]，可以看到如下界面，可以很方便地执行命令
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125117540-1728278009.png)

示例操作

```bash
# 查看所有节点
GET _cat/nodes

# 查看book索引数据
GET book/_search
{
    "query": {
    "match": {
      "content": "chenqionghe"
    }
  }
}

# 添加一条数据
POST book/_doc 
{
  "page":8,
  "content": "chenqionghe喜欢运动，绳命是如此的精彩，绳命是多么的辉煌"
}

# 更新数据
PUT book/_doc/iSAz4XABrERdg9Ao0QZI
{
  "page":8,
  "content":"chenqionghe喜欢运动，绳命是剁么的回晃；绳命是入刺的井猜"
}

# 删除数据
POST book/_delete_by_query
{
  "query": {
    "match": {
      "page": 8
    }
  }
}

# 批量插入数据
POST book/_bulk
{ "index":{} }
{ "page":22 , "content": "Adversity, steeling will strengthen body.逆境磨练意志，锻炼增强体魄。"}
{ "index":{} }
{ "page":23 , "content": "Reading is to the mind, such as exercise is to the body.读书之于头脑，好比运动之于身体。"}
{ "index":{} }
{ "page":24 , "content": "Years make you old, anti-aging.岁月催人老，运动抗衰老。"}
{ "index":{} }
```

![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125129865-1244626749.png)

# 七、如何使用可视化

Kibana可视化控件基于 Elasticsearch 的查询。利用一系列的 Elasticsearch 查询聚合功能来提取和处理数据，再通过创建图表来呈现数据分布和趋势

点击Visualize菜单，进入可视化图表创建界面，Kibana自带有上10种图表，我们来创建一个自己的图表
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125145083-1814220051.png)

我们来添加一个直方图
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125152438-1029425675.png)
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125156751-1132660304.png)
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125201527-125419832.png)

可以看到，默认已经有一个Y轴了，统计的是数量，我们添加一个X轴，点击Buckets下的Add
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125207450-1245127647.png)

如下，我选择了customer_id字段作为x轴
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125211675-1397580860.png)

执行后如下
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125215674-905614276.png)

保存一下
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125218783-708512294.png)

# 八、如何使用仪表盘

Kibana 仪表板（Dashboard） 展示保存的可视化结果集合。
就是可以把上面定义好的图表展示
创建一个Dashboard
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125226243-447072527.png)

添加已经存在的图表
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125228657-170981334.png)
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125232234-303602763.png)

添加完后保存即可，我们可以定制出非常丰富的面板，如下
![img](https://img2020.cnblogs.com/blog/662544/202003/662544-20200316125310123-346878926.png)

Kibana的使用就是这么简单，是不是觉得超简单，建议自己去安装使用一下，加深印象，light weight baby !

分类: [DevOps](https://www.cnblogs.com/chenqionghe/category/1382983.html)