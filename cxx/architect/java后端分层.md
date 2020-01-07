# 后端分层

 MVC 架构对应Controller，service，model，
1. Controller
2. service
3. model，
4. sql

更加细分的架构：
1. Controller
2. app
3. domain
4. model，
5. sql

协议转化，接口转化的场景，按照分层职责，代码你可以写在 controller 层。
spi属于特殊层，在doamin层之上，
App 层的职责：流程编排。事务控制。

Infrastructure 中文翻译为基础设施层，主要放一些技术框架的，比如说消息队列中间件、分布式缓存框架、流程引擎、规则引擎、Mysql 数据库等等，
DAO：数据库访问层。主要负责“操作数据库的某张表，映射到某个java对象”，dao应该只允许自己的Service访问，其他Service要访问我的数据必须通过对应的Service。
Model 数据持久层 数据模型（表）一一对应。无业务逻辑。

1. VO 显示层对象，通常是Web向模板渲染引擎层传输的对象。 
2. AO 应用对象。在Web层与Service层之间抽象的复用对象模型，极为贴近展示层，复用度不高。 
3. BO 业务对象。由Service层输出的封装业务逻辑的对象。 
4. DTO 数据传输对象，Service或Manager向外传输的对象。 
5. DO 与数据库表结构一一对应，通过DAO层向上传输数据源对象。
