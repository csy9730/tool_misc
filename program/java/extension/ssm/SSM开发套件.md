## SSM开发套件



SSM是三个人，两个S，一个M，这画面，想想都满是马赛克

嗯嗯，SSM其实是JAVAEE的一个开发套件，Spring，Springmvc（有段时间是Struts）和mybatis（以前叫ibatis），其实可以不太准确的对应java web开发的三个层，web层（springmvc），service层（spring）和DAO层（mybatis）。

为什么这三样会怎么的流行呢，这小孩没娘，说来话长了。

我的习惯是从解决问题的角度回答问题，这三样其实对应的是javaEE开发的三个问题。

​       spring的出现是因为Rod Johnson的一本书《Expert o-ne-on-One J2EE Design and Development》。当时正是EJB当道的时候。EJB由于速度慢，配置复杂，侵入性强（仿佛spring后来也被人这么说来着），备受大家的诟病。所以Rod Johnson横空出世，手持 IOC和AOP 利器，提出了POJO的理念，大力倡导业务代码的无侵入性。所以spring其实主要是把基础设施代码和业务代码尽可能的分开，各自不要干扰，而且能把BEAN都统一到spring container里面去，这样，bean的生老病死都由spring来管理，程序员就只需要关心业务怎么实现就好了，别一会实现功能，中间还要来段事务处理，后面还要加个数据库错误处理啥的。总而言之一句话，spring解决的问题就是尽可能的业务代码归业务代码，基础设施代码（日志、事务，异常，对外接口......）归基础设施代码，搞定解耦的问题。

​       腹黑吐槽：现在spring已经贼庞大了，一点都不简单，侵入性也不弱，用它主要是啥开源工具都和它能配对，它就是一个万国开源工具组装基地。

​       再说说另外要给S，这个S，有段时间是struts，现在基本都是springmvc，其实这两货主要解决的都是web层的问题，struts当年啊，也是web界的潮流一哥，可惜struts1和struts2基本就是两个产品，除了名字相同，其他就没啥关系了，搞得用struts的人很不爽，另外struts2出了很多漏洞BUG，渐渐的这个S就过渡给springmvc。springmvc因为是spring自家的东西，在spring逐渐成为javaEE中间件事实上的标准后，springmvc由于和spring结合的更紧密，现在就越来越多的人用springmvc来指代这个S啦。说了这么多暴露年龄的话，我们说回来，为什么要用springmvc。因为在早年（靠，又要暴露年龄），大家都在使用jsp直接写业务代码的时候，有前辈高人说业务代码和html都混杂在一起，不利于维护，提出了mvc的概念，就是要把展现（view），数据（model）和业务（controll）分开，所以就在web层又给分了三层，这样才有了springmvc这种工具的出现。所以，还是为了让业务解耦啊。

​      最后再说下mybatis。当年说三大框架其实是没mybatis什么事的，dao的扛把子是hibernate，这货号称不需要会sql就能搞数据库开发，描绘了一幅只要会OOP，走遍天下都不怕的蓝图。但象我这种的程序员，在还不不明白啥是OOP就会sql的人来说，毫无吸引力啊，而且当年hibernate封装的sql性能还有些问题，搞的很多DBA颇有怨言，于是很多程序员就转向了mybatis。

​      mybatis解决的问题主要是SQL查出的数据和业务数据对象对接的问题，即能用sql查数据，又能方便的转成java的数据对象，至于其他的缓存啊，DAO层的接口话，都是后面为了图方便的额外功能。目前其实mybatis有两派，一派是喜欢把sql直接用注解写到dao层对象上，一派是全自动生成CRUD的sql xml文件，我个人是喜欢用mybatis generator生成的xml文件的，广告时间，关注我的专栏：[编码花](https://zhuanlan.zhihu.com/c_1106228534267351040)，我以后肯定会写这方面的教程的。

​      学会三大件不难，但希望学习的时候能时刻提醒自己，为啥要用这三大件。俗话说，无利不起早，学个框架也要记住框架能解决什么问题，带来什么好处，这样在学习的过程中才不会迷失在功能学习的海洋中，忘记了为啥要学这个。