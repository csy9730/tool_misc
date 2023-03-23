# 数字集成电路(IC)开发流程

[![IC三人行](https://picx.zhimg.com/v2-9a9621d1123730b7627233dca4d77493_l.jpg?source=172ae18b)](https://www.zhihu.com/people/icsan-ren-xing)

[IC三人行](https://www.zhihu.com/people/icsan-ren-xing)

集成电路(IC)设计与验证

183 人赞同了该文章

数字集成电路(IC)的整个开发流程是很复杂的，下图以一个数字IP在整个IC开发过程中要经过的环节为例来做个简单的介绍。希望对大家的理解有所帮助并理解不同职位的工程师的职责所在。虽然目前业界主要有3家EDA tool提供商（Synopsys, Cadence, Mentor), 但因为作者本人对Synopsys公司的工具比较熟悉，所以涉及到的EDA工具会主要以Synopsys公司的为主。受限于篇幅，很多环节只会提到其中的主要目的，具体的实现细节可以去查阅相关 EDA tool的user guide. 也可以关注我的微信公众号（IC三人行），里面会不定期地分享一些作者的工作心得。



![img](https://pic4.zhimg.com/80/v2-8ecfa2c1ce1a60a4d6e7198bdc52698f_720w.webp)

整个流程可以分成3个大的阶段：

1. RTL开发阶段 (前端工程师职责所在)
2. layout前的开发阶段 (一般也由前端工程师负责)
3. layout后的开发阶段 (后端工程师的职责)

大家可以看看下图对这3个阶段有个直观的认知：



![img](https://pic4.zhimg.com/80/v2-164751a5d2b076943fb0e09495174bcb_720w.webp)

**1. 先来讲讲RTL开发阶段：**

第一步是制定IP的SPEC, 这个阶段可能会要参考一些业界的标准，例如Ethernet MAC IP的开发一定会要去参考IEEE 802.3 standard。有时候基于客户或系统层面的应用需求，可能还会加入一些定制化的需求在里面。这就需要SPEC制定者与marketing, customer, system architecturer, SoC bus designer等等与当前IP相关的人员充分讨论，而不是单纯的闭门造车。

SPEC制定后，设计工程师会开始做 RTL design。设计工程师一般用Verilog来实现RTL design, 也有用VHDL的，但就作者所接触的公司来看不是主流。近年来也有些公司在尝试用System Verilog来做RTL design, 其效果和EDA tool对其支持的完善程度还有待验证。

RTL coding完后，一般都由负责设计此RTL的设计工程师继续做一些RTL品质的检查，例如RTL代码风格检查，跨时钟域的检查等。这些检查目前主流的工具有Synopsys公司的 Spyglass. 为什么要做这些检查呢? 根本目的就是保证RTL设计的代码是可以被EDA工具综合（暂时理解为“翻译”）成物理电路世界的具体电路（例如AND/OR/NAND gate, Dflipflop等)，并且这些电路的功能是吻合设计者的预期的。举个最简单的例子，有些Verilog语法本身是无法被EDA tool翻译成具体的电路的，例如Integer类型的变量。

在设计工程师做上述事情的同时，验证工程师会同步开始他的验证工作。首先是根据自己对SPEC的理解编写验证规划。这个过程中遇到理解上的问题可以找SPEC制定者和设计工程师讨论，但是有个原则是不能什么都听他们的，你觉得有道理的可以采纳，你觉得没有道理的就要勇于和他们充分讨论。某些bug可能在前期的讨论中就会被发现。

- 验证规划里面要包含整个验证环境的框架和主要组成部分的介绍。还有SPEC中提到的所有的功能点也要列出来（最简单的就是用excel file）,并说明怎么去测试这些功能点。
- 验证规划制定好后，要找SPEC制定者和设计工程师审核（review），确保没有理解上的偏差和验证漏洞。这个过程可能会有几个来回，对你的细心和耐心也是一种考验。
- 验证规划审核通过后，就可以开始搭建具体的验证环境，搭建方法一种是用Verilog语言来搭建，另一种是用UVM来搭建。前者相对简单些，验证者可以在较短的时间里就搭建好一个基本的环境。后者相对复杂，但搭建好后，能够更快地实现所有的测试项目。具体的差别我们可以在另一篇文章中来具体介绍。不管用什么方法都涉及到编译和仿真工具的选择。例如Synopsys公司的VCS或cadence的IRUN。
- 验证环境写好后，验证工程师就可以开始用它来测试设计工程师交付的RTL。绝大部分的设计缺陷都是在这个阶段的动态仿真中发现的。这期间除了分析打印在电脑屏幕上或log file中的debug信息(由建立验证环境和测试用例时由验证工程师所写的$display等打印函数打印出来的)，你可能需要用到synopsys的Verdi来分析波形图以确定到底是RTL的设计缺陷还是验证环境的设计缺陷。
- 设计工程师的设计成果可以由验证工程师来把关，那验证工程师的工作成果的品质如何保证呢？一方面是靠相关工程师的人工审核（review），另一方面是靠代码覆盖率（code coverage）和功能覆盖率(function coverage)的客观结果。代码覆盖率就是RTL设计中的每一行代码，甚至每一个变量的变化都有被验证环境覆盖到。这个不论你的验证环境是Verilog写的还是UVM写的，都会被衡量。功能覆盖率是System Verilog 语言才有的一种方法，验证工程师通过它来保证所有从SPEC中抽取出的功能点都有被UVM环境覆盖到。具体的解释，将在别的文章中展开。

**2. 设计工程师在完RTL设计和品质检查后，除了和验证工程师一起确认和修正RTL设计缺陷外，就可以开始进入下一个大的阶段：即第一张图中的pre-layout gate-level netlist阶段 （layout前的开发阶段）。**

第一步是用EDA工具将RTL设计的代码翻译成物理电路世界的具体电路（例如AND/OR/NAND gate, Dflipflop等)，这个步骤专业的称呼叫”综合“。这个阶段可以使用的EDA工具有Synopsys的Design Compiler或cadence的RTL Compiler。



![img](https://pic1.zhimg.com/80/v2-f0d4ba589ea0dac3752762ca8170e524_720w.webp)



静态时序分析（Static Timing Analysis, STA）：STA是一种分析电路是否满足时序需求的一种方法。所谓的“静态”就体现在它不需要进行动态仿真。数字电路的基本组成简言之可以看成组合逻辑门（例如AND/OR gate）和时序逻辑（例如DFF）的组合. 如下图所示（圆圈表示组合逻辑电路）。组合逻辑电路的复杂度，就决定了电路能否在给定频率的clk下正常工作。相关的工具有Synopsys的PrimeTime.



![img](https://pic4.zhimg.com/80/v2-e9df6636839c9225e18cdf2de9392147_720w.webp)



Design for Test (DFT)：在芯片的制造和封装过程中，可能会出现一些瑕疵。DFT 的目的就是将一些特殊结构（例如scan chain）在设计阶段植入原始电路中，以便芯片制造出来后可以对它进行测试看看哪些芯片是好的可以卖给客户，哪些是有问题需要丢弃的。想想看一个几千万门或上亿门的IC在生产出来后，芯片内部任一个门有问题，都需要能够通过DFT电路观察出来，是不是有点神奇？相关的工具有Synopsys的DFT compiler和tetramax。

Power Analysis：分析所设计的电路需要消耗多少能量。想想手机电池基本要一日一充的痛苦，芯片设计工程师也正在想尽一切办法让自己的电路能够尽可能的少消耗一些能量来提升用户体验。power分为静态power和动态power, 静态power主要指漏电引起的power消耗，例如CMOS的source到drain的亚阈值电流引起的power消耗。动态power又分为2类，一类是switching power, 是指电路状态翻转引起的对cell外部负载电容充放电引起的power消耗，另一类是internal power,是指对cell内部负载电容充放电引起的power消耗和短路电流引起的power消耗。tool要想算出准确的power的消耗，在指定制程的前提下，还需要知道每个cell的每个pin的翻转频率，transition time和cell的电容负载值。翻转频率可以通过simulation得到，准确的transition time和电容负载值需要在layout之后抽出实际的RC值才能得到，这就是为什么第一张流程图中在post-layout阶段还有一次power的分析步骤。相关的工具有Synopsys的PrimeTime

Gate level Simulation(GLS)： 将综合得到的gate level netlist 拿来再做一次动态仿真测试。这个仿真应该尽可能的考虑到实际物理电路的timing信息，这个信息可以由layout工程师在完成layout后提供给你。在layout完成前做GLS的话，就只能依靠 cell library中提供的WLM来估计实际物理电路中的 delay信息了。因为仿真对象已经从RTL 变成了gate, 因此仿真工具需要读取一个描述每种gate行为和delay信息来源的仿真模型，这个simulation model会由cell library 的提供商提供。既然前面已经做了RTL sim 和 STA，为什么还需要GLS呢？主要原因有以下几点：

- coding style问题可能导致综合前后Function会不一致，例如多个always block对同一个信号做了赋值，RTL simulation中的电路行为和实际门级电路的行为可能会不一致。
- STA是基于人写的constraint,可能会有漏洞，也可能会有笔误。
- 异步电路（例如跨时钟域的电路）在STA中是无法被分析的。
- 各家EDA公司的RTL仿真工具都可以被用来做GLS，只是流程上要注意仿真对象发生了改变，以及综合或layout后得到的实际电路的timing 信息如何反标到gate level netlist中，相关仿真工具的user guide会有详细说明。

Formal verification：因为coding style问题可能导致综合前后Function会不一致，我们可以用Gate-level Simulation 得知合成后Function之正确性，但假使验证后发现Function 不正确，要用Debug Tool 来抓错误点，往往需要耗上相当多的时间，为解决这问题，可以使用Formal Verification 工具找出其问题点. 设计者须准备综合前的Golden RTL Code 与综合后产生的Gate-level Netlist (Revised Code)及其相关Library档，在添加一些合理的约束信息后（例如，当综合时有额外添加电路如TestingCircuit，可以给定Constraints 予以Mask掉），工具就可以将整个电路切割成一个个的logic cone, logic cone的输入和输出往往是I/O或DFF，然后工具会给这些Logic cone提供各种可能的输入值，如果logic cone的输出结果在2个版本的设计中永远都是一致的，那么就表示PASS。相关的工具有Synopsys的Formality和Cadence的LEC.



![img](https://pic4.zhimg.com/80/v2-23d7aafc1baba15ecbc2dea8d48442d3_720w.webp)

FPGA测试：这个环节很多国内的研究生是比较熟悉的。因为FPGA板子上的测试可以看到的设计内部的信号是有限的， 所以FPGA测试时遇到问题的debug难度是远大于RTL动态仿真时的debug的。并且既然RTL动态仿真已经将所有可能的功能点都cover了，为什么还需要做FPGA测试呢？根据作者的认知主要有如下几点考量：

- FPGA上的测试可以真实的验证软件和硬件的协作流程
- 可以和真实的关联设备协同验证，例如USB host controller和市面上的各种U盘一起验证，可以保证所设计的USB host controller的兼容性。
- 一些需要和模拟电路协同工作的IP在RTL仿真时往往是使用的模拟电路的行为级模型，这个模型可能存在和实际电路行为不一致之处。在FPGA测试时可以使用模拟电路的实际电路（一般会先开发出相关的test chip并做成子板）来确保不会有问题。
- 常见的工具有Synplify和ISE.



**3. 接下来我们讲讲 gate level post-layout 这个阶段的工作任务:** 这个阶段的主线任务简单说就是将上一阶段产出的 gate level netlist 经过布局布线，生成 GDSII文件，然后就可以把这个GDSII文件提交给芯片制造代工厂生产出最终的芯片。 具体的工作内容说明如下：

Placement & Route:

- 在Placement步骤中，APR软件 (例如Synopsys 的 ICC 或者 Cadence 的Encounter) 会根据设计者的Constraint将Cell摆放至适当方位以满足规格，假使未满足规格，设计者可再透过Placement Optimization取得更好的Performance。另外假使有Testing Circuit，需要在Placement时将Scan Chain作Re-order(因为在place & route 之前，syntest产生netlist中scanchain时因为无法知道各个寄存器物理位置的信息，会造成P&R后， chain上一个寄存器连接到很远的另一个寄存器的情况，布线不优化（chain所用到的总线长很长）甚至造成拥挤。因此会在布局布线后重新reorder scan chain. 但是要注意reorder后hold timing 会变差。reorder scan chain 是根据这些register的物理位置来改变scan chain 中register的顺序（connectivity）)，以取得较好的Performance。完成Placement后即可开始进行Clock Tree Synthesis(CTS)，目的让每个Clock Signal可以balance送至Flip-Flop的末端，以降低Clock Skew及增加Clock Signal的推动力。最后再将Standard Cell、IO Pad Cell、Macro等Cell之Signal Pin进行绕线，并作Routing Optimization达成规格，完成Routing步骤。完成整个芯片P&R后，确认都没Violation后即可存成Post-layout GDSII及Gate-level Netlist档案
- 从整个APR Flow 可以发现，Placement、CTS、Routing 这些都是软件在作的，这对设计者来说并非是难事，但是在Floorplan 及Power 的规划却是要花最多Effort 的，这是因为Design 中如果有多个Macro 时会不知道怎么摆放才可以做到满足Timing 规格，也不知道要如何作出一个好的Power Mesh 规划，像是P/G Cell 个数要多少？、Metal宽度要多少？Stripe 要几条？才不会造成IR Drop 过多或Electro-Migration(EM)问题发生。这些问题常常困扰着设计者，也是Layout 最花时间的部分
- EM问题：在电流密度很高的导体上，电子的流动会产生不小的动量，这种动量作用在金属原子上时，就可能使一些金属原子脱离金属表面到处流窜，结果就会导致原本光滑的金属导线的表面变得凹凸不平，造成永久性的损害。这种损害是个逐渐积累的过程，当这种“凹凸不平”多到一定程度的时候，就会造成CPU内部导线的断路与短路，而最终使得CPU报废。温度越高，电子流动所产生的作用就越大，其彻底破坏CPU内一条通路的时间就越少，即CPU的寿命也就越短，这也就是高温会缩短CPU寿命的本质原因

Post-layout power analysis：Layout 过程中，当完成Power Mesh 规划及Cell、Macro 摆定位后，为了确认目前规划的Power Mesh 够Robust，不会造成IR Drop 超过合理范围(一般为工作电压10%以下)及EM Violations 发生，因此要使用Layout 软件之Power Analysis 的功能进行分析。Power Analysis 前须准备包括，P/G Cell 个数及方位、该芯片的Input端的Transition Time(因一个Cell Power Consumption 是根据Input Transition 与Output Capacitance 查表得知的 )、Net Switch Activity。前面两项可依实际电路给定，Switch Activity 须将目前Layout 结果存成Gate-level Netlist 并灌入实际的Pattern 进行Simulation得到。

Formal verification：Layout 后，电路的Function 有可能因Layout 而有所改变。会造成电路Function 错误原因一般是Signal Pin 被floating 掉或CTS 出了问题(这与synthesis后function改变原因不一样)。因此在Layout 后还要再作Gate-level Post-layout Simulation 以确认Function是否正确。但假使验证后发现Function 不正确，要用Debug Tool来抓错误点，往往需要耗上相当多的时间，为解决这问题，同样地我们可以使用Formal Verification工具帮忙找出其问题点（但是对于CTS造成timing不对而影响function还是只能通过simulation才能找到问题）

Gate level simulation：在Layout时，设计者要提供RC Table 给Tool 计算Net 的Delay，RC Table 都是由Library 厂商会提供，该Table 可以查到每unit 长度的Metal 其RC 值为多少，Tool 会自动查表并计算Net 长度为多少，来决定每条Net 的Delay 是多少。由于Layout 时已有实际电路存在，Tool 可以依据实际长度计算出Net Delay 时间，因此跟综合时所使用的WLM 准确度差異甚多。因此每次设计者要Report Timing 前，都要针对目前Layout 电路再作一次RC Extraction，以取得精确地Delay Calculation，直到最后Layout 完成产生正确的sdf 档，作为Post-layout Gate-level Simulation之用。

Design Rule Check(DRC)：将Layout 结果，依据Foundry 对该制程定义的Max or Min Width、最小图像间距，金属宽度等Rule 作确认有无违反,若不check则代工厂生产出来的可能是废品。

Layout vs. Schematic (LVS)：将Layout 结果（GDS）与Schematic(netlist)作比对，比较两者间Instance、Port(PIN)、Net 等个数、Cell 连线情况及Power/Ground连接是否一致，以确认Layout 完结果之正确性



发布于 2017-08-13 21:45

[芯片（集成电路）](https://www.zhihu.com/topic/19583435)

[芯片设计](https://www.zhihu.com/topic/19769031)