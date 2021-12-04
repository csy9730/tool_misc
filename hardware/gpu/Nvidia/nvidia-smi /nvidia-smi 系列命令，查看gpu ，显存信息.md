# [nvidia-smi 系列命令，查看gpu ，显存信息](https://www.cnblogs.com/wsnan/p/11769838.html)



转载于：<https://www.cnblogs.com/dahu-daqing/p/9288157.html>

 显卡包含gpu，显存，gpu不等于显存

## nvidia-smi 的定义：

1. 基于 NVIDIA Management Library （NVIDIA 管理库），实现 NVIDIA GPU 设备的管理和监控功能
2. 主要支持 Tesla, GRID, Quadro 以及 TitanX 的产品，有限支持其他的 GPU 产品
   所以我们在常见的 NVIDIAGPU 产品上安装完驱动后，都同时安装上 nvidia-smi 管理工具，帮助管理人员通过命令行的方式对 GPU 进行监控和管理。
   当我们成功部署了 GRID 软件以后，我们可以通过以下 nvidia-smi 命令实现对 GPU 的管理。
   nvidia-smi 会随着 GRID 软件不断的升级，而功能不断的丰富，所以当我们在执行一些复杂的 nvidia-smi 命令时，可能早期的 GRID 版本无法支持这些命令。
   以下 nvidia-smi 常用命令行是个人推荐了解的：

#### nvidia-smi

![pic](https://img-blog.csdn.net/20170315105606960?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvc2FsbHl4eWwxOTkz/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

这是服务器上特斯拉 K80 的信息。
上面的表格中：
第一栏的 Fan：N/A 是风扇转速，从 0 到 100% 之间变动，这个速度是计算机期望的风扇转速，实际情况下如果风扇堵转，可能打不到显示的转速。有的设备不会返回转速，因为它不依赖风扇冷却而是通过其他外设保持低温（比如我们实验室的服务器是常年放在空调房间里的）。
第二栏的 Temp：是温度，单位摄氏度。
第三栏的 Perf：是性能状态，从 P0 到 P12，P0 表示最大性能，P12 表示状态最小性能。
第四栏下方的 Pwr：是能耗，上方的 Persistence-M：是持续模式的状态，持续模式虽然耗能大，但是在新的 GPU 应用启动时，花费的时间更少，这里显示的是 off 的状态。
第五栏的 Bus-Id 是涉及 GPU 总线的东西，domain:bus:device.function
第六栏的 Disp.A 是 Display Active，表示 GPU 的显示是否初始化。
第五第六栏下方的 Memory Usage 是显存使用率。
第七栏是浮动的 GPU 利用率。
第八栏上方是关于 ECC 的东西。
第八栏下方 Compute M 是计算模式。
下面一张表示每个进程占用的显存使用率。

显存占用和 GPU 占用是两个不一样的东西，显卡是由 GPU 和显存等组成的，显存和 GPU 的关系有点类似于内存和 CPU 的关系。

![pic](http://p.cdn.sohu.com/bc4e413e/3644b76ce565ef135277f538d1c66087.jpeg)

#### nvidia-smi -q

查看当前所有 GPU 的信息，也可以通过参数 i 指定具体的 GPU。
比如 nvidia-smi-q -i 0 代表我们查看服务器上第一块 GPU 的信息。
通过 nvidia-smi -q 我们可以获取以下有用的信息：
GPU 的 SN 号、VBIOS、PN 号等信息：

可以参考 [了解 GPU 从 nvidia-smi 命令开始](http://hui.sohu.com/infonews/article/6337322514200395777)

#### windows 上的使用

nvidia-smi 所在的位置为：
C:\Program Files\NVIDIA Corporation\NVSMI

cmd 进入目录输入命令即可：
![pic](http://www.luozhipeng.com/wp-content/uploads/2017/08/img_5990065aa1254.png)

 

**nvidia-smi --help-query-gpu:**

"memory.total"
Total installed GPU memory.

"memory.used"
Total memory allocated by active contexts.

"memory.free"
Total free memory.

```cpp
 nvidia-smi --query-gpu=timestamp,memory.total,memory.free,memory.used,name,utilization.gpu,utilization.memory --format=csv -l 5
```

nvidia-smi --format=csv,noheader,nounits --query-gpu=timestamp,index,memory.total,memory.used,memory.free,utilization.gpu,utilization.memory -lms 500 -f smi-1-90s-instance.log

计算程序运行时间段内 平均显存使用情况

 

显存：显卡的存储空间。

```cpp
nvidia-smi 查看的都是显卡的信息，里面memory是显存

top:
```

如果有多个gpu，要计算单个GPU，比如计算GPU0的利用率：

1 先导出所有的gpu的信息到 smi-1-90s-instance.log文件：

nvidia-smi --format=csv,noheader,nounits --query-gpu=timestamp,index,memory.total,memory.used,memory.free,utilization.gpu,utilization.memory -lms 500 -f smi-1-90s-instance.log

2 GPU0的全部数据，将第一个gpu的信息导出到test.log里面

 awk  -F","  '{ if($2==0){print $0} } '  smi-1-90s-instance.log >> test.log

3 再cat smi-1-90s-instance.log | awk '{sum7+=$7;count++}END{print sum7/count}'



```cpp
https://javawind.net/html5-apple-watch-clock-face/index.html


top；将动态刷新的信息写入到文件中

top   -d   0.5   -b|grep   hello|tee   -a  >top.txt
将动态产生的系统信息放入文件中
```