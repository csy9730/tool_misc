# Grafana的介绍与使用

[![img](https://upload.jianshu.io/users/upload_avatars/5235830/531187c6-baef-4871-8e73-16255b1b9dae.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/e5786bdcdbeb)

[少博先生](https://www.jianshu.com/u/e5786bdcdbeb)关注

32019.06.09 16:17:22字数 1,462阅读 182,768

# 1 简介

Grafana是一款用Go语言开发的开源数据可视化工具，可以做数据监控和数据统计，带有告警功能。目前使用grafana的公司有很多，如paypal、ebay、intel等。

## 1.1 七大特点

①可视化：快速和灵活的客户端图形具有多种选项。面板插件为许多不同的方式可视化指标和日志。
②报警：可视化地为最重要的指标定义警报规则。Grafana将持续评估它们，并发送通知。
③通知：警报更改状态时，它会发出通知。接收电子邮件通知。
④动态仪表盘：使用模板变量创建动态和可重用的仪表板，这些模板变量作为下拉菜单出现在仪表板顶部。
⑤混合数据源：在同一个图中混合不同的数据源!可以根据每个查询指定数据源。这甚至适用于自定义数据源。
⑥注释：注释来自不同数据源图表。将鼠标悬停在事件上可以显示完整的事件元数据和标记。
⑦过滤器：过滤器允许您动态创建新的键/值过滤器，这些过滤器将自动应用于使用该数据源的所有查询。

# 2 安装

> 详细安装教程可参考：[http://docs.grafana.org/installation/debian/](https://links.jianshu.com/go?to=http%3A%2F%2Fdocs.grafana.org%2Finstallation%2Fdebian%2F)

## 2.1 下载安装包

> wget [https://dl.grafana.com/oss/release/grafana-6.0.1-1.x86_64.rpm](https://links.jianshu.com/go?to=https%3A%2F%2Fdl.grafana.com%2Foss%2Frelease%2Fgrafana-6.0.1-1.x86_64.rpm)

## 2.2 安装环境依赖



```undefined
yum install initscripts fontconfig  
yum install freetype
yum install urw-fonts
```

## 2.3 安装Grafana服务



```css
rpm -Uvh grafana-6.0.1-1.x86_64.rpm
```

## 2.4 插件安装



```php
使用grafana-cli工具安装

#获取可用插件列表

grafana-cli plugins list-remote  

修改图形为饼状
grafana-cli plugins install grafana-piechart-panel
安装其他图形插件
grafana-cli plugins install grafana-clock-panel
#钟表形展示
grafana-cli plugins install briangann-gauge-panel
#字符型展示
grafana-cli plugins install natel-discrete-panel
#服务器状态
grafana-cli plugins install vonage-status-panel
```

## 2.5 插件卸载



```undefined
例：grafana-cli plugins uninstall vonage-status-panel
安装和卸载后需要重启grafana才能够生效
```

## 2.6 启动、重启、关闭



```csharp
启动：service grafana-server start
停止：service grafana-server stop
重启：service grafana-server restart
加入开机自启动： chkconfig --add grafana-server on
```

## 2.7 启动测试



```ruby
默认用户密码：admin/admin, 访问地址:  服务地址 : [http://grafana服务地址:3000](http://localhost:3000/)
如果出现登录界面，代表安装启动成功
```

# 3 创建Dashboard

## 3.1 数据源配置

Dashboard的建立都是基于某一个数据源的，所以要先加一个数据源。

![img](https://upload-images.jianshu.io/upload_images/5235830-db79cc9c5f345f79.png?imageMogr2/auto-orient/strip|imageView2/2/w/624/format/webp)

增加MySQL数据源

## 3.2 可视化方式

可视化方式有很多种，不过Graph、Table、Pie chart 这三种基本就已经满足数据展现要求了。

![img](https://upload-images.jianshu.io/upload_images/5235830-26e39053c2b22608.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

可视化方式

### 3.2.1 Graph

> 注意：只有Graph才能配置告警

#### 新建时间间隔变量

![img](https://upload-images.jianshu.io/upload_images/5235830-339d6a906d11733e.png?imageMogr2/auto-orient/strip|imageView2/2/w/609/format/webp)

新建时间间隔变量

#### Graph折线图

![img](https://upload-images.jianshu.io/upload_images/5235830-51346ae68058a920.png?imageMogr2/auto-orient/strip|imageView2/2/w/1052/format/webp)

Graph折线图



```php
SELECT $__timeGroupAlias(create_time,$__interval), country_name as metric, COUNT(user_id) as '用户数量' FROM `user`
WHERE $__timeFilter(create_time) GROUP BY 1,2 ORDER BY $__timeGroup(create_time,$__interval);
```

![img](https://upload-images.jianshu.io/upload_images/5235830-5064b7c95648ea67.png?imageMogr2/auto-orient/strip|imageView2/2/w/1072/format/webp)

展现方式默认是lines

#### Graph柱状图

把这个Graph折线图Copy一份，改一下展现方式即可。

![img](https://upload-images.jianshu.io/upload_images/5235830-5f20c3cecee237b2.png?imageMogr2/auto-orient/strip|imageView2/2/w/867/format/webp)

![img](https://upload-images.jianshu.io/upload_images/5235830-bbfd76406a138bab.png?imageMogr2/auto-orient/strip|imageView2/2/w/767/format/webp)

![img](https://upload-images.jianshu.io/upload_images/5235830-99a70893993d4af5.png?imageMogr2/auto-orient/strip|imageView2/2/w/994/format/webp)

改Lines为Bars

### 3.2.2 Table

#### 创建筛选查询变量

![img](https://upload-images.jianshu.io/upload_images/5235830-b908270f308a8992.png?imageMogr2/auto-orient/strip|imageView2/2/w/814/format/webp)

新建一个下拉列表做筛选

#### 用户列表

![img](https://upload-images.jianshu.io/upload_images/5235830-b4abc38d9bbb1eaf.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

用户列表



```bash
select user_id,user_name,mobile,id_number,country_name,money,create_time from user WHERE $__timeFilter(create_time) and country_name in ($countryName)
```

注意：默认添加完table后，如果有数字，会以K为单位，比如将300000展示位30k。
数字展示方式修改，Add column style：

![img](https://upload-images.jianshu.io/upload_images/5235830-06c00e82afaae277.png?imageMogr2/auto-orient/strip|imageView2/2/w/1196/format/webp)

修改数字样式

### 3.2.3 Pie

![img](https://upload-images.jianshu.io/upload_images/5235830-6570030a543957ed.png?imageMogr2/auto-orient/strip|imageView2/2/w/1181/format/webp)

饼图



```csharp
select country_name, create_time as time, count(*) as c from user where $__timeFilter(create_time) group by country_name order by c asc;
```

## 3.3 权限管理

### 3.3.1 用户管理

![img](https://upload-images.jianshu.io/upload_images/5235830-cbbbb57fd6a91418.png?imageMogr2/auto-orient/strip|imageView2/2/w/937/format/webp)

用户管理

### 3.3.2 团队管理

![img](https://upload-images.jianshu.io/upload_images/5235830-4eacdd30e5e80352.png?imageMogr2/auto-orient/strip|imageView2/2/w/938/format/webp)

新建团队



![img](https://upload-images.jianshu.io/upload_images/5235830-19967a518a2aa847.png?imageMogr2/auto-orient/strip|imageView2/2/w/935/format/webp)

团队加成员

### 3.3.3 文件夹权限设置

![img](https://upload-images.jianshu.io/upload_images/5235830-7b4fa7c9147e42fd.png?imageMogr2/auto-orient/strip|imageView2/2/w/928/format/webp)

### 3.3.4 dashboarad权限设置

![img](https://upload-images.jianshu.io/upload_images/5235830-aa336f2f036a2a4f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

> 如果user在该org下role=admin，就拥有了对该dashboard的admin权利，爱干啥干啥，比如配置这个dashboard，看dashboard，配置dashboard的权限。
> 如果user在该org下role=editor，就拥有了对该dashbaord的edit操作权限，可以编辑dashboard，当然也可以看。
> 如果user在该org下role=viewer，就拥有对该dashbaord的view操作权限，就是可以看这个dashboard，但不能编辑。
> 就如上图设置，如果登录用户是admin，就可以进行编辑；如果登录用户是wade，仅有查看权限。

## 3.4 模板变量

当表格中出现数据后，需要通过筛选条件进行筛选，grafana提供了模板变量用于自定义筛选字段。
Type:定义变量类型
Query:这个变量类型允许您编写一个数据源查询，该查询通常返回一个 metric names, tag values or keys。例如，返回erver names, sensor ids or data centers列表的查询。
interval:interval值。这个变量可以代表时间跨度。不要按时间或日期直方图间隔硬编码一个组，使用这种类型的变量。

> 遗留问题：当选择1d（单位是d）时，会报解析错误：error parsing interval 1d，暂未解决;

Datasource:此类型允许您快速更改整个仪表板的数据源。如果在不同环境中有多个数据源实例，则非常有用。
Custom:使用逗号分隔列表手动定义变量选项。
Constant:定义一个隐藏常数。有用的metric路径前缀的dashboards，你想分享。在dashboard export,期间，常量变量将作为一个重要的选项。
Ad hoc filters:非常特殊类型的变量，只对某些数据源，InfluxDB及Elasticsearch目前。它允许您添加将自动添加到使用指定数据源的所有metric查询的key/value 过滤器。

上面的Table和Graph分别使用了interval和query来定义变量进行筛选，不再重复。

### Text box

![img](https://upload-images.jianshu.io/upload_images/5235830-28723c0436ddfb06.png?imageMogr2/auto-orient/strip|imageView2/2/w/743/format/webp)

新建输入框



![img](https://upload-images.jianshu.io/upload_images/5235830-0432a2ae47040e2c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

### Custom

![img](https://upload-images.jianshu.io/upload_images/5235830-824ce0099b98c55a.png?imageMogr2/auto-orient/strip|imageView2/2/w/756/format/webp)

新建Custom变量



![img](https://upload-images.jianshu.io/upload_images/5235830-23628170763d3a8d.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

下拉选择

## 3.5 版本控制

![img](https://upload-images.jianshu.io/upload_images/5235830-903a8a117243167c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

# 4 告警通知

## 4.1 开启告警

grafana只有graph支持告警通知。
grafana的告警通知渠道有很多种，像Email、Teams、钉钉等都有支持。
在grafana.ini中开启告警：



```bash
#################################### Alerting ############################
[alerting]
# Disable alerting engine & UI features
enabled = true   #开启
# Makes it possible to turn off alert rule execution but alerting UI is visible
execute_alerts = true  #开启
# Default setting for new alert rules. Defaults to categorize error and timeouts as alerting. (alerting, keep_state)
;error_or_timeout = alerting
# Default setting for how Grafana handles nodata or null values in alerting. (alerting, no_data, keep_state, ok)
;nodata_or_nullvalues = no_data
# Alert notifications can include images, but rendering many images at the same time can overload the server
# This limit will protect the server from render overloading and make sure notifications are sent out quickly
;concurrent_render_limit = 5
```

## 4.2 邮件通知

### 4.2.1 STMP服务器配置

要能发送邮件通知，首先需要在配置文件grafana.ini中配置邮件服务器等信息：



```objectivec
#################################### SMTP / Emailing ##########################
[smtp]
enabled = true #是否允许开启
host =  #发送服务器地址，可以再邮箱的配置教程中找到：
user = 你的邮箱
# If the password contains # or ; you have to wrap it with trippel quotes. Ex """#password;"""
password = 这个密码是你开启smtp服务生成的密码
;cert_file =
;key_file =
skip_verify = true
from_address = 你的邮箱
from_name = Grafana
# EHLO identity in SMTP dialog (defaults to instance_name)
;ehlo_identity = dashboard.example.com
[emails]
;welcome_email_on_sign_up = false
```

> 修改完配置，记得重启Grafana服务

### 4.2.2 邮件发送

#### 配置邮件通知渠道

![img](https://upload-images.jianshu.io/upload_images/5235830-54fb6dd01afbf66f.png?imageMogr2/auto-orient/strip|imageView2/2/w/409/format/webp)

配置邮件通知渠道

#### 发送测试

![img](https://upload-images.jianshu.io/upload_images/5235830-a782f5298887d1e4.png?imageMogr2/auto-orient/strip|imageView2/2/w/1106/format/webp)

发送测试

#### 设置告警条件

![img](https://upload-images.jianshu.io/upload_images/5235830-55326a2faff29bfa.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

# 5 小结

Grafana是个功能强大、展现层很漂亮的数据可视化监控工具，本篇主要介绍了Grafana基于MySQL数据源的安装及常用姿势，也支持其他数据源如ElasticSearch、InfluxDB等。更多内容可看[官网](https://links.jianshu.com/go?to=https%3A%2F%2Fgrafana.com%2Fdocs%2Ffeatures%2Fdatasources%2Fmysql%2F)



51人点赞



[数据可视化](https://www.jianshu.com/nb/37557680)