# 学习开源硬件：开源IP，开源RISC-V与开源SoC等

[![纸上谈芯](https://pic1.zhimg.com/v2-35a36468e4d0cf85ede3b15998248cba_l.jpg?source=172ae18b)](https://www.zhihu.com/people/zhishangtanxin)

[纸上谈芯](https://www.zhihu.com/people/zhishangtanxin)

IC工作者，公众号"纸上谈芯"

97 人赞同了该文章

当下，“开源”已经变得越来越普遍，越来越深入人心。各行各业开源项目如火如荼，无论是个人还是企业都在积极参与。各路好汉踊跃地分享自己的劳动成果，公布源代码，开放指令集或有更宏大的愿景来建立新的生态及建设产业链。

在这其中，“开源硬件”对于集成电路从业人员来说无疑是一缕清泉。对于软件来说，开源项目之多，开源规模之大，开源方面之广，硬件显然是难以比肩，当前更是无法企及的。目前硬件开源正在逐步得到了发展，无论是小型模块（如I2C类总线）和大型项目（如英伟达深度学习加速器NVDLA），传统的（如信号处理模块）和当下最热门的（如RISC-V）硬件项目等，已具备相当大的开源数量。

从这些开源硬件中可以学习、借鉴并使用无疑是一件令人激动人心的事。从中可以了解一些模块，项目或者系统的细节，乃至可以做自己感兴趣的设计。比如设计一款SoC，我们可以设计自己的处理器，添加自己的外设等。

## 开源IP

IP即Intellectual property 的缩写，在半导体领域中，知名IP供应商主要有ARM，Synopsys，Cadence，Imagination Technologies，Wave Computing， Broadcom等，他们为客户提供了模拟/数字等各类IP核，形式多种多样，如CPU、GPU、USB、PCIe和SerDes等模块。毋庸置疑，这些都是收费的，且目前不可能开放给公众，除非不想挣钱了。

### OpenCores
所以，网上有各种包括个人以及企业公布的开源IP。今天开源IP的主角就是以下激动人心的网站OpenCores：[https://opencores.org/](https://opencores.org/)



![img](https://pic2.zhimg.com/80/v2-f440ded09c7f65f7c257b322c12e5655_720w.webp)

项目门类：Arithmetic core、Prototype board、Communication controller、Coprocessor、Crypto core、DSP core、ECC core、Library、Memory core、Processor、System on Chip、System on Module、System controller、Testing / Verification、Video controller、Other、Uncategorized

OpenCores上的开源项目数量颇多。无论是基础模块还是大型项目都有，是IC工程师学习的一大宝藏，不去学习实在是暴殄天物。

![img](https://pic2.zhimg.com/80/v2-b7ab2c18735b9fc9b0a2e3b80b101d8d_720w.webp)

Processor内一角

其中，处理器门类项目就有200个，有些是没有完成的，包含有我们熟悉的8051核，采用Verilog语言设计。

所以，从今天（2020.01.01）新年第一天开刊开始，本号将秉承“一为涤荡心灵；二为脱胎换骨。”的宗旨持续更新学习并解读开源IP，欢迎大家关注，共同交流学习。

## 开源RISC-V

除开源IP外，处于当前处理器热潮之巅非RISC-V莫属。

RISC-V，念RISC five，是一种开放，免费的全新指令集架构。其最重要的特点是开放，任何人都可以基于RISC-V设计硬件与软件。它是加州大学伯克利分校设计的第五代RISC，开始于2010年。RISC-V适用于从微控制器到超级计算机等各层次的计算系统，支持自定义扩展指令，标准由非盈利RISC-V组织维护，其官网为：[https://riscv.org/](https://link.zhihu.com/?target=https%3A//riscv.org/)。

设计一款CPU需要逻辑，编译器和操作系统等各方面的专家，由此可见，开发CPU的难度之大。所以商用的CPU供应商如ARM和MIPS对客户对其CPU的使用收取昂贵的许可费用，客户更难知道其中的细节。RISC-V旨在解决这些难题，对于低成本CPU开发以及公共教育，将大有裨益。所以，越来越多的公司选择拥抱RISC-V。

![img](https://pic1.zhimg.com/80/v2-09663df9acbb51b61b12ec00c9d06a50_720w.webp)

RISC-V会员

截止目前为止，初步统计已有180多家会员，越来越多的企业加入RISC-V的阵营，有着打破当前处理器局面的高涨热情，同时敢说敢干。

![img](https://pic3.zhimg.com/80/v2-4cb07dc9fe44202bd921fb8626b3771a_720w.webp)

伯克利团队设计的各代RISC版图

英伟达未来将在GPU中使用RISC-V，西部数据在RISC-V研究中投资上百亿资金，高通公司也对RISC-V架构产生了极大的兴趣，谷歌等大公司也都开始加入其中。国内的华米公司面向可穿戴智能产品的设计了基于RISC-V的处理器黄山一号，阿里平头哥在2019年发布超强RISC-V处理器玄铁910，单核性能达到7.1 Coremark/MHz，主频达到2.5GHz。

关于RISC-V开源核资源众多，如：

Rocket：

[https://github.com/chipsalliance/rocket-chipgithub.com/chipsalliance/rocket-chip](https://link.zhihu.com/?target=https%3A//github.com/chipsalliance/rocket-chip)

Freedom：

[https://github.com/sifive/freedomgithub.com/sifive/freedom![img](https://pic4.zhimg.com/v2-4730eeccc2056ba53d79db005e07ef03_ipico.jpg)](https://link.zhihu.com/?target=https%3A//github.com/sifive/freedom)

Boom：

[https://github.com/riscv-boom/riscv-boomgithub.com/riscv-boom/riscv-boom](https://link.zhihu.com/?target=https%3A//github.com/riscv-boom/riscv-boom)

ORCA：

[VectorBlox/orcagithub.com/vectorblox/orca![img](https://pic4.zhimg.com/v2-a78a64ef3a26bf8d396c38be96b2084f_ipico.jpg)](https://link.zhihu.com/?target=https%3A//github.com/vectorblox/orca)

RI5CY：

[pulp-platform/riscvgithub.com/pulp-platform/riscv![img](https://pic3.zhimg.com/v2-0ea7b7607150a2a3f9cb9931157305be_ipico.jpg)](https://link.zhihu.com/?target=https%3A//github.com/pulp-platform/riscv)

RiscyOO：

[csail-csg/riscy-OOOgithub.com/csail-csg/riscy-OOO![img](https://pic2.zhimg.com/v2-a471bea37db0ab61b1d24fd1952b31ed_ipico.jpg)](https://link.zhihu.com/?target=https%3A//github.com/csail-csg/riscy-OOO)

Lizard：

[https://github.com/cornell-brg/lizardgithub.com/cornell-brg/lizard](https://link.zhihu.com/?target=https%3A//github.com/cornell-brg/lizard)

Minerva：

[https://github.com/lambdaconcept/minervagithub.com/lambdaconcept/minerva](https://link.zhihu.com/?target=https%3A//github.com/lambdaconcept/minerva)

VexRiscv：

[https://github.com/SpinalHDL/VexRiscvgithub.com/SpinalHDL/VexRiscv](https://link.zhihu.com/?target=https%3A//github.com/SpinalHDL/VexRiscv)

SCR1：

[https://github.com/syntacore/scr1github.com/syntacore/scr1](https://link.zhihu.com/?target=https%3A//github.com/syntacore/scr1)

bottlerocket：

[google/bottlerocketgithub.com/google/bottlerocket![img](https://pic3.zhimg.com/v2-70d3828eb9c953441e50f122d616c91e_ipico.jpg)](https://link.zhihu.com/?target=https%3A//github.com/google/bottlerocket)

Hummingbird E200：

[https://github.com/SI-RISCV/e200_opensourcegithub.com/SI-RISCV/e200_opensource](https://link.zhihu.com/?target=https%3A//github.com/SI-RISCV/e200_opensource)

还有很多……

RISC-V的学习资源也越来越多，有的大学教材将ARM架构改成RISC-V架构，以保证学界与业界统一，为RISC-V工业界输出人才。David Pattern等人编著的三本RISC-V宝典，《Computer Organization and Design RISC-V edition》《The RISC-V Reader》《Computer Architecture：A Quantitative Approach》。西部数据也相继发布了一系列教程如关于RISC-V汇编的指导教程《Assembly Language Tutorial》。

![img](https://pic4.zhimg.com/80/v2-f0bae5896dd461501152e1c957f77f7f_720w.webp)

David Patterson等人编著的三本RISC-V

大好时代，给予如此多共享的资源，看了振奋人心，本号决心好好学习祖师爷们留下的宝贵CPU秘籍。

## 开源SoC

如果有了IP与RISC-V处理器核，你是否想过自己独立设计一款SoC呢？在这之前可能我们不敢想，但是未来可期。

SiFive公司身先士卒，基于RISC-V开发了完整的处理器核和开发板，已可以完整地运行Linux操作系统。

![img](https://pic3.zhimg.com/80/v2-0fba4187d93fd41ef0d7c3024341e856_720w.webp)

RISC-V开发时间线

作为当前炙手可热的SoC领导厂商，SiFive设计了SiFive Core Designer工具，参数化核设计，用户可以自定义模式和指令集，片上存储，调试单元，接口选择，保密控制，中断设置，是否插入DFT，功耗管理和预测指令（根据性能或面积）等选项，大大提高了SoC设计的多样性和减小了SoC的设计难度。用户可选择的核目前有E2/E3/E7/S2/S5/S7/U5/U7。最新消息，SiFive设计了最新的U8处理器，一个可扩展的乱序执行的RISC-V CPU核心，与Arm Cortex A72相比，U8系列的目标在性能上具有可比性，面积只有A72一半。

![img](https://pic2.zhimg.com/80/v2-61c300ba50c6afb1194b849fb8169f85_720w.webp)

SiFive Core Designer，基于U7 Core

自定义化SoC，基于远端服务器云操作，云上集合了EDA工具，设计者只需要考虑感兴趣的模块，并且一些需要的基础ip模块可供使用，包括后期的流片，封装和测试等一站式服务。未来用户只要支付一些合理的价格，就可以获得自己设计的SoC，这对于小规模企业将是大好消息。

![img](https://pic2.zhimg.com/80/v2-fb1f99f637ada1961cc81235f2af5901_720w.webp)

HiFive Unleashed RISC-V开发板：Freedom U540 SoC

在国内，为了进一步降低芯片设计门槛，加速行业创新，平头哥开启“普惠芯片”计划。未来将全面开放玄铁910 IP Core，开发者可以快速开展芯片原型设计和架构创新；同时，基于平头哥芯片平台(Domain specific SoC)，使用包括CPU IP、SoC平台以及算法在内的软硬件资源服务。

另外，平头哥在第六届乌镇互联网大会上已正式宣布开源RISC-V架构低功耗MCU芯片平台，包含处理器、基础接口IP、操作系统、软件驱动、开发工具等全套模块，搭载玄铁902处理器。用户可以快速集成验证，节约成本。阿里此举旨在将芯片设计的基础共性能力共享给整个行业。

![img](https://pic4.zhimg.com/80/v2-e474257a3a757ed47f18d501dbbc366b_720w.webp)

平头哥无剑平台T-head-Semi/wujian100_open

当然，开源IP, RISC-V和SoC的验证仍是一个巨大的问题，未来还有很多挑战，我们拭目以待。

更多阅读，关注“纸上谈芯”，不定期更新，共同学习:

![img](https://pic3.zhimg.com/80/v2-477b43eb791f2ac2de835fd3b9854a22_720w.webp)



编辑于 2020-01-03 15:55

[开源](https://www.zhihu.com/topic/19562746)

[SoC](https://www.zhihu.com/topic/19681915)

[RISC-V](https://www.zhihu.com/topic/20075426)