# MVVM
## MVC扩展



MVC

MVP
MVVM

### MVVM    
C（controller）：实现业务逻辑，数据的增删改查。在MVVM模式中一般把C层算在M层中，

只有在理想的双向绑定模式下，Controller 才会完全的消失。这种理想状态一般不存在。



一般来说，model和view是必不可少的，所以架构上只有C可以做更多文章。

Controller的增删改查部分可以自动单向绑定（Model->View) ，自动双向绑定(Model<=>View)，通过库提供。

Controller的特殊操作逻辑部分只能自行定义。



一般只有UI表单控件才存在双向数据绑定，非UI表单控件只有单向数据绑定。

单向数据绑定是指：M的变化可以自动更新到ViewModel，但ViewModel的变化需要手动更新到M（通过给表单控件设置事件监听）

双向数据绑定是指念：M的变化可以自动更新到ViewModel，ViewModel的变化也可以自动更新到M

双向绑定 = 单向绑定 + UI事件监听。双向和单向只不过是框架封装程度上的差异，本质上两者是可以相互转换的。

