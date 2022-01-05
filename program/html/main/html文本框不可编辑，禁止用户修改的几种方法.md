# html文本框不可编辑，禁止用户修改的几种方法

Joker_Ye 2016-04-06 10:14:54  6278  收藏 2
版权
解决思路： 
在文本框的内容只作于演示而不允许用户随意修改时这样做就非常有必要。

具体步骤： 
方法一：设置readonly属性为true。


``` html
<input type="text" value="readonly" readonly>   
<input type="text" value="readonly" readonly>
```
方法二：设置disabled属性为true。


``` html
<input type="text" value="disabled" disabled>   
<input type="text" value="disabled" disabled>
```
方法三：在对象focus时立刻让它blur，使它无法获得焦点。

``` html
<input type="text" value="οnfοcus=this.blur()" οnfοcus="this.blur()">   
<input type="text" value="οnfοcus=this.blur()" οnfοcus="this.blur()">
```
提示：readonly和disabled的区别在于后者完全禁止与设置该属性的对象交互(表现为不可改写、不可提交等)。 readonly是可以提交的

特别提示 
代码运行效果如图1.4.16所示。 

图1.4.16 禁止输入的文本框

特别说明

本例需要了解readonly和disabled属性的用法，两属性的区别见第三部分问题43。需要掌握的一个技巧是如何让对象得不到焦点，主是要下面的事件或方法的应用： 
- onfocus当对象获得焦点时触发。 
- focus使对象得到焦点。 
- onblur在对象失去输入焦点时触发。 
- blur模糊对象的内容以便使其看起来失去焦点。

