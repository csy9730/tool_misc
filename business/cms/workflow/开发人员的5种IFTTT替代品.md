# 开发人员的5种IFTTT替代品



[cxu0262](https://blog.csdn.net/cxu0262) 2020-05-18 19:53:54 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 544 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 1

文章标签： [运维](https://so.csdn.net/so/search/s.do?q=运维&t=blog&o=vip&s=&l=&f=&viparticle=) [ruby](https://so.csdn.net/so/search/s.do?q=ruby&t=blog&o=vip&s=&l=&f=&viparticle=) [json](https://so.csdn.net/so/search/s.do?q=json&t=blog&o=vip&s=&l=&f=&viparticle=)



就其本身而言，一个应用程序或一个网站只能做很多事情。 当它与其他服务一起工作时，它才真正强大。 [IFTTT（适用于“](https://ifttt.com/)如果这样那么做”）将多个网站和服务整合到大多数人都可以使用的事件驱动的工作流中。

但是，IFTTT并不是唯一一个可以轻松解决难题的游戏，尤其是如果您是程序员的话。 这里有五种产品（三个托管服务和两个开源项目），它们为独立开发人员和在企业环境中工作的开发人员提供类似于IFTTT的集成。

**[Microsoft .Net 5将.Net Framework和.Net Core结合在一起：了解.Net Standard和.Net Core的合并对开发人员意味着什么 。** **|** **从InfoWorld的Microsoft Architect博客中了解如何从.Net Framework和.Net Core中获得最大收益。** **|** **通过InfoWorld的App Dev Report新闻通讯了解编程方面的热门话题。** **]**

## 扎皮尔

[Zapier的](https://zapier.com/)工作方式与IFTTT非常相似。 您从包含1,000多种可用服务的目录中进行选择，从一个服务中选择作为触发器的操作，然后使用类似于流程图的UI将其与其他服务上的操作挂钩。 Zapier的最大缺点是它仍然很新-某些功能和集成尚未交付。

Zapier拥有大量针对企业和以开发人员为中心的集成清单：GitHub，Slack，OneDrive，Monday，Trello。 浏览[开发人员工具](https://zapier.com/apps/categories/developer-tools)类别，您会发现大部分已经使用过的工具以及一些您不知道的工具。

某些集成仅对高级用户可用，例如AWS Lambda，但绝大多数（包括上述内容）都可以在免费层上访问。 其他集成仍处于测试阶段，例如Okta或CloudBoost。 还有其他计划中但尚不可用的项目，例如Code Climate，CircleCI，Amazon RedShift和Active Directory。

Zapier对开发人员的吸引力并不意味着它是神秘的。 集成的每个阶段都有清晰的说明，并且在继续进行下一步之前，可以对每个步骤进行测试以确保其行为符合预期。 一些集成支持订单项或数组（例如，开发票应用程序），尽管这种支持仍然有限。



[付费帐户可以](https://zapier.com/app/billing/plans/)解锁几种类型的功能。 除非您购买团队或企业计划，否则您仅限于一定数量的集成。 例如，50美元的“专业”计划允许进行50次集成。 集成或具有两个以上步骤的集成的条件逻辑也仅限于付费计划。 每月250美元的团队计划可以解锁所有内容。 也就是说，某些企业级功能（例如单点登录和审核日志）尚未可用。



## 托盘

“点击而不是代码”是[Tray](https://tray.io/)的口号。 考虑到其推销的很大一部分是针对非技术用户的销售，支持和营销集成，因此这很合适。 但是Tray也为程序员提供了很多集成，其以开发人员为中心的用例包括Webhooks，API集成，数据库集成和应用程序嵌入。



可以手动，按计划或通过服务或Webhook触发托盘的集成。 许多集成都可以作为模板使用，并且可以按原样重复使用或修改。 集成都是多步骤的，并使用工作流编辑器（实质上是图形流程图创建器）创建。 如果仅按原样应用模板，则无需使用工作流编辑器。

两种工作流和无限用户的起价为每月595美元。 具有单点登录和日志记录/审核等功能的企业计划没有固定价格，但针对每个部署进行了自定义。 新发布的“嵌入式”定价层通过[GraphQL API](https://www.infoworld.com/article/3269074/what-is-graphql-better-apis-by-design.html)提供了一些深入的，以开发人员为中心的可定制性。

## StackStorm

[StackStorm](https://stackstorm.com/)是一个开源项目，用Python编写，并且按照IFTTT的明确设计。 传感器记录事件，这些事件可以触发操作的触发器，由规则控制，组合到工作流中并通过审核控件进行管理。 集成组可以打包在一起，然后供其他人重复使用。

最后一个功能使StackStorm具有独特的社区项目风格。 [在线交流](https://exchange.stackstorm.org/)列出了可用于StackStorm的所有社区贡献的集成，可通过类似`npm`的命令行工具安装。



数十种现成的集成涵盖了许多常见的开发人员使用案例：代码存储库（GitHub，Bitbucket，Gitlab），配置管理（Ansible，Chef，Puppet），通知（Slack），CI（Circle CI，Jenkins）云服务（AWS，Azure，Google），本地基础结构（Kubernetes，Active Directory）等等。

存在多个用于在自己的系统上设置StackStorm的选项。 您可以使用在大多数兼容Linux发行版上运行的安装脚本，或者拉取Docker容器，或者运行Ansible剧本或Puppet模块。 您可以部署Helm图表以在Kubernetes中以高可用性运行StackStorm。 或者，如果您想要最大的可定制性，则可以手动进行设置。

除了根据Apache版本2许可获得许可的StackStorm开源产品外，企业版还提供专业支持和高端工作流组合工具。 您可以免费试用90天的企业版。

## Microsoft连接器

微软提供了自己的IFTTT化身，称为“ [连接器”](https://docs.microsoft.com/en-us/connectors/) ，用于为三种不同的Microsoft产品（Microsoft Flow，PowerApps和Logic Apps）创建集成。 尽管这三种产品针对不同的市场，但它们使用集成和连接器的通用名册。

Microsoft大约250个连接器中最突出的特征是用于Microsoft产品，例如Office，OneDrive和Azure服务，但是还集成了其他一些面向开发人员的服务：GitHub，Slack，PagerDuty，Trello，Jira，Azure Service Bus和大本营。 值得注意的是缺少诸如Chef，Puppet，Salt和Ansible之类的配置管理工具的集成，但是您可以花[些力气滚动自己的连接器](https://docs.microsoft.com/en-us/connectors/custom-connectors/index) 。

[Microsoft Flow](https://flow.microsoft.com/)是最面向最终用户的服务，也是最明确设计为类似于IFTTT的服务。 使用Web界面或移动应用程序创建流程或服务与逻辑的集成。 但是，没有直接的方法来创建自己的连接器。 此外，虽然Flow有免费层，但其某些集成仅在按[付费层](https://flow.microsoft.com/en-us/pricing/)可用，起价为每位用户每月5美元。

[PowerApps](https://powerapps.microsoft.com/)是Microsoft的用于自定义业务应用程序的低代码应用程序创建系统，它比Flow先进，但对开发人员的负担比手工将所有内容汇总在一起要少。 PowerApps使您可以利用连接器生态系统来集成不同的服务。 同样，如果您所需的不在集成名册中，则可以通过一些工作自己创建它。

[Azure Logic应用程序](https://docs.microsoft.com/en-us/azure/logic-apps/) ，这是三个[应用程序](https://docs.microsoft.com/en-us/azure/logic-apps/)中最先进的，适用于在Azure中构建企业工具的开发人员。 它提供[了](https://docs.microsoft.com/en-us/azure/logic-apps/quickstart-create-first-logic-app-workflow)比Flow [更复杂的工具](https://docs.microsoft.com/en-us/azure/logic-apps/quickstart-create-first-logic-app-workflow)来创建集成。 定价模式也不同。 与其他云服务一样，Logic Apps按呼叫而不是按用户计费。 此外，按照Flow的规定，某些连接器（主要是企业系统的连接器）仅作为高级附件提供。

## 胡金

[Huginn](https://github.com/huginn/huginn)是一个用Ruby编写的开源项目，它以坐在Odin肩膀上的乌鸦的[名字命名](https://github.com/huginn/huginn) ，并向他通报了世界大事。 在Huginn的大量功能中，它在许多常用服务之间提供了可深度定制的集成（“代理”）。 它的最大缺点是您需要自己托管它，并且它需要Ruby的一些专业知识才能完全有用。

尽管如此，将Huginn部署在Docker容器中还是很容易的，并且提供了指导，指导您完成在DigitalOcean Droplet或Docker群模式集群等环境中的设置。 [Huginn随附的代理程序不仅](https://github.com/huginn/huginn/wiki/Agent-Types-&-Descriptions)包括与服务的集成，还包括诸如解析JSON或CSV，从源接收webhook或检查给定URL的HTTP状态之类的基本任务。 与Huginn集成的许多服务都以开发人员为中心-Jira，Slack，Basecamp，Amazon S3等。 在没有特定集成的情况下，通常可以利用Huginn更通用的集成之一（例如，webhook）。

GitHub上的[Huginn Wiki](https://github.com/huginn/huginn/wiki)提供了有关使用该项目的各种有用信息。 面向[专家](https://gist.github.com/mjhea0/b6b58eefc38985380ff9)和[新手的](https://github.com/huginn/huginn/wiki/Novice-setup-guide)安装指南均会介绍生成运行中的Huginn服务器， [设置OAuth应用程序](https://github.com/huginn/huginn/wiki/Configuring-OAuth-applications)以及[创建新代理](https://github.com/huginn/huginn/wiki/Creating-a-new-agent)所需的步骤。



From: <https://www.infoworld.com/article/3396185/5-ifttt-alternatives-for-developers.html>



相关资源：[...这是*开发人员*的免费*IFTTT*/Zapier*替代*产品。-Python*开发*_*类似*...](https://download.csdn.net/download/weixin_42157556/19056986?spm=1001.2101.3001.5697)