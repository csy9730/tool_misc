## [jquery控制元素的隐藏和显示的几种方法。](https://www.cnblogs.com/sdd53home/p/5250832.html)

组织略显凌乱，请耐心看！

 

使用jquery控制div的显示与隐藏，一句话就能搞定，例如：

1.$("#id").show()表示为display：block，

   $("#id").hide()表示为display:none;

2.$("#id").toggle()切换元素的可见状态。如果元素是可见的，切换为隐藏的；如果元素是隐藏的，则切换为可见的。

3.$("#id").css('display','none');//隐藏

   $("#id").css('display','block');//显示

   或者

   $("#id")[0].style.display='none';

　　display=none 控制对象的隐藏![搜索](http://img.baidu.com/img/iknow/qb/select-search.png)
　　display=block控制对象的显示

4.$("#id").css('visibility','hidden');//元素隐藏

   $("#id").css('visibility','visible');//元素显示

CSS visibility 属性规定元素是否可见。
visible　元素可见。 
hidden　元素不可见。 
collapse　在表格元素中使用时，此值可删除一行或一列，但它不影响表格的布局。被行或列占据的空间会留给其他内容使用。如果此值被用在其他的元素上，会呈现为 "hidden"。 
inherit　从父元素继承 visibility 属性的值。

注意：

display:none和visible:hidden都能把网页上某个元素隐藏起来，在视觉效果上没有区别，但是在一些DOM操作中两者有区别:

display:none ---不为被隐藏的对象保留其物理空间，即该对象在页面上彻底消失，通俗来说就是看不见也摸不到。

visible:hidden--- 使对象在网页上不可见，但该对象在网页上所占的空间没有改变，即它仍然具有高度、宽度等属性，通俗来说就是看不见但摸得到。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
//第1种方法 ,给元素设置style属性  
$("#hidediv").css("display", "block");  
//第2种方法 ,给元素换class，来实现隐藏div，前提是换的class样式定义好了隐藏属性  
$("#hidediv").attr("class", "blockclass");  
//第3种方法,通过jquery的css方法，设置div隐藏  
$("#blockdiv").css("display", "none");  
  
$("#hidediv").show();//显示div    
$("#blockdiv").hide();//隐藏div 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 



分类: [Jquery](https://www.cnblogs.com/sdd53home/category/795970.html)