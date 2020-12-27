# [jquery操作select(取值，设置选中）](https://www.cnblogs.com/lgx5/p/11059009.html)

**一、基础取值问题**

例如<select class="selector"></select>

1、设置value为pxx的项选中

   $(".selector").val("pxx");

2、设置text为pxx的项选中

  $(".selector").find("option:contains('pxx')").attr("selected",true);

  **注意**：之前$(".selector").find("option[text='pxx']").attr("selected",true);这种写法是错误的，目前个人证实input支持这种获取属性值的写法："input[text='pxx']"，select中需要"option:contains('pxx')"这样获取。

  这里有一个中括号的用法，中括号里的等号的前面是属性名称，不用加引号。很多时候，中括号的运用可以使得逻辑变得很简单。

3、获取当前选中项的value

  $(".selector").val();

4、获取当前选中项的text

  $(".selector").find("option:selected").text();

  这里用到了冒号，掌握它的用法并举一反三也会让代码变得简洁。

 

二、很多时候用到**select的级联**，即第二个select的值随着第一个select选中的值变化。这在jquery中是非常简单的。

如：$(".selector1").change(function(){

   // 先清空第二个

   $(".selector2").empty();

   // 实际的应用中，这里的option一般都是用循环生成多个了

   var option = $("<option>").val(1).text("pxx");

   $(".selector2").append(option);

});

[ ](http://www.cnblogs.com/yaoshiyou/archive/2010/08/24/1806939.html)

**三、jQuery获取Select选择的Text和Value:**


语法解释：
\1. $("#select_id").change(function(){//code...});  //为Select添加事件，当选择其中一项时触发
\2. var checkText=$("#select_id").find("option:selected").text(); //获取Select选择的Text
\3. var checkValue=$("#select_id").val(); //获取Select选择的Value
\4. var checkIndex=$("#select_id ").get(0).selectedIndex; //获取Select选择的索引值
\5. var maxIndex=$("#select_id option:last").attr("index"); //获取Select最大的索引值

 


**四、jQuery设置Select选择的 Text和Value:**


语法解释：
\1. $("#select_id ").get(0).selectedIndex=1; //设置Select索引值为1的项选中
\2. $("#select_id ").val(4);  // 设置Select的Value值为4的项选中
\3. $("#select_id option[text='jQuery']").attr("selected", true);  //设置Select的Text值为jQuery的项选中

 

**五、jQuery添加/删除Select的Option项：**
语法解释：
\1. $("#select_id").append("<option value='Value'>Text</option>"); //为Select追加一个Option(下拉项)
\2. $("#select_id").prepend("<option value='0'>请选择</option>"); //为Select插入一个Option(第一个位置)
\3. $("#select_id option:last").remove(); //删除Select中索引值最大Option(最后一个)
\4. $("#select_id option[index='0']").remove(); //删除Select中索引值为0的Option(第一个)
\5. $("#select_id option[value='3']").remove(); //删除Select中Value='3'的Option
\5. $("#select_id option[text='4']").remove(); //删除Select中Text='4'的Option

 

**六、jquery radio取值，checkbox取值，select取值，radio选中，checkbox选中，select选中，及其相关** 


1 获取一组radio被选中项的值 
var item = $('input[name=items][checked]').val(); 


2 获取select被选中项的文本 
var item = $("select[name=items] option[selected]").text();

 
3 select下拉框的第二个元素为当前选中值 
$('#select_id')[0].selectedIndex = 1; 


4 radio单选组的第二个元素为当前选中值 
$('input[name=items]').get(1).checked = true; 

 

**七、获取值**： 
文本框，文本区域：$("#txt").attr("value")； 
多选框 checkbox：$("#checkbox_id").attr("value")； 
单选组radio：  $("input[type=radio][checked]").val(); 
下拉框select： $('#sel').val(); 


**八、控制表单元素：** 
文本框，文本区域：$("#txt").attr("value",'');//清空内容 
$("#txt").attr("value",'11');//填充内容 
多选框checkbox： $("#chk1").attr("checked",'');//不打勾 
$("#chk2").attr("checked",true);//打勾 
if($("#chk1").attr('checked')==undefined) //判断是否已经打勾 
单选组 radio：  $("input[type=radio]").attr("checked",'2');//设置value=2的项目为当前选中项 
下拉框 select：  $("#sel").attr("value",'-sel3');//设置value=-sel3的项目为当前选中项 
$("<option value='1'>1111</option><option value='2'>2222</option>").appendTo("#sel")//添加下拉框的option 
$("#sel").empty()；//清空下拉框

 

**九、判断在select 是否存在某个value 的 option：** 

```
function` `is_Exists(selectid,value){
 ``var` `theid=``'#'``+selectid;
 ``var` `count=$(theid).get(0).options.length;
 ``var` `isExist = ``false``;
```

` ``for``(``var` `i=0;i

```
  ``if` `($(theid).get(0).options[i].value == value){
   ``isExist=``true``;
   ``break``;
  ``}
 ``}
 ``return` `isExist;
}
```

分类: [Jquery](https://www.cnblogs.com/lgx5/category/800385.html)