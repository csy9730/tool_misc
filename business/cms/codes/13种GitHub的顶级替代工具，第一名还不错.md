### 13种GitHub的顶级替代工具，第一名还不错

Nicolas • 发表于2020-07-17 11:33:34 • 2534次阅读

[![13种GitHub的顶级替代工具](https://www.easemob.com/data/upload/ueditor/20200717/5f111c14862d4.jpg)](https://s3.51cto.com/oss/202007/15/1d7739ca5b416dbd002d5c98d382f691.jpg-wh_651x-s_2076208336.jpg)

【51CTO.com快译】

朋友，您是否正在寻找可靠且功能强大的GitHub替代方案?本文将向您详细介绍13种GitHub的顶级替代工具，以帮助您更好地决定：是要切换到另一个git平台，还是坚定地继续使用GitHub。闲言少叙，让我们开始吧：

### [GitLab](https://about.gitlab.com/)

作为最容易被人们想到的GitHub免费替代方案，GitLab拥有从项目计划到部署，整个DevOps生命周期的全栈工具。目前，它被全球超过一百万个组织所使用着，其中包括：NASA、高盛、索尼、EA、以及其他明星公司。

**Issue Tracker(或称GitLab Issues)：**

通过GitLab Issues，您可以记下所有的问题，精确地计划将来的任务，并确保项目的执行。此外，您还可以使用标签和注释功能，来确保团队协作的顺利进行。

与GitHub类似，您可以将任务分为不同的阶段，包括：“待办”、“进行中”和“完成”等，以清楚地标识团队的进度。此外，GitLab还拥有对项目进行可视化管理的GitLab Boards，以及Epics和roadmaps，可方便您很好地了解项目的发展方向。

在迁移方面，GitLab提供了导入和导出数据的详尽文档，以便您轻松地从GitHub处迁移到GitLab。

主要功能：

- Issue boards：可按照自己的方式安排任务。
- Epics：可轻松地跟踪进度，并做出与项目相关的更好决策。
- Roadmaps：可帮助您持续可视化项目的步骤，进而协助团队了解在每个截止日期前，成功完成项目所需采取的后续步骤。
- Burndown Chart：可让使您轻松地查看道当前的进度，以及可能阻碍将来工作流程的潜在障碍。
- Points and Estimation：可以让您为问题分配权重属性，进而获悉完成某些特定任务所需的预估工作量。
- Traceability：将各种问题与合并请求关联起来，并自始至终地跟踪项目的进度。
- Wiki：将文档和代码存放在同一位置。

GitLab CI：

在GitHub Actions出现之前，GitHub无法提供内置的CI/CD，开发人员必须与Jenkins或其他CI/CD平台相集成。而GitLab内置设计了CI/CD工具，可将所有的内容放在一处，以省去了配置第三方CI/CD的工作量。此外，GitLab CI能够加快开发的过程，以快速全新功能的发布。

CI/CD的功能：

- 开源：您可以在GitLab的社区版和专属企业版中访问到GitLab CI。
- 易于学习：请参见GitLab的快速入门-- <https://docs.gitlab.com/ee/ci/quick_start/>。
- 可扩展性：为了在独立的主机上运行CI测试，您可以按需进行大规模的扩展。
- 更快的结果：您可以通过将代码构建分为多个作业(jobs)，并在多台主机上并发进行，以加速开发的进程。
- 针对交付进行优化：可分为多个阶段、手动部署门(manual deploy gates)、环境(请参见--<https://docs.gitlab.com/ee/ci/environments.html>)、以及变量(请参见--<https://docs.gitlab.com/ee/ci/variables/>)。

源代码管理：

**协作**

使用合并请求来检查团队成员的代码，或在源代码存储库中对构建进行相互审查(peer-review)，进而提高发布的质量。当然，您也可以将代码审查功能运用到文本上，以跟踪各种版本、修改、文档建议和批准。此外，通过GitLab直观的Web IDE，您可以避免在多个浏览器之间频繁地切换，进而简化了工作的流程。

**合规与安全**

借助GitLab，您可以自动扫描代码，进而消除潜在的漏洞。同时，您也可以通过细粒度的访问控制与报告，简化审计与合规。

DevSecOps相关：

- 静态应用程序安全测试(SAST)：在开发周期的早期阶段，捕获并阻止各种漏洞。
- 动态应用程序安全测试(DAST)：在运行Web应用时，可确保已部署的内部版本免受任何可能的攻击。
- 依赖项扫描：在开发和测试应用时，通过扫描依赖项，以发现任何潜在的安全漏洞。
- 容器扫描：分析各种容器镜像中的漏洞。

其他GitLab功能：

- 使用GitLab，您可以根据人员的工作角色，授予对于存储库的访问权限。
- GitLab具有多种集成，包括：LDAP组的同步过滤器，针对组的SAML SSO，以及对LDAP的支持。
- 您还可以获得对智能卡的支持，价值流的管理，以及用于身份验证的IP加密功能。
- 您也可以自托管(self-host)GitLab，并在本地或云端部署GitLab实例。

### [BitBucket](https://bitbucket.org/product)

BitBucket是由Atlassian带来的另一款出色的git客户端，也是GitHub的一种替代方案。许多大型企业选用BitBucket的原因是：它能够与其他Atlassian的工具(如Jira、Confluence和HipChat)集成在一起，进而让大型团队能够轻松地管理他们的项目。当然，这也是Bitbucket与GitHub的主要区别之一。它虽然能够像GitHub那样托管各类开源项目，但是Bitbucket是一个封闭的、核心的git版本控制平台。

BitBucket可最多可容纳5位团队成员免费使用。您只需申请社区许可证(请参见--<https://www.atlassian.com/software/views/open-source-license-request?_ga=2.190556331.1669774279.1528097610-960415179.1528097610>)，并遵守Atlassian的开源准则，便可获得无限的私人存储库空间。

主要功能：

- 内置的CI/CD — 与GitLab CI和GitHub Actions相似，BitBucket管道可以帮助您加速开发的进程。通常，它可以帮助您在开发周期的早期，发现并修复各种错误，并且无障碍地加速部署。
- 您可以在Bitbucket中创建源代码存储库。
- 代码审查 - 使用各种拉取与合并请求，来提高代码的质量，发布出色的功能，以满足客户的全新需求。其中在拉取式请求中，它还能支持各种代码的审查注释。
- 安全性 — BitBucket通过IP白名单和两步验证(2-step verification)，来确保您的代码安全。您可以通过分支权限(branch permissions)与合并检查，来限制对于特定账号的访问。Bitbucket还拥有SOC 2 Type II的认证，因此您可以放心地在BitBucket上托管或构建自己的应用。
- JIRA集成 - 它可以轻松地与JIRA(一种在开发人员中广受欢迎的问题跟踪器)和Trello集成。您可以将各种拉取与合并请求，同步到JIRA问题或Trello卡中。
- 支持LFS(大文件存储)。
- 将大型文件和富媒体存储在Git LFS中。
- 支持源代码搜索。
- 提供针对项目的Wiki。
- 提供用于托管静态网站的BitBucket云。
- 智能镜像可实现更快的克隆，获取，以及拉取(仅适用于高级用户)。
- Bitbucket提供最多5个用户的免费计划。

总而言之，对于大型团队和企业而言，Bitbucket是一个不错的选择。它可以轻松地与其他Atlassian产品相集成，进而大幅简化工作流程。

### [Codegiant](https://codegiant.io/home)

作为GitHub的绝佳替代方案，Codegiant提供了一个简单的问题跟踪器(请参见--<https://blog.codegiant.io/our-issue-tracker-went-from-good-to-great-11a546f1e389>)、内置的CI/CD框架、错误跟踪系统、源代码管理、以及非常直观的界面。

和GitLab类似，Codegiant拥有丰富功能。其中包括：通过极简的直观界面，让您能够轻松地将项目构想转移到云端。

**Issue Tracker(问题跟踪器)**

Codegiant的问题跟踪器提供了看板(Kanban)和Scrum Board视图功能。在时间紧迫情况下，Scrum Board视图将帮助您有效地组织工作流程，以便按时完成所有的任务。当然，您也可以选择看板，并以50,000-foot的视图，来查看项目及其推进方向。

主要功能：

- 通过简单的界面，来敏捷地管理项目。
- 提供看板+Scrum，两种问题跟踪器。
- 路线图。
- Sprints。
- Epics。
- 分析任务的绩效。
- 管理任务和子任务。
- 标签、提示和注释。
- 时间估算。
- 可一键式导入Jira项目。
- Codegiant最多可为5位用户提供免费的计划，之后每人每月3美元起。

**储存库和Web IDE**

除了强大的git存储库，Codegiant还提供了一个简易设计的Web IDE，以方便您将所有的内容都放在一处，而不必在各种浏览器之间频繁跳转。同时，您可以轻松地从Github、Bitbucket、托管式Git服务器、以及SVN处，将现有的存储库导入Codegiant。

**合并请求**

借助Codegiant，您可以采用拉取或合并请求的方式，对目标的代码进行相互审查和增强，并最终交付出让客户满意的高级功能。

**协作**

用户可使用行内注释(inline comments)和线程对话，来统一整个团队的节奏和控制对于存储库的访问。

**Codegiant流**

集成式CI/CD工具，可方便您运行各种并发的作业，并轻松地定义和协调作业的构建、测试、部署方式、以及部署自动化。通过一键回滚到过往的部署版本，整个团队能够更快地与过去发布过的功能作对比。此外，Codegiant CI还支持原生的Docker、Kubernetes和Knative引擎。

**文档**

借助Codegiant提供的强大的可发布文档工具，您可以创建不同的API文档、状态页、知识库、以及产品路线图等。

作为GitHub的免费替代方案，Codegiant不但简单易用，而且它的入门过程比其他同类工具要短许多。

### [SourceForge](https://sourceforge.net/)

SourceForge是一款相当简单的GitHub替代品。它虽然拥有3200万用户，不过在功能上不如GitHub那样强大。使用SourceForge，您既可以开发与审查代码，又可以发布各种开源的项目。

在SourceForge上，您可以访问存储库、错误跟踪程序、用作负载平衡的下载镜像、文档、邮件列表、支持论坛、新闻公告、用于发布项目更新的微博等。不过，目前它并未内置CI/CD工具。

由于完全免费，因此诸如Linux之类的开源项目与软件，往往会通过SourceForge来开发。

主要功能：

- 通过提供有关项目的详尽统计信息和分析，以评估团队的绩效。在下载报告时，您还可以使用位置、平台、区域等过滤器。
- 开源目录使您可以对项目进行分类，快速截图，并在社交媒体上轻松地分享项目。
- 开源存储库允许您使用Git、Mercurial、或任何Subversion来托管代码。
- 支持Apache Allura，您可以托管您的forge，并启动下一轮的改进。
- SourceForge自带有GitHub的导入程序(请参见-- [https://sourceforge.net/p/forge/documentation/GitHub%20Importer/](https://sourceforge.net/p/forge/documentation/GitHub Importer/))。

### [Launchpad](https://launchpad.net/)

由Canonica带来的Launchpad主要被用于Ubuntu项目中，不过它的知名度不及GitLab、GitHub和BitBucket。

主要功能：

- Launchpad带有直观的错误跟踪器。通过其Web邮件、API接口、以及问题链接，您可以创建并分享错误报告、状态、补丁、甚至可以对某个问题的注释，当然也可以与其他跟踪器(如Bugzilla和Trac)共享数据。
- 错误报告一目了然，您可以迅速地确定代码中的错误位置，然后直接跳转过去解决问题。
- 提供全面的代码审查功能。整个团队可以通过界面上展示的前、后代码不同状态，以开展讨论。
- 团队中的每个人都有权提交到一个集中式托管分支中。
- 每个小组都可以通过邮件组，来实现订阅管理、自动归档等功能。
- 雄厚的社区资源可将您的软件快速翻译成各种语言。
- 可同时支持针对Git和Bazaar的代码托管。
- 提供Web服务的API。
- 可以通过电子邮件来跟踪错误。
- 提供知识库和常见问题的解答。

总体而言，Launchpad的众多功能，非常适合您实现可靠的错误跟踪系统。

### [Google Cloud Source Repositories](https://cloud.google.com/source-repositories)

通过出色的代码存储库工具--Google Cloud Source Repositories，您可以免费获得最多5个用户的50 GB存储空间，以及12个月的试用期。

内置有CI/CD集成的Google Cloud Source Repositories，可帮助您通过设置触发器，来自动测试代码，进而加快DevOps的整个周期，以及新功能的发布。

主要功能：

- 可直接部署，而无需第三方应用。
- Cloud Build使您能够在部署时自动构建和测试代码。
- 可对各种无服务器的请求，进行版本控制和别名处理，并能够跟踪指定时间段内源代码的修改。
- 允许用户在生产环境内，在不影响应用的前提下，查看与调试代码。
- 通过详细的审核日志，让您深入了解存储库的历史记录，以便查看入库前、后的变化。
- 能够将存储库与Google的其他产品相集成。
- 可以通过“源浏览器”来显示所有存储库里的文件，以便您定位特定的分支、标签或提交。
- 允许用户将GitHub或Bitbucket存储库，与Cloud Source存储库自动同步。
- 由于运行在Google高可用的架构上，并且Google在全球拥有多个数据中心，因此用户代码的安全性得到了充分的保障。

总而言之，Cloud Source Repository非常适合于那些希望有简单的界面和CI/CD内置集成的用户。

### [AWS CodeCommit](https://aax-us-east.amazon-adsystem.com/x/c/Qt20pA-MdY_b97DGaNXcCOkAAAFy9gHn6QEAAAFKATK12TU/https://assoc-redirect.amazon.com/g/r/https://aws.amazon.com/codecommit/?linkCode=w61&imprToken=dr1y4Lmj2RJh-IcsaQRGjw&slotNum=0)

作为代码管理工具，AWS CodeCommit的主要目的是：通过内部提交、分支与合并代码，来简化开发人员之间的协作。您可以使用拉取式请求来增强代码，并发布强大的功能。此外，您还可以通过AWS管理控制台、AWS CLI或AWS开发工具包，来创建存储库。

AWS CodeCommit的免费计划包括5个用户和50 GB的存储空间。而每添加一个用户则需多支付1美元。

主要功能：

- 加密 - 您可以使用SSH或HTTPS，轻松将文件传输给CodeCommit。AWS KMS(密钥管理服务)使用客户特定的密钥，来自动加密存储库。
- 访问控制 - 您可以通过AWS Identity and Access Management来限制其他人访问您的存储库。同时，您也可以通过AWS CloudTrail和CloudWatch来监控自己的存储库。
- 高可用性和持久性 - 由于CodeCommit使用了Amazon S3和DynamoDB服务器来进行存储。同时，Amazons的架构向来具有较好的可用性和持久性，因此用户的加密数据在存储的过程中相对比较安全。
- 易于访问和集成 - AWS CodeCommit通过与其他Amazon产品相集成，让您能够轻松地管理存储库。CodeCommit不但支持每一个git命令，而且可以与您现有的git工具实现协同。
- 通知和自定义的脚本 - 您在存储库中的任何修改，都会显示为Amazon SNS通知。而且，每一条消息都带有状态，并指向发起通知的事件链接。

### [Gogs](https://gogs.io/)(自托管)

作为一款完全自托管的解决方案，Gogs可被用于托管您的代码，而且您只需为平台准备二进制文件。当然，您也可以将打包的Docker或Vagrant发送到Gogs处。

Gogs可以在Windows、Mac、Linux、以及ARM等所有可以编译Go语言的平台上运行。此外，它还能作为轻量级的部件运行在树莓派(Raspberry Pi)上。Gogs虽然功能强大，但是发布的节奏较慢。因此，Gogs的一些贡献者fork出了能够支持OAuth的Gitea。

主要功能：

- 非常易用。
- 提供问题跟踪器。
- 可通过二进制实现轻松的设置。
- 可以将打包的Docker或Vagrant发送到Gogs。
- 支持十分给力。
- 可作为轻量级的部件运行在Raspberry Pi上。
- 在Gogs的网站上，提供丰富的文档和Wiki。

### [Gitea](https://gitea.io/en-US/)

如前文所述，源自Gogs的开源式Gitea，是由Go编写的轻量级GitHub克隆。与Gogs相似，Gitea可以运行在Windows、Mac OS、Linux、以及ARM上。它同样是一个直观且易用的平台，可以实现轻松的代码管理。此外，由于Gitea对硬件的要求较低，因此它也可以运行Raspberry Pi上。

Gitea拥有简易的问题跟踪系统，可方便您添加各种里程碑、标签和时间跟踪。您还可以使用拉取与合并式请求，来对代码进行相互审查，进而提高构建的质量。

主要功能：

- 提供多个数据库、操作系统、以及org-mode的支持。
- 对RAM和CPU等资源的使用率较低，支持CSV、第三方集成、Git Wiki、部署令牌、以及存储库令牌。
- 支持全局性代码搜索、新分支的创建、Web代码编辑器、以及提交图(commit-graph)。
- 其数据库引擎PostgreSQL、MariaDB和SQLite，都是免费的。
- 并无内置的CI/CD。
- 支持Squash与rebase合并，提供拉取与合并的模板。
- 提供问题跟踪器。
- 设置比较简单。
- 可发送打包的Docker或Vagrant。
- 支持十分给力。
- 可作为轻量级的部件运行在Raspberry Pi上。
- 提供丰富的文档和Wiki。

总之，Gitea是简化版的Gogs。

### **GitKraken**

GitKraken可以在Windows、Mac和Linux上运行。对于非商业用途和人数不超过20人的团队而言，GitKraken是免费的。不过它的专业版则提供了一些额外的功能，以方便您轻松地管理代码。GitKraken通过直观的界面，来简化工作流程，并方便您更有效地管理构建。

主要特点：

- 其UI十分简单，具有可视化的提交历史记录，以及拖放和撤消等功能。
- 您可以轻松跟踪任务，并获得markdown支持和日历视图。
- 自带有合并冲突编辑器、应用内合并工具、以及输出编辑器。
- 您可以通过内置的代码编辑器，去访问并排显示的差异对比、语法突出显示、搜索引擎、以及文件迷你地图(mini-map)。
- 您可以将GitKraken Git GUI与GitKraken Boards、Jira Cloud或Jira Server集成在一起，实现一站式创建任务，添加注释与编辑，进而极大地简化了管理。
- 您可以轻松使用那些托管在其他站点上的存储库。
- 可以实现用户访问权限和许可证的管理。当然，许可证管理的类型取决于您选择的计划。每一个许可证都可以在不同的计算机上使用，而与操作系统无关。
- 其他功能还包括：支持Git流、Git LFS、Git hooks、交互式rebase、明暗主题、键盘快捷键、选项卡、子模块、以及提交签名等。

### GitKraken Boards--在多个视图中可视化工作流程

GitKraken Boards带有直观的看板视图，可帮助您可视化的工作流程。通过它，您还将获得日历视图、时间轴视图和仪表板，并能够有效地组织各项任务。

**跟踪任务**

在修改代码时，您可以轻松地更新板的问题，而无需跳转到其他工具上。而且，所有修改均能实时显示。

**自动卡更新**

通过列自动化，它能够自动完成诸如更新卡标签，分配任务，添加里程碑等繁琐的任务。

**同步GitHub问题和里程碑**

您可以轻松地将GitHub问题与GitKraken问题相同步，并将所有的数据都集中到一处。您还可以将卡片链接到GitHub拉取式请求上。

**从Slack处添加任务**

GitKraken能够与Slack顺利集成。由于Slack在内部很容易更新卡的受让人、标签、以及列卡(column cards)，因此您可以直接从Slack处创建和预览问题。而且，当有人在Slack中提到您时，您可以直接在GitKraken Boards上得到通知。

### GitKraken Timelines

**协作**

GitKraken Timelines使您可以可视化工作流程，查看接下来要执行的基本步骤，以及与团队成员沟通需要达到的主要里程碑。

**快速创建和更新在线时间表**

GitKraken Timelines是专门为开发团队设计的。因此，开发人员可以轻松地创建各项任务、问题、并更新截止日期。当您更新某项特定任务时，与该任务相关的所有事项，也会得到自动更新。

**会议中的当前时间表**

在团队会议方面，您可以将GitKraken Timelines切换为演示模式，并轻松地与团队沟通各种里程碑和截止日期。

**嵌入公共时间表**

您可以通过获取嵌入式代码，实现在自己的网站上轻松地发布时间表。

### [Beanstalk](https://beanstalkapp.com/)

Beanstalk提供了用于构建、相互审查和部署代码的完整生命周期。通过精心的设计，Beanstalk通过直观的界面，将通知、邮件摘要、比较视图、提交、以及文件的详细历史记录，都呈现在了同一个页面上。

主要功能：

- 您可以快速地创建和管理存储库，并能邀请团队成员和客户加入进来。
- 提供git和svn托管服务。
- 支持添加文件，创建分支，以及直接在平台中编辑代码。
- 只需单击，即可创建、查看或合并各种分支。
- 您可以通过访问多个环境，来部署代码，并跟踪各项工作。
- 可通过访问统计信息和报告，来深入了解团队的绩效。
- 可通过定义存储库和分支级别的许可证，来授予团队成员的访问权限。其灵活的调节特性，适合于任何规模的团队。
- 您可以设置发布通知，以便团队知晓何时需进行部署，并按需查看发布说明。
- 可与HipChat和Campfire等工具相集成，为团队提供有效的协作。
- 安全的基础架构 — 所有数据都能实现银行级别的加密管理。Beanstalk已获得Type 2 SSAE 16和SOC 1认证。其数据中心采用了钥匙卡、生物识别扫描协议，以及不间断的密切监控。

u 您可以通过两步验证的过程，以及IP访问的记录和限制，来完全控制对应的Beanstalk帐户。

### **GitBucket**

由Scala推出的GitBucket，是一个运行在JVM上的开源Git平台，可以作为Apache许可版本(2.0)的开源软件所使用。通过其简单的界面，您可以通过HTTP和SSH密钥来托管git存储库。

主要功能：

- 它是由Scala提供支持的自托管式免费开源平台。
- 通过简便的设置，您可以添加自己的存储库、以及SSH密钥。
- 其UI非常简单。
- 您可以同时拥有其免费的私有版本和公共的存储库。
- 提供搜索引擎、邮件通知、以及用户管理。
- 提供Wiki的拉取式请求、活动时间表、LDAP集成、以及对GitBucket的完美支持。

### [Phabricator](https://www.phacility.com/phabricator/)

与GitLab类似，Phabricator是一个多合一的产品，可以处理整个开发周期。通过它，您可以在不需要第三方应用的情况下，构建存储库，对任务添加注释，以及与团队成员顺畅地协作。

同时，在Phabricator的内部，您可以一站式地创建与管理各项任务，构建工作台，以及处理其他大量的工作。

主要特点：

- 使用Differential(请参见--<https://www.phacility.com/phabricator/differential/>)，您可以顺利查看到团队成员的代码，并留下反馈意见，以帮助他们提高代码的质量。
- 使用Diffusion(请参见--<https://www.phacility.com/phabricator/diffusion/>)来托管git、merurial或subversion存储库。当然，您也可以从其他位置添加现有的存储库。
- 与Herald(请参见--<https://www.phacility.com/phabricator/herald/>)一起使用时，无论您的代码当前处于什么阶段，您都可以触发审核，甚至可以在提交后审核代码。
- 使用Maniphest(请参见--<https://www.phacility.com/phabricator/maniphest/>)，您可以跟踪问题中的错误，为人员分配各种任务，甚至为组织中的每个部门构建单独的任务表。您还可以访问到工作板和sprints，并使用拖放的功能，轻松地在板上管理和组织各个项目。
- 通过Arcanist(为命令行专业人员准备的工具，请参见--<https://www.phacility.com/phabricator/arcanist/>)，您可以在审查代码之前运行lint和单元测试，并自动打上应用补丁。而且Arcanist可以在Windows、Mac OS X和Linux上流畅地运行。

### [Codeberg](https://codeberg.org/)

Codeberg由一个来自德国的非营利性的非政府组织所创建的。它致力于为开源社区提供全新的安全产品。因此，Codeberg声称：为了保持代码的安全，他们不会跟踪或出售用户的数据。目前，它已拥有3,000多名用户。

在创建帐户并成功登录之后，您将获得登录GitHub的镜像、以及免费的私有和公共存储库。在此基础上，您可以创建问题、拉取式请求、以及Wiki等。为了方便协作，Codeberg允许用户对项目进行注释，甚至添加表情符号等。同时，它还提供一种夜间的主题风格。

**优势**

Codeberg是一个独立且完全开源的平台。因此，它不但简单易用，而且根本不会追踪或出售用户的数据。

**劣势**

Codeberg缺少用户指南之类的文档。由于是一个小众的平台，因此其用户群远不及GitHub。

原标题：Top 13 GitHub Alternatives in 2020 [Free and Paid]  作者： Momchil Koychev