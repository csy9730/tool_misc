# ARM mali gpu四大微架构概述

[![Keepin](https://pic2.zhimg.com/v2-331087a42dec3682e7cdc1d688897661_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/lovely-65-92)

[Keepin](https://www.zhihu.com/people/lovely-65-92)

GPU高性能计算



47 人赞同了该文章

> 对于手机终端来说，GPU图像处理能力是衡量一台手机的性能标杆。首先，是UI流畅性，大家拿到手机都得先划来划去看下UI是否流畅，而UI其实主要还是用GPU渲染的；其次是游戏的流畅性，对于很酷炫的游戏，GPU是目前手机端的唯一高性能3D加速器。在手机端，主流的几个GPU主要是PowerVr，Mali，Adreno。苹果早起使用的就是PowerVr的定制版本，不过随着苹果自研GPU，PowerVr现在基本可以是算卖给了紫光；Mali是鼎鼎大名的安谋半导体ARM的图形加速IP；Adreno是高通的图形GPU。当然这里不是要对比这些GPU的性能，而是简单介绍下Mali的GPU系列。

Mali其实是ARM的Mali系列IP核，但是很多现在在很多网上提到Mali其实是直接认为是Mali的GPU。Mali系列其实还有视频，显示控制器，camera等。但是Mali应该算是授权比较多的。而且因为GPU也被更多的非业内人士所熟知。

1、Mali的四大架构之一：Utgard

第一代微架构Utgard（北欧神话人物：乌特加德）。这一代架构出来的比较早，主要是图形加速IP。可以追溯到2007年的mali-200。不过最让人惊讶的是mali-4xx系列，现在很多电视芯片都还在用这个IP。比如小米的智能电视，还有很多是mali-4xx系列的。

Utgard这一代vertex shader和fragment shader是分离的，arm官方支持的Opengl ES也只维护到2.0。所以Opengl ES 3.0及其以上要求的app是跑不了的。并且OpenCL在这一代中也是不支持的，因为这一代主打图形计算，不怎么支持通用计算。

移动端的GPU主要以基于tile的计算为主，mali的全系列（截止目前）都是基于tile的计算。基于tile的计算可以简单的认为，在进行计算的时候一张图会被划分成若干张小矩形，每个矩形可以认为是一个tile，然后对一个tile进行同时计算。

> 主要系列有：mali-200, mali-400, mali-450, mali-470

2、Mali的四大架构之二：Midgard

第二代微架构Midgard（北欧神话人物：米德加德）。Midgard这一代GPU开始属于同一着色器的架构，也就是上面说的vertex shader和fragment shader已经统一在一起了，相当于同一个shader计算单元可以处理多种着色器。当然也开始支持计算通用计算。特别是对OpenCL的支持，对通用计算有了很大的支持。OpenGLES 3.1虽然引入了compute shader，但是说起通用计算，OpenCL显然更加专业。

这个架构是基于128bit向量的，所以在编程的时候往往用4个float编程了能最大发挥其性能。当然，编译器也会把某些可以进行优化的计算合并成向量进行计算，不过最好在编码阶段自行优化。编译器编译的优化比较难以去把握。当然，也不建议用大于128bit的方式进行编程，最终需要编译器拆成多个数的运算，且每个数的位宽最大为128bit，如果编译器优化不好，反而会导致性能下降。

> 主要系列有：mali-t6xx, mali-t7xx, mali-t8xx

3、Mali的四大架构之三：Bifrost

第三代微架构Bifrost（北欧神话中连接天宫和大地的：彩虹桥）。由于这一代产品基本在2016年后发布的了，而OpenGLES在2016年后基本稳定了，所以相对于Midgard来说，在大方向上图形计算这块也没有多大的需要调整。

在Bifrost（Bifrost上更像是SIMT的模式，这里用SIMT表述也是我从多个文档资料推敲出来的）上会先把向量拆成标量，然后每个线程跑多维向量的第一维，因此对于三维向量 vec3向量最快只需要3个cycle，对于思维向量vec4最快只需要4个cycle。这里用了最快这个表述是因为并不是所有的指令都是单个cycle的。

当然，虽然bifrost架构是标量运算的，这是针对32bit的位宽来说的，如果是16bit位宽的计算，一个线程是可以在一个cycle内处理一个vec2的16bit数据的。因此在编程的时候，如果是8bit或者16bit的数据，用于应该考虑如何组织代码使得更有效的组合运算，例如16bit位宽的情况，尽量是用vec2，8bit位宽的尽量用vec4。

对于Bifrost，例如G76，一个shader core可以同时运行几十个线程,，从mali的资料显示，shader core一般由三个部分组成，ALU,L/S,TEXTURE三个主要模块。在G76上是8-wide wrap的，一般设置为3个ALU。（其余的型号可能不一样，例如G51/G72是4-wide wrap的，G72同样是3个ALU；G52跟G76一样，不过G52可配置成2个ALU的）

对于AI加速方面，部门系列也有一些指令修改，例如G52和G76都引入了int8 dot指令，该指令针对神经卷积网络的运算做了优化。

> 主要系列有：mali-g31, mali-g51, mali-g71, mali-g52, mali-g72, mali-g76

4、Mali的四大架构之四：Valhall

第四代微架构Valhall是2019年第二季度推出来的。该系列的是基于超标量实现的。对于G77，使用的时16-wide的wrap，单个shader core集成两个计算引擎。

> 主要系列有：mali-g57, mali-g77

最后，本文简要的梳理了下mali gpu架构的一些情况，同时对不同架构上的一些计算资源进行简要描述，希望能给看到的朋友提供一些有用的信息，本人也会继续研究单个系列甚至单个芯片更多资源配置的情况，感谢各位的关注。同时，也吐槽一下，Mali系列的芯片命名在Bifrost和Valhal系列没有区分开，特别的截止（2020.03.15），单纯从mali-g51, mali-g71, mali-g52, mali-g72，mali-g57, mali-g77，很难区分最后两个型号是Valhall的架构。这个命名不知道mali是怎么考虑的，着实令人难解。

更新于2020.03.15

编辑于 2020-03-17

图形处理器（GPU）

ARM

并行计算