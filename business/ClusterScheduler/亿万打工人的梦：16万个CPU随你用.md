# 亿万打工人的梦：16万个CPU随你用

[2020-11-05](https://fastonetech.com/blog/cluster-scheduler-20201105/)[4](javascript:;)[3837](https://fastonetech.com/blog/cluster-scheduler-20201105/)[0](https://fastonetech.com/blog/cluster-scheduler-20201105/#comments)



**如果有一天，你有16万个CPU，你要怎么用？**
梦想还是要有的，万一它实现了呢？

**首先，你要有个调度器。**

我们现在说的调度器，主要是**基于HPC场景的集群任务调度系统**，英文叫Cluster Scheduler、Job Scheduler等。

**市面上主流调度器有四大流派：LSF/SGE/Slurm/PBS。**
不同行业因为使用习惯和不同调度器对应用的支持力度不同，往往会有不同的偏好：**比如高校和超算经常用Slurm，半导体公司最常用的是LSF和SGE，工业制造业可能用PBS更多一些。**

**调度器是干嘛的？**
如果有一台或者几台机器，专属你所有，你可以抱着他们一直**持续而缓慢地用下去**，调度器是没什么用武之地的。
那什么场景需要呢？**资源紧张或者时间紧张的时候。**
为啥紧张就需要呢？**因为需要最大程度压榨现有资源或时间的最大价值。**

**比如验证跑个regression，如何做到几万个test case并行？**
**用1台机器做分子对接和1000台有什么区别？100000台呢？**

举个例子。
这是上次那篇 [15小时虚拟筛选10亿分子，《Nature》+HMS验证云端新药研发未来](https://fastonetech.com/blog/biotech-fastone-help-hms-on-molecules-selection-20200709/) 文章里哈佛大学医学院用**云端16万个CPU来筛选10亿种化合物**，只用了15小时。
这是他们提供的**超大规模计算集群上的工作流程图**：

![调度器-生信分析-高性能计算集群-化合物筛选](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558113-0-1024x948.png)

蓝色框表示计算节点，其中包含CPU核数（蓝色框内的黑色正方形），紫色小圆圈代表待处理的配体。整张图代表整个计算集群，并行运行1.1到X.1个任务，任务1.1完成后会自动运行任务1.2，以此类推直到任务完成。
每个任务（包含多个子任务）使用3个计算节点，每个节点有8个CPU核。

**假设我们有10亿化合物需要筛选，面对16万CPU，把流程图里缺乏的时间维度考虑进来，我们可以多思考几个问题：**

1. **16万CPU，怎么顺利一一配置，启动，关闭？**
2. **怎么能让集群整体资源利用率最高？跑更多任务？**
3. **能不能指定特定任务在某种类型计算节点上运行？**
4. **任务之间存在先后顺序，能否确保特定任务一定先运行？**
5. **怎么统计和限制不同用户的用量？**
6. **怎么监控每个节点的状态和使用情况？**
7. **怎么降低集群的整体运行成本？避免浪费？**
8. **计算节点间网络/数据传输怎么考虑？**
9. **如何应对云上集群资源高度动态的特性？空闲资源不足时怎么办？**
   ……

当然，有些事已经不属于调度器的范畴了，这次我们不展开。

如果还不是特别明白，再打个比方。认真想像一下你是老板，手里有且只有100个打工人，你想想要怎么管理才能让他们更好地为你工作？？

好了，灵魂科普就到这里。
**今天我们基于这几家主流调度器：LSF/SGE/Slurm/PBS以及它们的不同演化版本进行了梳理和盘点，尤其是对云的支持方面划了重点。**

以下是正文。

#### **LSF流派** **Spectrum LSF、PlatformLSF、OpenLava**

**基于LSF（Load Sharing Facility）的调度器主要有Spectrum LSF、PlatformLSF、OpenLava三家。**

早期的LSF是由Toronto大学开发的Utopia系统发展而来。
2007年，**Platform Computing**基于早期老版本的LSF开源了一个简化版Platform Lava。

这个开源项目2011年中止了，被**OpenLava**接手。
2011年，Platform员工David Bigagli基于Platform Lava的派生代码创建了OpenLava 1.0。2014年，一些Platform的员工成立了Teraproc公司，为OpenLava提供开发和商业支持。**2016年IBM就LSF版权对Teraproc公司发起诉讼，2018年IBM胜诉，OpenLava被禁用。**

![OpenLava调度器-信息](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558115-1-e1604558482516.png)

2011年，Platform Lava开源项目中止后。**2012年1月，IBM收购了Platform Computing。Spectrum LSF**就是IBM收购后推出的商用版本，目前更新到10.1.0，同时支持Linux和Windows，最大节点数超过6000，在国内提供商业支持。
**Platform LSF**是LSF的早期版本，与Spectrum LSF一样属于IBM，目前版本是9.1.3，目测已经停止更新以维护为主。

![Platform LSF调度器-信息](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558116-2.png)

![调度器-Spectrum LSF信息](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558116-3.png)

在这三个调度器中，仅有**Spectrum LSF**支持Auto-Scale集群自动伸缩功能，同时该调度器还可通过**LSF resourceconnector**实现溢出到云，支持云厂商包括AWS、Azure、Google Cloud。

#### **SGE流派** **UGE、SGE**

**基于SGE（Sun Grid Engine）的调度器包括UGE（Univa Grid Engine）和SGE（Son of Grid Engine）。**

1993年，**Grid Engine**作为商业软件发布，先后使用了**CODINE**（Computing in Distributed Networked Environments）、**GRD**（Global Resource Director）作为名称。1999年，第一次由Genias Software推出市场，然后被Gridware公司收购。直到2000年被SUN收购之后正式改名**Sun Grid Engine**，2001年发布开源版。

2010年被Oracle收购后改名**Oracle Grid Engine**，改成闭源版，不提供源代码。原来开源项目的资料库禁止用户修改。
于是，Grid Engine社区开始开源版本的**SGE**（**Son of Grid Engine**）项目。该调度器最后一次更新为2016年的8.1.9，由于存在版权风险，SGE已长期无维护和更新。

![调度器-SGE信息](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558116-4.png)

2013年Univa收购了Oracle Grid Engine，成为唯一商业软件**UGE（Univa Grid Engine）**提供商。UGE最新版本为8.6.15，同时支持Linux和Windows，国内暂无商业支持的相关信息。
2020年9月，Altair收购了Univa。

![调度器-UGE信息](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558117-5.png)

用户可通过Univa产品**Navops Launch**把工作负载移到云端，同时支持UGE和Slurm集群。同时，Navops Launch支持AWS、Azure、Google Cloud等云厂商，并能进行云端费用监控以及Auto-Scale集群自动伸缩。

#### **Slurm-四大流派里唯一纯开源派** 

**Slurm全称为Simple Linux Utility for Resource Management**，前期主要由劳伦斯利弗莫尔国家实验室、SchedMD、Linux NetworX、Hewlett-Packard 和 Groupe Bull 负责开发，受到闭源软件Quadrics RMS的启发。

Slurm最新版本为20.02，目前由社区和SchedMD公司共同维护，**保持开源和免费**，由SchedMD公司提供商业支持，仅支持Linux系统，最大节点数量超过12万。
Slurm拥有容错率高、支持异构资源、高度可扩展等优点，每秒可提交超过1000个任务，且由于是开放框架，高度可配置，拥有超过100种插件，因此适用性相当强。

![调度器-Slurm信息](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558117-6.png)

**全球60%的TOP500超算中心和超大规模集群（包括我国的天河二号等）都采用Slurm作为调度系统。我们的TOP500就是用Slurm调度云上资源跑的。**[上榜啦～花费4小时5500美元，速石科技跻身全球超算TOP500](https://fastonetech.com/blog/top500/)

我们支持在Slurm上的集群自动伸缩和云端费用监控，并支持AWS、阿里云、Azure、腾讯云、华为云、Google Cloud等云厂商。
**fastone的Auto-Scale功能可以自动监控用户提交的任务数量和资源的需求，动态按需地开启所需算力资源，在提升效率的同时有效降低成本。**

**EDA云实证Vol.1：从30天到17小时，如何让HSPICE仿真效率提升42倍？ 这篇主要看通过我们自动化部署和手动部署的差别。**

**CAE云实证Vol.2：从4天到1.75小时，如何让Bladed仿真效率提升55倍？**

**生信云实证Vol.3：提速2920倍！用AutoDockVina对接2800万个分子  这篇主要看我们基于用户不同的策略，跨区、跨类型自动为用户调度云资源，如何以最快速度or最低成本完成计算任务。**

#### **PBS流派** **OpenPBS、PBS PRO、Moab/TORQUE**

**基于PBS（Portable Batch System）的调度器包括OpenPBS、PBS PRO、Moab/TORQUE。**

PBS最初是由MRJ Technology Solutions于 1991 年 6 月开始为 NASA 所研发的作业调度系统，MRJ于 20 世纪90 年代末被 Veridian 收购。2003年，Altair收购了Veridian，获得了PBS的技术和知识产权。
**PBS Pro**是Altair旗下PBS WORKS提供的商业版本，支持可视化界面，节点数超过50000个。

![调度器-PBS PRO信息](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558117-7.png)

2016年Altair基于**P****BS Pro**提供了开源许可版本，其与MRJ于1998年发布的原始开源版本两者合二为一大致就是现在的**OpenPBS**。与Pro版本比，多了很多限制，但都支持Linux和Windows。

![OpenPBS调度器-资料](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558118-8.png)

**Moab/TORQUE合在一起是一个完整调度器的功能，现在属于同一家公司Adaptive Computing。**90年代中期由MHPCC的David Jackson开发的Maui，他后来创立了Adaptive Computing。

**Moab**是Adaptive Computing 公司（前身为 Cluster Resources 公司开发的Maui Cluster Scheduler）维护的 OpenPBS 分支，2003年发布。该项目最初是开源免费的，后来变成了商用软件Moab后不再免费。

**TORQUE**（Terascale Open-source Resource and QUEue Manager）早期的 Torque 也是开源免费软件，不过 2018 年 6 月开始 TORQUE 不再开源。
两者均只支持Linux系统，提供可视化界面，拥有约数千个节点。

![调度器-Moab/TORQUE](https://fastonetech.com/blog/wp-content/uploads/2020/11/1604558118-9.png)

云服务方面，PBS Pro能通过**Altair Control产品**从本地溢出到多云和Auto-Scale集群自动伸缩，支持的云厂商包括AWS、Azure和Google Cloud。

Moab/TORQUE 则可通过 **NODUSCloud OS 产品**实现本地扩展到云，支持TORQUE 或 Slurm集群和自动伸缩，可支持的云厂商包括AWS、Azure、GoogleCloud 和华为云，并通过 Account Manager 产品实现云端费用监控。

我们整理了一张包含上述四大类共9种调度器在内的信息集成表，有兴趣的可以文末扫码添加小F微信（ID：imfastone），回复“**调度器**”获取原始表单。

预告一下，在下一篇EDA云实证Vol.4中，我们在相同场景下使用不同调度器进行了云端验证，敬请期待吧！

**- END -**

**2分钟自动开通，即刻获得TOP500超级算力点击下图立即体验**

[![SaaS计算云-在线体验版](https://fastonetech.com/blog/wp-content/uploads/2020/10/1603262368-12-1024x518.jpg)](https://fastonetech.com/regist)

**2020年新版《六大云厂商资源价格对比工具包》**
**添加小F微信（ID: imfastone）获取**

![云比价报告](https://fastonetech.com/blog/wp-content/uploads/2020/10/1603262380-13.jpg)

**你也许想了解具体的落地场景：**
**生信云实证Vol.3：提速2920倍！用AutoDock Vina对接2800万个分子CAE云实证Vol.2：从4天到1.75小时，如何让Bladed仿真效率提升55倍？**
**EDA云实证Vol.1：从30天到17小时，如何让HSPICE仿真效率提升42倍？**
**15小时虚拟筛选10亿分子，《Nature》+HMS验证云端新药研发未来**

**关于云端高性能计算平台：**
**国内超算发展近40年，终于遇到了一个像样的对手帮助CXO解惑上云成本的迷思，看这篇就够了**
**灵魂画师，在线科普多云平台/CMP云管平台/中间件/虚拟化/容器是个啥**
**花费4小时5500美元，速石科技跻身全球超算TOP500**