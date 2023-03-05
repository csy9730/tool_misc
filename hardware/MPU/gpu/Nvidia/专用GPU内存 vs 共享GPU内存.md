# 专用GPU内存 vs 共享GPU内存

[![飞狗](https://pic1.zhimg.com/v2-de16fa5e9a4fa82e9025cc66e21112bc_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/huang-ling-xiao-18)

[飞狗](https://www.zhihu.com/people/huang-ling-xiao-18)

茫然的低欲青年


[https://www.it-swarm.cn/zh/tensorflow/%E5%9C%A8tensorflow%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%85%B1%E4%BA%ABgpu%E5%86%85%E5%AD%98%EF%BC%9F/836696536/www.it-swarm.cn/zh/tensorflow/%E5%9C%A8tensorflow%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%85%B1%E4%BA%ABgpu%E5%86%85%E5%AD%98%EF%BC%9F/836696536/](https://link.zhihu.com/?target=https%3A//www.it-swarm.cn/zh/tensorflow/%E5%9C%A8tensorflow%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%85%B1%E4%BA%ABgpu%E5%86%85%E5%AD%98%EF%BC%9F/836696536/)

[tensorflow - 在TensorFlow中使用共享GPU内存？www.it-swarm.cn/zh/tensorflow/%E5%9C%A8tensorflow%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%85%B1%E4%BA%ABgpu%E5%86%85%E5%AD%98%EF%BC%9F/836696536/](https://link.zhihu.com/?target=https%3A//www.it-swarm.cn/zh/tensorflow/%E5%9C%A8tensorflow%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%85%B1%E4%BA%ABgpu%E5%86%85%E5%AD%98%EF%BC%9F/836696536/)

[https://www.it-swarm.cn/zh/tensorflow/%E5%9C%A8tensorflow%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%85%B1%E4%BA%ABgpu%E5%86%85%E5%AD%98%EF%BC%9F/836696536/www.it-swarm.cn/zh/tensorflow/%E5%9C%A8tensorflow%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%85%B1%E4%BA%ABgpu%E5%86%85%E5%AD%98%EF%BC%9F/836696536/](https://link.zhihu.com/?target=https%3A//www.it-swarm.cn/zh/tensorflow/%E5%9C%A8tensorflow%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%85%B1%E4%BA%ABgpu%E5%86%85%E5%AD%98%EF%BC%9F/836696536/)

[深度学习训练能不能使用共享GPU内存?2 赞同 · 5 评论回答](https://www.zhihu.com/question/435957468/answer/1641560823)



## ************************************************************************ 结论：训练时，可以使用共享GPU内存，能解决由num_works设置大于0引起的问题

## **********************************************************************

共享内存是主系统的一个区域RAM为图形保留。参考文献：



[https://en.wikipedia.org/wiki/Shared_graphics_memoryen.wikipedia.org/wiki/Shared_graphics_memory](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Shared_graphics_memory)



[Integrated vs. Dedicated Graphics Card: 7 Things You Need to Knowwww.makeuseof.com/tag/can-shared-graphics-finally-compete-with-a-dedicated-graphics-card/](https://link.zhihu.com/?target=https%3A//www.makeuseof.com/tag/can-shared-graphics-finally-compete-with-a-dedicated-graphics-card/)



[https://youtube.com/watch?v=E5WyJY1zwcQyoutube.com/watch?v=E5WyJY1zwcQ](https://link.zhihu.com/?target=https%3A//youtube.com/watch%3Fv%3DE5WyJY1zwcQ)



这种类型的内存是集成显卡，例如Intel HD系列通常使用的内存。

这不在您的NVIDIA GPU上，CUDA无法使用它。 Tensorflow在GPU上运行时无法使用它，因为CUDA无法使用它，并且在CPU上运行时也是如此，因为它是为图形保留的。

即使CUDA可以某种方式使用它。它没有用，因为系统RAM带宽比GPU内存带宽小约10倍， 和 你必须以某种方式通过慢速（和高速）从GPU获取数据延迟）PCIE总线。

带宽数据供参考：GeForce GTX 980：台式机主板上的224 GB/s DDR4：约25GB/s PCIe 16x：16GB/s

这没有考虑延迟。在实践中，对数据进行GPU计算任务太大而不适合GPU内存并且每次访问时必须通过PCIe进行传输对于大多数类型的计算来说都是如此慢，以至于在CPU上执行相同的计算会快得多。

当你的机器上有NVIDIA显卡时，为什么会看到这种内存被分配？好问题。我可以想到几种可能性：

（a）您同时激活了NVIDIA和Intel图形驱动程序（例如，在两者上运行不同的显示时）。卸载Intel驱动程序和/或禁用BIOS和共享内存中的Intel HD图形将消失。

（b）NVIDIA正在使用它。这可以是例如额外的纹理存储器等。它也可以不是真实存储器而是仅对应于GPU存储器的存储器映射区域。查看NVIDIA驱动程序的高级设置以获取控制此设置的设置。

无论如何，不，Tensorflow没有任何东西可以使用。



[https://wukong.toutiao.com/question/6576408073001238791/wukong.toutiao.com/question/6576408073001238791/](https://link.zhihu.com/?target=https%3A//wukong.toutiao.com/question/6576408073001238791/)

[Win10任务管理器中的"共享GPU内存"是什么意思？-win10,任务管理器,gpu,内存](https://link.zhihu.com/?target=https%3A//wukong.toutiao.com/question/6576408073001238791/)

[Win10任务管理器中的"共享GPU内存"是什么意思？-win10,任务管理器,gpu,内存wukong.toutiao.com/question/6576408073001238791/](https://link.zhihu.com/?target=https%3A//wukong.toutiao.com/question/6576408073001238791/)

[win10任务管理器中的专用GPU内存 vs 共享GPU内存blog.csdn.net/JoyceYa/article/details/106621067![img](https://pic3.zhimg.com/v2-7e52f2e0e6b7c7eea9ec472f73deb822_ipico.jpg)](https://link.zhihu.com/?target=https%3A//blog.csdn.net/JoyceYa/article/details/106621067)

## 专用GPU内存

**就是只能被GPU使用的内存。**



- 对于独显，专用GPU内存就是GPU显卡上自带的内存，特点是带宽大，延迟小。
- 对于集显，专用GPU内存是指BIOS从系统内存中分配给集显GPU专用的内存，也称为stolen memory。

## 共享GPU内存

**就是GPU(s)和其他应用可以共享的系统内存，其中，GPU的使用优先级最高。**



- 受PCIe限制，相比于专用GPU内存，共享GPU内存的带宽小，延迟大。所以Windows系统会优先使用专用GPU内存。
- 共享GPU内存值的大小由Windows系统根据系统内存大小来分配，用户无法修改。

WIN10任务管理器中的“共享GPU内存”首次在WINDOWS任务管理器中集成。

![img](https://pic2.zhimg.com/80/v2-a8e97f074f94f41dbc794f138902dd49_1440w.jpg)

红框内中专用GPU内存自然不用说，那是显卡带的内存也就是显存容量

GPU内存是“专用GPU内存”和“共享GPU内存”加一块的容量。

而“共享GPU内存”是WINDOWS10系统专门为显卡划分的优先内存容量。在显卡显存不够的时候，系统会优先使用这部分“共享GPU内存”。

在WIN10系统中，会划分一半容量的物理内存容量为“共享GPU内存”。就像我本机拥有16G内存，所以被划分了一半8G为“共享GPU内存”。

不知你听过“显存不够内存凑，内存不够硬盘凑”这句话没。在程序运行时，WIN10系统会优先使用显卡显存，但程序需要显存超过显存容量的时候，为了避免程序崩溃WIN10系统就会在“共享GPU内存”中借用内存给显卡当显存。但借用容量不会超过“共享GPU内存”总容量。

因为内存相对于显存来说带宽和时延都比较小，不可避免会带来程序运行效率降低，如果放在游戏中就是掉帧卡顿的问题。

不过“共享GPU内存”虽然占据一半物理内存容量，却并不是说其他程序就不能使用这些内存容量。它是一个共享容量，只不过优先给显卡使用而已。

## GPU内存

**专用GPU内存+共享GPU内存。**



编辑于 09-10

图形处理器（GPU）

赞同

添加评论

分享





### 文章被以下专栏收录

- ![AI大类](https://pic2.zhimg.com/4b70deef7_xs.jpg?source=172ae18b)

- ## [AI大类](https://www.zhihu.com/column/c_1359082899900248064)

- AI通用知识、模型和框架