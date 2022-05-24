# GoCD从入门到放弃 - 基础使用

![img](https://upload.jianshu.io/users/upload_avatars/14767481/f0ed4458-f7db-474f-ae49-3b626fd3e802?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[波波茶三分甜](https://www.jianshu.com/u/f26f7201459b)关注

0.992018.11.18 21:49:02字数 1,956阅读 19,012



![img](https://upload-images.jianshu.io/upload_images/14767481-d9ac6b0a1bdae105.png?imageMogr2/auto-orient/strip|imageView2/2/w/183/format/webp)

GoCD，一个开源的持续集成和持续交付系统，可以在持续交付过程中执行编译，自动化测试，自动部署等等，于Jenkins类似。GoCD的基础架构由Server和Agent组成：

\- Server负责控制一切（配置），轮询材料（如代码仓库）的变化，检测到材料变化需要触发Pipeline时，将Job分配给Agent去执行

\- Agent接收Server分配的Job，执行Job下的Task（运行命令、部署等），并将Job的状态报告给Server，由Server整理信息判断该Job所处Stage的状态

\- 每个部署业务的机器上都必须安装Agent





![img](https://upload-images.jianshu.io/upload_images/14767481-bc57b92dc344ba50.png?imageMogr2/auto-orient/strip|imageView2/2/w/215/format/webp)

server和agent的关系

### 1. GoCD中的一些基本概念

[    Task](https://docs.gocd.org/current/introduction/concepts_in_go.html#task) - 任务

​        任务或构建任务是需要执行的操作，通常每个Task只是一个命令。

[    Job](https://docs.gocd.org/current/introduction/concepts_in_go.html#job) - 工作

​     Job由多个Task组成，每个Job将按照顺序依次运行，运行过程中如果当前Task失败，则整个Job为失败，且后续Task不再运行。

​     Job中的每个Task都是作为一个独立的程序来运行的，因此，Task对其任何环境变量所做的更改都不会影响后续Task。 后续Task可以看到系统所做的任何更改。

[    Stage](https://docs.gocd.org/current/introduction/concepts_in_go.html#stage) - 阶段

​    一个Stage由多个Job组成，在一个Stage里，每个Job都是独立于其他Job的，这意味着GoCD可以并行执行多个Job，如果某一个Job运行失败，则这个Stage运行失败；但是这不影响其他Job的运行。

[    Pipeline](https://docs.gocd.org/current/introduction/concepts_in_go.html#pipeline) - 管道

​    一个Pipeline由多个Stage组成，每个Stage都将按照顺序运行，如果某一个Stage运行失败，后续的Stage则不会运行。



![img](https://upload-images.jianshu.io/upload_images/14767481-9c73699a4bc48819.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

一个简单的Pipeline，由三个Stage组成

[    Materials and triggers](https://docs.gocd.org/current/introduction/concepts_in_go.html#materials) - 材料和触发器

​    很显然如果没有水，管道妥妥是空的，通常Material是代码存储仓库，它可以支持Git、SVN、Mercurial等等。GoCD不断轮询查找是否有新的提交，如果有新的提交则重新运行Pipeline。它还支持定时触发器，多种代码仓库。

[  ·  Pipeline Dependencies](https://docs.gocd.org/current/introduction/concepts_in_go.html#pipeline_dependency) - 管道依赖关系

​    不同Pipeline之间可以设置触发，如下图所示，Pipeline1的Stage1和Stage2都可以触发Pipeline2的运行。





![img](https://upload-images.jianshu.io/upload_images/14767481-e157204114f0b8d2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

[    Value Stream Map](https://docs.gocd.org/current/introduction/concepts_in_go.html#vsm) - 价值流图（VSM）

​    端到端的Pipeline全局图





![img](https://upload-images.jianshu.io/upload_images/14767481-a550c2daa6d705d2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

[    Artifacts](https://docs.gocd.org/current/introduction/concepts_in_go.html#artifacts) - 工件

​    Artifacts一般是文件或者文件夹，当job执行完毕后会发布Artifacts，供给用户、后续执行的stage或pipeline使用。

[    Agent](https://docs.gocd.org/current/introduction/concepts_in_go.html#agent) & [Resources](https://docs.gocd.org/current/introduction/concepts_in_go.html#resources)- 代理 & 资源

​    Agent: 执行job的go节点。

​    Resource： 标记agent的标签，标识agent上有哪些资源，用来判断再该agent上是不是可以执行某种任务。

​    如下图所示，

​    1.任务1可以由GoCD服务器分配给代理1或3。

​    2.作业2只能分配给代理1(因为它是提供Linux资源的唯一代理)。

​    3.作业3只能分配给代理1(因为它是提供这两种资源的唯一代理)。4.工作4可以分配给任何三个代理，因为这个工作不需要特殊的资源匹配。

​    注意，代理3有一个Apple资源并不能阻止它被分配工作。它恰好是一种资源，它不需要任何显示的工作。





![img](https://upload-images.jianshu.io/upload_images/14767481-632e31d092ccb138.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

[Environment](https://docs.gocd.org/current/introduction/concepts_in_go.html#environment)  & [ Environment Variables](https://docs.gocd.org/current/introduction/concepts_in_go.html#environment_variables)- 环境和环境变量

*"Environment" 用来对对pipeline和agent进行分组. 分组规则如下:*

\1. 一个pipeline 最多属于一个environment。

\2. 一个agent可以与任意个environments关联。

\3. 一个agent可以执行与其关联的environment中的pipeline里的job。

\4. 一个与environment关联的agent不能执行没有与其关联的environment中的pipeline里的job。

*Environments Variables的定义优先级从高到低依次如下*：

Job > Stage > Pipeline > Environment



![img](https://upload-images.jianshu.io/upload_images/14767481-000b79194671cb22.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

### 2. GoCD中的基本组件

#### 2.1 GoCD仪表板



![img](https://upload-images.jianshu.io/upload_images/14767481-d0eee995028d9af5.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

#### 2.2 查看Agent

Agents页面列出了服务器可用的所有Agent和它们当前的状态。

当代理首次连接到服务器时，它是“Pending”(挂起状态)。管理员必须在GoCD将工作安排在该Agent之前启用Agent。

管理员也可以禁用Agent。GoCD不会为一个被禁用的Agent安排工作。如果在Agent被禁用时正好有一项工作正在该Agent上建立，则该工作将被完成;然后才禁用Agent。管理员在重新安排工作之前需要启用Agent。

管理员可以选择删除不再需要的Agent。在删除Agent之前，必须禁用该Agent。处于(building)状态或者(cancelled)状态的Agent不能被删除。





![img](https://upload-images.jianshu.io/upload_images/14767481-e36e5bf5c0969e15.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

#### 2.3 查看Agent详情

此界面可以查看每个Agent的详细配置信息以及运行信息





![img](https://upload-images.jianshu.io/upload_images/14767481-14f659ec907f4214.png?imageMogr2/auto-orient/strip|imageView2/2/w/1002/format/webp)





![img](https://upload-images.jianshu.io/upload_images/14767481-2a03be4b51d7b6b5.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

#### 2.4 Pipeline Activity界面

Pipeline Activity界面显示了当前Pipeline所有运行情况





![img](https://upload-images.jianshu.io/upload_images/14767481-bdac850c4c93a231.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

#### 2.5 Stage / Job详情

选择上面任何一个颜色块都可以进入所属Stage/Job的详细界面





![img](https://upload-images.jianshu.io/upload_images/14767481-eb5c5b2df00ff94f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)





![img](https://upload-images.jianshu.io/upload_images/14767481-6011296a34169ecd.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

#### 2.6 GoCD管理

有四种配置管道的方法

​    通过管理界面来配置管道。

​    通过管理界面的“Config XML”选项卡直接编辑XML。

​    还可以通过调用[配置API](https://api.gocd.org/current/#pipeline-config)来配置管道

​    通过文件系统直接进行XML编辑进行配置后。默认情况下，Go服务器每5秒对文件系统进行轮询，以更改cruise-config.xml。该文件的位置显示在Admin >配置XML选项卡的右上角。





![img](https://upload-images.jianshu.io/upload_images/14767481-ff48ca489d2df59e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)



![img](https://upload-images.jianshu.io/upload_images/14767481-561dd29d547a4052.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

### 3. 如何配置GoCD

#### 3.1 创建新Pipeline

输入名称和所属Group





![img](https://upload-images.jianshu.io/upload_images/14767481-d2f8b6b5b3d83ece.png?imageMogr2/auto-orient/strip|imageView2/2/w/902/format/webp)

配置代码仓库，输入代码仓库地址

值得一提的是，这里有一个黑名单功能，可以指定一组GoCD在检查更改时应该忽略的文件。存储库变更集只包含这些文件不会自动触发管道。这些都在[配置参考资料](https://docs.gocd.org.cn/cn_book/configuration/configuration_reference.html)的[忽略](https://docs.gocd.org.cn/cn_book/configuration/configuration_reference.html#ignore)部分详细说明。





![img](https://upload-images.jianshu.io/upload_images/14767481-f5d914f81892567b.png?imageMogr2/auto-orient/strip|imageView2/2/w/1160/format/webp)

填写Stage和Job

填写默认Stage和Job的信息，包括名称，运行命令等，之后点击finish便完成啦





![img](https://upload-images.jianshu.io/upload_images/14767481-c8a1b03ed14b325b.png?imageMogr2/auto-orient/strip|imageView2/2/w/838/format/webp)

3.2 管理Pipeline及其依赖

每个Pipeline都有一个设置界面，如图所示





![img](https://upload-images.jianshu.io/upload_images/14767481-dc893354ad1a51aa.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

可以修改原料的代码仓库





![img](https://upload-images.jianshu.io/upload_images/14767481-b7ca3315bc97bd7a.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

可以管理Stage





![img](https://upload-images.jianshu.io/upload_images/14767481-af8e32eee0b089e2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

也可以管理Job





![img](https://upload-images.jianshu.io/upload_images/14767481-d4d1663fde5de95f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

3.3 管理Agent

在Agent页面，可以选择Agent，之后将其关闭或启用





![img](https://upload-images.jianshu.io/upload_images/14767481-7473b64c545a963f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

还可以在Job设置中配置Resources，再配置Agent的Resources，使Job运行于指定Agent上





![img](https://upload-images.jianshu.io/upload_images/14767481-dcb15a317d6e6581.png?imageMogr2/auto-orient/strip|imageView2/2/w/930/format/webp)





![img](https://upload-images.jianshu.io/upload_images/14767481-af4205c15d7eee90.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

3.4 锁定Pipeline

确保只有一个GoCD管道实例可以同时运行。

一般默认为第三种运行多个实例



![img](https://upload-images.jianshu.io/upload_images/14767481-d80584500005feb2.png?imageMogr2/auto-orient/strip|imageView2/2/w/826/format/webp)

第一种，只能运行一个实例（xbtest2），可以运行多个实例（xbtest3）



![img](https://upload-images.jianshu.io/upload_images/14767481-e77e11a61a18261a.png?imageMogr2/auto-orient/strip|imageView2/2/w/1144/format/webp)

第二种，运行管道的单个实例并锁定失败，当Stage运行失败的时候，依然保持锁定状态，不能触发新的Pipeline运行，直到手动解除锁定方可继续重新运行



![img](https://upload-images.jianshu.io/upload_images/14767481-1dd888aad745face.png?imageMogr2/auto-orient/strip|imageView2/2/w/550/format/webp)

3.5 定时器&超时处理

GoCD支持定时运行Pipeline功能，在设置中找到Timer Settings即可设置





![img](https://upload-images.jianshu.io/upload_images/14767481-f21aed05cb36ea87.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

也可通过XML设置，更多信息见 [< timer >](https://docs.gocd.org.cn/cn_book/configuration/configuration_reference.html#timer)



![img](https://upload-images.jianshu.io/upload_images/14767481-868e3dfa976e277f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1060/format/webp)

GoCD也可以自动取消超时的Job运行，在Job设置下可以配置





![img](https://upload-images.jianshu.io/upload_images/14767481-e30821d5ad81eed5.png?imageMogr2/auto-orient/strip|imageView2/2/w/1174/format/webp)

也可以在Pipeline下的Server Configuration配置超时设置





![img](https://upload-images.jianshu.io/upload_images/14767481-133ea519cc542d3a.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

3.6 用户管理

GoCD允许管理员控制对GoCD的访问并授予基于角色的权限，也可以设置角色，根据角色分配权限





![img](https://upload-images.jianshu.io/upload_images/14767481-1c5ab46319e1aff2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)



![img](https://upload-images.jianshu.io/upload_images/14767481-aef2d4ca8c0a961d.png?imageMogr2/auto-orient/strip|imageView2/2/w/757/format/webp)



![img](https://upload-images.jianshu.io/upload_images/14767481-db621f117e859415.png?imageMogr2/auto-orient/strip|imageView2/2/w/564/format/webp)

参考文章

https://www.jianshu.com/p/1b1de0b5441e