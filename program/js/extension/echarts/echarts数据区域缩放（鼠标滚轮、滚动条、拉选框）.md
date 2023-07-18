# [echarts数据区域缩放（鼠标滚轮、滚动条、拉选框）](https://www.cnblogs.com/caoxiaokang/p/9259955.html)



当一个echarts图表上的数据很多时，想要查看部分区域的数据状态，可以通过数据区域缩放来实现，现总结三个方法：

**鼠标滚轮缩放：**

 



```
 1 var arr = [];
 2 　　for(var i = 0;i<15;i++){
 3 　　　　arr.push(10*(Math.random()-0.5))
 4 　　}
 5 　　myCharts.setOption({
 6 　　　title:{
 7 　　　　text:"鼠标滚轮缩放数据"
 8 　　　},
 9 
10 　　　tooltip:{
11 　　　　trigger:'axis'
12 　　　},
13 
14 　　　xAxis:{
15 　　　　data:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
16 　　　},
17 
18 　　　dataZoom:[{
19 　　　　type:"inside"         //详细配置可见echarts官网
20 　　　}],
21 
22      series:[{
23 　　　　type:"line",
24 　　　　data:arr
25 　　　}]
26 　　})
```



 

//效果如下，当鼠标光驱在折线图上时，可以根据滚动鼠标滚轮来查看数据

![img](https://images2018.cnblogs.com/blog/1359583/201807/1359583-20180703175834100-1672349319.png)

**滚动条缩放：**　



```
 1 myCharts.setOption({
 2 
 3 　　　title:{
 4 　　　　text:"滚动条缩放数据"
 5 　　　},
 6 
 7 　　　tooltip:{
 8 　　　　trigger:'axis'
 9 　　　},
10 
11 　　　xAxis:{
12 　　　　data:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
13 　　　},
14 
15 　　　dataZoom:[{
16 　　　　type: 'slider',//图表下方的伸缩条
17 　　　　show : true, //是否显示
18 　　　　realtime : true, //拖动时，是否实时更新系列的视图
19 　　　　start : 0, //伸缩条开始位置（1-100），可以随时更改
20 　　　　end : 100, //伸缩条结束位置（1-100），可以随时更改
21 　　　}],
22 
23     　series:[{
24 　　　　type:"line",
25 　　　　data:arr
26 　　　}]
27 　　})
```



//效果如下，可以拖动底下滚动条来减小查看数据的范围或者拖动滚动条来确认查看哪里的数据

![img](https://images2018.cnblogs.com/blog/1359583/201807/1359583-20180703180019053-155312642.png)

**选框缩放：**

　　



```
 1 myCharts.setOption({
 2 
 3 　　　title:{
 4 　　　　text:"滚动条缩放数据"
 5 　　　},
 6 
 7 　　　tooltip:{
 8 　　　　trigger:'axis'
 9 　　　},
10 
11 　　　xAxis:{
12 　　　　data:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
13 　　　},
14 
15 　　　toolbox: {
16 　　　　show:true,
17 　　　　feature:{
18 　　　　　dataZoom: {
19 　　　　　　yAxisIndex:"none"
20 　　　　　},
21 　　　　　//其他功能性按钮查看官网进行增加，包括（显示数据，下载图片，改为柱状图等）
22 　　　　}
23 　　　},
24 
25     　　series:[{
26 　　　　type:"line",
27 　　　　data:arr
28 　　　}]
29 
30 　　})
```



//效果如下：可以在折线图上拉取选框来确定查看哪里的数据

 **![img](https://images2018.cnblogs.com/blog/1359583/201807/1359583-20180703180310245-465748865.png)**



[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)