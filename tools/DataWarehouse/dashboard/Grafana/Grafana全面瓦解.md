# Grafana全面瓦解

[![img](https://upload.jianshu.io/users/upload_avatars/15409454/30f5df9a-c141-426d-b7c0-71c920458d72.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/934713e03723)

[kan少年](https://www.jianshu.com/u/934713e03723)关注

192019.02.17 12:21:04字数 5,214阅读 240,657

# 1.概述--美观、强大的可视化监控指标展示工具

grafana 是一款采用 go 语言编写的开源应用，主要用于大规模指标数据的可视化展现，是网络架构和应用分析中最流行的**时序数据展示**工具，目前已经支持绝大部分常用的时序数据库。最好的参考资料就是官网（[http://docs.grafana.org/](https://links.jianshu.com/go?to=http%3A%2F%2Fdocs.grafana.org%2F)），虽然是英文，但是看多了就会啦。

## 1.1基本概念

Grafana支持许多不同的数据源。每个数据源都有一个特定的查询编辑器,该编辑器定制的特性和功能是公开的特定数据来源。 官方支持以下数据源:Graphite，Elasticsearch，InfluxDB，Prometheus，Cloudwatch，MySQL和OpenTSDB等。

每个数据源的查询语言和能力都是不同的。你可以把来自多个数据源的数据组合到一个仪表板，但每一个面板被绑定到一个特定的数据源,它就属于一个特定的组织。

![img](https://upload-images.jianshu.io/upload_images/15409454-f97c1a92652473b8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1145/format/webp)

支持的数据源

**DashBoard：**仪表盘，就像汽车仪表盘一样可以展示很多信息，包括车速，水箱温度等。Grafana的DashBoard就是以各种图形的方式来展示从Datasource拿到的数据。

**Row：**行，DashBoard的基本组成单元，一个DashBoard可以包含很多个row。一个row可以展示一种信息或者多种信息的组合，比如系统内存使用率，CPU五分钟及十分钟平均负载等。所以在一个DashBoard上可以集中展示很多内容。

**Panel：**面板，实际上就是row展示信息的方式，支持表格（table），列表（alert list），热图（Heatmap）等多种方式，具体可以去官网上查阅。

**Query Editor：**查询编辑器，用来指定获取哪一部分数据。类似于sql查询语句，比如你要在某个row里面展示test这张表的数据，那么Query Editor里面就可以写成select *from test。这只是一种比方，实际上**每个DataSource获取数据的方式都不一样，所以写法也不一样（[http://docs.grafana.org/features/datasources/](https://links.jianshu.com/go?to=http%3A%2F%2Fdocs.grafana.org%2Ffeatures%2Fdatasources%2F)）**，比如像zabbix，数据是以指定某个监控项的方式来获取的。

**Organization：**组织，org是一个很大的概念，每个用户可以拥有多个org，grafana有一个默认的main org。用户登录后可以在不同的org之间切换，前提是该用户拥有多个org。不同的org之间完全不一样，包括datasource，dashboard等都不一样。创建一个org就相当于开了一个全新的视图，所有的datasource，dashboard等都要再重新开始创建。

**User：**用户，这个概念应该很简单，不用多说。Grafana里面用户有三种角色admin,editor,viewer。admin权限最高，可以执行任何操作，包括创建用户，新增Datasource，创建DashBoard。editor角色不可以创建用户，不可以新增Datasource，可以创建DashBoard。viewer角色仅可以查看DashBoard。在2.1版本及之后新增了一种角色read only editor（只读编辑模式），这种模式允许用户修改DashBoard，但是不允许保存。每个user可以拥有多个organization。

**dashboard界面最上面一行解释**

![img](https://upload-images.jianshu.io/upload_images/15409454-c8de5c196f02e678.png?imageMogr2/auto-orient/strip|imageView2/2/w/550/format/webp)

界面顶部标题标注

上图显示了信息中心的顶部标题。

1侧面菜单切换：切换侧边菜单，允许您专注于仪表盘中显示的数据。侧面菜单提供对与仪表盘无关的功能（如用户，组织和数据源）的访问。

2信息中心下拉菜单：此下拉菜单显示您当前正在查看的信息中心，并允许您轻松切换到新的信息中心。从这里，您还可以创建新的信息中心，导入现有的信息中心和管理信息中心播放列表。

3星型仪表盘：对当前仪表盘执行星号（或取消星标）。加星标的信息中心在默认情况下会显示在您自己的主页信息中心上，并且是标记您感兴趣的信息中心的便捷方式。

4共享仪表盘：通过创建链接或创建其静态快照来共享当前仪表盘。在共享前确保信息中心已保存。

5保存仪表盘：当前仪表盘将与当前仪表盘名称一起保存。

6设置：管理仪表盘设置和功能，如模板和注释。

------

# 2.全面瓦解

对于grafana的部署，网上一搜一大把，这里不作累赘，可参考（[grafana官网安装说明](https://links.jianshu.com/go?to=http%3A%2F%2Fdocs.grafana.org%2Finstallation%2Frpm%2F)、[grafana酷炫图表](https://links.jianshu.com/go?to=http%3A%2F%2Fblog.51cto.com%2F13447608%2F2299747)），继续以下内容。

## 2.1登录grafana

要运行Grafana，请打开浏览器并转到http://localhost:3000/，如果你尚未配置不同的端口，则3000是Grafana监听的默认http端口。默认用户名为admin，默认密码为admin。当你第一次登录时，系统会要求你更改密码，我们强烈建议你遵循Grafana的最佳做法并更改默认管理员密码，你可以稍后转到用户首选项并更改你的用户名。

![img](https://upload-images.jianshu.io/upload_images/15409454-99ce86abb8e8928d.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

登录界面，可看到版本号

## 2.2数据源配置

按照前面的数据源，这里讲解几个我们常使用的数据源的配置，包括es、opentsdb、influxdb和zabbix，也可以新增其他的数据源。

![img](https://upload-images.jianshu.io/upload_images/15409454-4df0739faf0191e9.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

常用数据源示例

![img](https://upload-images.jianshu.io/upload_images/15409454-8cf97ded6a6a86e9.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

opentsdb数据源配置示例

其中关于Access这里具体解释下：Server (default) = 需要从Grafana后端/服务器访问，Browser = 需要从浏览器访问，对应上面的url。

![img](https://upload-images.jianshu.io/upload_images/15409454-69592c23ee371949.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

es数据源配置示例

![img](https://upload-images.jianshu.io/upload_images/15409454-4fa86f36cf19fb77.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

influxdb数据源配置示例

## 2.3仪表盘配置

在配置好所使用的数据源之后，即可新增配置自己的面板。面板也存在多种：

![img](https://upload-images.jianshu.io/upload_images/15409454-317b2cb92f057648.png?imageMogr2/auto-orient/strip|imageView2/2/w/880/format/webp)

仪表盘

这里选取graph为例，如下图所示，新增或配置仪表盘。右上角的红框中表示：新建、标星、分享、保存、设置、查询模式、时间段、缩小（针对时间段进行放宽，即小时间段换成了大时间段）、刷新等

![img](https://upload-images.jianshu.io/upload_images/15409454-97cff6d68a0fe944.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

新增仪表盘或编辑已有仪表盘

Graph里面的选项有：General（常规选择）、Metrics（指标）、Axes（坐标轴）、Legend（图例）、 Display（显示样式）、Alert（告警）、Time range（时间范围）

（1）General（常规选择：[http://docs.grafana.org/features/panels/graph/](https://links.jianshu.com/go?to=http%3A%2F%2Fdocs.grafana.org%2Ffeatures%2Fpanels%2Fgraph%2F)）

![img](https://upload-images.jianshu.io/upload_images/15409454-0fad1fa64f576058.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

常规选择

General允许定制面板的外观和菜单选项。

General Options

Title：仪表盘上的面板标题

Description：仪表盘描述信息

Transparent ：是否透明，选择之后会把该图的背景去掉，即透明状态

Repeat panel：是否重复panel，填写是重复的变量（参考后文3.2变量配置），即这个标题名中添加对应的变量，引用该变量需添加$，图标题即可随着自选的变量而变化。

![img]()

钻取/详细信息链接

Drilldown / detail link（为当前panel增加超链接）

Drilldown项允许在面板添加动态链接，可以链接到其他的dashboards或urls。

每个链接都有一个title，一个type和params。链接可以是dashboard，或是绝对链接。如果是dashboard链接，则dashboard值必须是仪表盘的名称。如果它是一个绝对链接，URL就是链接的URL。

params允许添加额外的URL参数的链接。格式是name=value，多种参数用&分隔。模板变量可以作为使用$ myVar作为值。

当连接到另一个Dashboard使用的模板变量，你可以使用var-myVar =value 填充模板变量所需的值从链接。

（2）Metrics（指标）

metrics页签定义要呈现的系列数据和源。每个数据源提供不同的选择([参考官网](https://links.jianshu.com/go?to=http%3A%2F%2Fdocs.grafana.org%2Ffeatures%2Fdatasources%2F))。这里以opentsdb数据源为例：

![img]()

指标

Data Source：数据源，在前面配置好数据源之后，在这里直接选择对应的数据源

查询A、B：可以根据情况进行新增或删除

metric：指标名，输入部分指标名，会自动查询匹配，可以快速进行选择

Aggregator：聚合条件，区分下第一行和第二行的aggregator，第一个是对指标值的聚合，第二个是对采样周期里的聚合

Alias：别名，根据需要进行自定义

Down sample：采样周期,即每隔多少周期采集一次数据并展现出来，**详情可见3.1特殊配置之interval**

Filters：过滤条件，可以添加多个，group by是否分组进行展示，其中参数type部分常用选择项的解释：literal_or, ilteral_or, wildcard,regexp等可以当做是一个具有返回值的函数

**literal_or：**返回一个或多个值，示例：hostname=literal_or(data-3|data-4|data-160)，相当于数据库中的WHERE hostname IN ('data-3','data-4','data-160')

**ilteral_or：**作用于literal_or类似，区别是literal_or大小写敏感，ilteral_or不区分大小写

**not_literal_or：**作用于literal_or相反，大小写敏感

**not_iliteral_or：**作用于not_literal_or类似，不区分大小写

**wildcard：**可以在一个字符串加一个*前缀、后缀、中缀(字符串中间添加修饰符号)或者多个中缀，*可以代表任意的字符，示例：hostname=wildcard(data*)，表示代表任何以data开头的主机名，相当于数据库中的WHERE hostname='data%'

**regexp：**正则表达式 功能非常强大，可以编写非常灵活的过滤规则，示例：regexp(data\-[0-9])，表示data-1到data-9之间的所有主机，需要注意的是特殊字符需要转义，如-，转义符为\

Tags：标签，对应的就是填写对应的指标和具体的值（注意和filters中的区别，这里只能填写具体的值，而不是写一类值）

（3）Axes（坐标轴）

![img]()

坐标轴

Left Y和Right Y可以自定义，即可以设置多重坐标轴，方便对比查看

Show：是否显示，可以通过从显示轴中取消适当的框来隐藏轴。

Unit：y轴的显示单元

Scale：Y轴的间隔度。选择“log base 2”以double的速度递增，（0、1、2、4、8...），选择“log base 32”,就是（0、1、32...）

Y-Min：Y轴的最小值（默认atuo）

Y-Max：Y轴的最大值（默认atuo）

Lable：Y轴的文本标签

（4）Legend（图例）

![img]()

图例

通过选择显示复选框隐藏图例。如果它被显示，它可以通过检查表复选框显示为一个值表。没有值的系列可以使用隐藏空复选框，从而在图例中隐藏。

options：

　　show：是否显示图例

　　as table：作为表格样式显示

　　to the right：显示在右边 

values：

　　在图例中，显示每个series的max\min\avg\total\current，能设置小数点位数。在图上显示，

　　通过点击列标题(如果保存的话，这个选项将会被持久化)来排序，通过min/max/avg来排序。

​    点击图例“”，也可单纯显示某个series。

（5）Display（显示样式）

![img](https://upload-images.jianshu.io/upload_images/15409454-819852a420eae395.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

显示样式

1、Draw option

Draw Modes：Bars(柱状图)、lines(折线图)、Points(点)

Mode Options:Fill(充满区域透明度)，Line Width(线宽度)，Staircase(是否阶梯)，Point Radius(点的半径，以此控制点的大小)

Hover tooltip

　Mode:All series(鼠标移到点上显示所有图例的值)，single(鼠标移到点上显示该series图例的值)

　Sort order:None(按图例排列顺序显示)，increaseing(值的从小到大递增)，Decreasing(值从大到小递减)

Stacking&Null value :stack(多series是否堆叠显示)，percent(百分比)，Null value：空值怎么显示(connected：null值被忽略，直线直接跳转到下一个值，null：空值被保留为空，这将在图中留下空白区域，null as zero：空值被绘制为零值)

2、series overrieds：多坐标轴重写，即可以在这里设置y轴正负轴或z轴的正负轴，需要选择对应的指标，而且因指标、指标别名的变化需重新设置，设置完成后对比效果更好

　alias or regex：series图例名称

​    Y-axis：显示在Y轴左右哪边，

　   z-index(多series显示前后位置)，

​    stack：堆叠，可选择，metric中A\B\C\D哪个。

　  transform（negative-Y:将值显示为负数）

  　fill below to:（将两者值充满颜色 ，由上往下从大值到小值，所以不可以写成min fill below tu max写法如图：）

![img](https://upload-images.jianshu.io/upload_images/15409454-e731a37b0d958385.png?imageMogr2/auto-orient/strip|imageView2/2/w/582/format/webp)

填充

3、Thresholds：可以写多条临界值在界面上显示，大于400，和大于600两个。如设置了alert，就不能设置这个。

![img](https://upload-images.jianshu.io/upload_images/15409454-818aec221011ae46.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

临界值

4、Time regions：时间区域允许你突出特定的时间区域图的，更容易看到例如周末营业时间和/或工作时间。

（6）Alert（告警）

![img](https://upload-images.jianshu.io/upload_images/15409454-ad9527d15afd5d4d.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

告警

Alert Config

Name & Evaluation interval：在这里可以指定警报规则的名称，以及调度器应该多长时间对警报规则进行评估。

Conditions：目前唯一存在的条件类型是一个查询条件，允许您指定查询字母（metric里查询语句的字母，代表哪个查询语句）、时间范围和聚合函数。

Notifications

在警告选项卡中，还可以指定警报规则通知，以及关于警报规则的详细信息。这个消息可以包含任何信息，关于如何解决这个问题的信息，链接到runbook等。实际的通知被配置并在多个警报之间共享。

State History

警戒状态的变化都被记录在内部注释Grafana的数据库表。状态更改可视为警报规则的图形面板中的注释。

（7）Time range（时间范围：[https://www.cnblogs.com/michellexiaoqi/p/7274890.html](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.cnblogs.com%2Fmichellexiaoqi%2Fp%2F7274890.html)）

![img]()

时间范围

您可以覆盖单个面板的相对时间范围，使它们与右上方的仪表盘时间选择器中选择的时间不同。这允许metrics在不同的时间段显示或同个时间。在面板编辑器模式的Time Range重写时间设置。

Override relative time：覆盖相对时间，该graph在屏幕上的显示时间段(time range)

Add time shift：添加时移，将现在时间减去时间,如20m，那屏幕的显示最新的时间段结束 为now-20m

Hide time override info：隐藏时间覆盖信息，即右上角的时间，当缩放或更改 Dashboard time到自定义绝对时间范围时，所有面板重写将被禁用。当仪表盘时间相对时，面板相对时间覆盖只处于活动状态。面板时间重写总是活跃的，即使当仪表盘的时间是绝对的。

Hide time override info选项允许您隐藏在覆盖时间范围选项时显示在面板右上方的覆盖信息文本。

注意：您只能在相对时间范围内覆盖仪表盘时间。绝对时间范围不可用。

------

# 3.特殊配置

## 3.1变量之interval 

这里的变量类型选择的是interval，可以设置隐藏状态，主要是控制查询时的采样周期，添加自动Auto后，在展示界面会根据选择的时间段自动选择对应的采样周期，这样设置的好处是减轻查询数据库的压力，同时展示界面的粒度会适配。变量配置完毕后，在仪表盘Metrics中对应位置配置**$interval**即可。

![img](https://upload-images.jianshu.io/upload_images/15409454-a8bf0d4ea4ea57ea.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

interval配置

![img](https://upload-images.jianshu.io/upload_images/15409454-9643c6ff01d1c22f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

interval变量展示

## 3.2变量之query

![img](https://upload-images.jianshu.io/upload_images/15409454-54a293cbf9939b4f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1037/format/webp)

变量

**Variable**

name: 变量名，比如我这里取名为ip，到时候要使用这个变量名就用$ip来调用。

type: 变量类型，变量类型有多种，其中query表示这个变量是一个查询语句，type也可以是datasource，datasource就表示该变量代表一个数据源，如果是datasource你可以用该变量修改整个DashBoard的数据源，变量类型还可以是时间间隔Interval等等。这里我们选择query。

label: 是对应下拉框的名称，默认就是变量名，选择默认即可。

hide: 有三个值，分别为空，label，variable。选择label，表示不显示下拉框的名字。选择variable表示隐藏该变量，该变量不会在DashBoard上方显示出来。默认选择为空，这里也选默认。

**Query options**

Data source: 数据源，不用多说。

Refresh: 何时去更新变量的值，变量的值是通过查询数据源获取到的，但是数据源本身也会发生变化，所以要时不时的去更新变量的值，这样数据源的改变才会在变量对应的下拉框中显示出来。Refresh有三个值可以选择，Never：永不更新。On Dashboard Load：在DashBoard加载时更新。On Time Range Change：在时间范围变化时更新。此处，选择On Dashboard Load，当数据源发生更新是，刷新一下当前DashBoard，变量的值也会跟着发生更新。

Query：查询表达式，不同的数据源查询表达式都不同（这些可以到官网上查询：[http://docs.grafana.org/features/datasources/](https://links.jianshu.com/go?to=http%3A%2F%2Fdocs.grafana.org%2Ffeatures%2Fdatasources%2F)）。

Regex：正则表达式，用来对抓取到的数据进行过滤，这里默认不过滤。

Sort：排序，对下拉框中的变量值做排序，排序的方式挺多的，默认是disable，表示查询结果是怎样下拉框就怎样显示。此处选disable。

**Selection Options**

Multi-value：启用这个功能，变量的值就可以选择多个，具体表现在变量对应的下拉框中可以选多个值的组合。

Include All option：启用这个功能，变量下拉框中就多了一个all选项。

Custom all value：启用Include All option这个功能，才会出现Custom all value这个输入框，表示给all这个选项自定义一个值，all这个选项默认是所有值的组合，你也可以自定义，比如我自定义all为cpu五分钟平均负载，则选择all就代表cpu五分钟平均负载。

虽然选择组合值可以在一个panel里面查看多种监控数据，但是由于不同监控数据的数值大小格式都可能不一样，在一个图形里面格式很难兼容，这样就会出现问题，所以此处建议默认都不选。

**Value groups/tags**

组合标签，可以选择多个值组合在一起设置一个标签，这个功能还没弄明白，按照官网上的操作没效果，暂且忽略吧，反正没多大影响。

**Preview of values (shows max 20)**

前面都设置好之后，下方会显示前二十。

点击add，group这个variables就创建好了。在仪表盘中配置时需要在变量的名字之前添加$标志。

**注意：**可以配置多个变量，且变量之间可以复用，即选定第一个变量之后，第二个变量可以使用择的第一个变量值再配置，以此类推

![img](https://upload-images.jianshu.io/upload_images/15409454-8ebcbf94199d25c0.png?imageMogr2/auto-orient/strip|imageView2/2/w/1023/format/webp)

多变量示例

![img](https://upload-images.jianshu.io/upload_images/15409454-e5ba1bf52031a65e.png?imageMogr2/auto-orient/strip|imageView2/2/w/807/format/webp)

多变量展示效果

下面是具体的一个influxdb数据源的具体变量的配置及展示效果。

![img](https://upload-images.jianshu.io/upload_images/15409454-759e8d8530850abc.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

inflxdb数据源之变量query

![img](https://upload-images.jianshu.io/upload_images/15409454-d4ca64ceb71ea013.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

最终的展示效果

------

# 4.仪表盘导出导入

仪表盘导入导出功能方便不同grafana之间仪表盘的复用。也可以在grafana官网下载现有的模板使用，少许更改即可展示自己的数据。

![img](https://upload-images.jianshu.io/upload_images/15409454-b490b568bdf36db0.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

导出

![img](https://upload-images.jianshu.io/upload_images/15409454-b1b2d45c0ab4f629.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

导入