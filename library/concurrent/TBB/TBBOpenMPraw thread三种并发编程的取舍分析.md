# TBB/OpenMP/raw thread三种并发编程的取舍分析

![img](https://csdnimg.cn/release/blogv2/dist/pc/img/reprint.png)

[IT_FISH629](https://blog.csdn.net/yuwei629)![img](https://csdnimg.cn/release/blogv2/dist/pc/img/newCurrentTime2.png)于 2013-07-11 16:52:31 发布![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes2.png)9857![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect2.png) 收藏 11

分类专栏： [多核并行编程](https://blog.csdn.net/yuwei629/category_1489227.html) 文章标签： [TBB](https://so.csdn.net/so/search/s.do?q=TBB&t=all&o=vip&s=&l=&f=&viparticle=) [OpenMP](https://so.csdn.net/so/search/s.do?q=OpenMP&t=all&o=vip&s=&l=&f=&viparticle=) [raw thread](https://so.csdn.net/so/search/s.do?q=raw+thread&t=all&o=vip&s=&l=&f=&viparticle=) [并发编程方法比较](https://so.csdn.net/so/search/s.do?q=并发编程方法比较&t=all&o=vip&s=&l=&f=&viparticle=)

[![img](https://img-blog.csdnimg.cn/20201014180756930.png?x-oss-process=image/resize,m_fixed,h_64,w_64)多核并行编程专栏收录该内容](https://blog.csdn.net/yuwei629/category_1489227.html)

4 篇文章0 订阅

订阅专栏

**繁简程度考虑因素**

与 OpenMP 或英特尔® 线程构建模块（TBB）相比，本地线程编程模式采用了更为复杂的代码，因而其维护工作的难度也就相对较大。这样，您在适当的情况下，不妨使用英特尔® TBB 或 OpenMP，利用这些 API 的优势帮您创建并管理[线程池](https://so.csdn.net/so/search?q=线程池&spm=1001.2101.3001.7020)：自动实现线程同步，自动完成排程。

编程语言、编译器支持及自由迁移考虑因素

如果您的代码采用 C++ 编写，那么，英特尔® TBB 无疑将是最佳选择。这是因为，英特尔® TBB 大量使用了 C++ 模板和用户自定义类型，所以特别适宜对象导向程度较高的代码。如果代码采用 C 或 FORTRAN 语言编写，那么，OpenMP 则可能是最为适合的解决方案。因为它相比英特尔® TBB，更适用于结构型代码风格和简单代码，并且代码开销也相对较低。但是，即便采用 C++ 代码，如果算法是以阵列处理活动为主导，则在编码复杂程度方面，OpenMP 还是要优于 TBB。本地线程编程模式的复杂程度与 C 和 C++ 语言相类。但是，由于线程工作必须表述为一个函数，因此，采用本地线程进行的编程，如采用 C 语言等编程语言则会显得更加自然灵活。而对于那些对象导向程度较高的 C++ 程序来说，由于本地线程无法清晰表达对象，因此如使用该类线程则可能破坏原有的风格和设计。

此外，英特尔® TBB 和本地线程无需编译器支持，而 OpenMP 却需要。并且在使用 OpenMP 时，您还需要采用一个可识别 OpenMP 范式的编译器进行编译。但是英特尔® C++ 和 Fortran 编译器均支持 OpenMP。近来，众多其他厂商生产的其它类型的 C++ 和 Fortran 编译器中也都或多或少的添加了一些 OpenMP 支持功能。

基于 OpenMP 和英特尔® TBB 的解决方案可在 Windows、Linux、Mac OS X、Solaris 以及众多其它操作系统之间自如迁移。如将基于本地线程的解决方案迁移到另外一种操作系统上，通常需要修改代码，这就势必会引入初始开发/调试工作，从而加重了维护负担。尤其是您希望在 Windows （通常使用 Windows 线程）和 UNIX （通常使用 POSIX 线程）之间实现迁移时，这一影响就会更加突出。

并行编程模式的复杂程度

事实上，API 的选用主要还是取决于您想对哪些代码实现并行。如果您的并行模式主要用于内建类型的有界循环（bounded loop），或是平面的 do-loop 中央循环，那么，建议您最好采用 OpenMP。

TBB 采用泛型编程，因此，如果您需要定制迭代空间或复杂归约运算，那么，它的循环并行化模式则能帮您“应付自如”。当然，如果您需要将并行化运用到循环以外的范围，您亦可使用 TBB。这是因为它可为并行 while-loop 循环、数据流管线模式、并行排序和并行前缀算法提供泛型并行模式。

OpenMP 支持嵌套并行，并可采用本地线程执行。但是，如果使用这两种线程 API，则极易造成资源过度利用。TBB 在此方面技高一筹，它自然支持嵌套和递归并行，并且其任务调度程序的“任务偷窃技巧（task stealing technique）”还能帮忙管理一定数量的线程。凭借这一先进技术以及任务调度程序的动态负载均衡算法，TBB 可调度所有处理器内核全力处理有益工作，既可有效避免过度使用线程（软件线程过多将会带来不必要的开销），又可顺利解决线程用力不足的难题（软件线程太少意味着您未充分利用所提供多个内核的资源）。

TBB 和 OpenMP 还专门增添了用于提供重点关注可扩展性数据并行分解的构造函数，以期通过线程化提升系统的性能和可扩展性。这些函数在处理计算密集型工作方面，对我们极有帮助。而本地线程与之相比，在实现并行和卓越的可扩展性方面却略胜一筹。如果您使用本地线程执行 TBB 中已经提供的模式/算法，则极有可能引发数据竞争和死锁等线程错误。当然，本地线程也不是“一无是处”，它在基于事件或 I/O 的线程化中还是“身手不凡”的。

功能比较

![img](https://img-blog.csdn.net/20130711165422546?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveXV3ZWk2Mjk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

 

上文我们提到在选择何种线程化 API 时，需要考虑开发环境及并行模式复杂程度相关因素。但是如果在某种情况下，您只能选择 TBB 或 OpenMP 中的一个时，您该怎么办？答案其实很简单，这时我们就需要考虑 API 自身所具备的功能了。如果您需要的功能仅 OpenMP 具备，那就选择 OpenMP。同理，如果您需要的功能仅 TBB 具备，那就使用 TBB。如果您需要的功能 TBB 和 OpenMP 均具备，此时，我们建议您考虑维护成本：尽管TBB 和 OpenMP 均可跨操作系统迁移，但它们在编程风格方面还是各有侧重，且对开发环境也有不同的要求。TBB 和 OpenMP 这两种 API 可以共存，但也可能出现性能问题（详见“共存”节论述）。因此，建议您最好选择能够满足您所有需求的模式。如果您正在进行一项新的设计方案，并计划使用 C++ 语言编程，那么 TBB 应该是个不错的选择：因为它支持预期并行的增加，允许执行更多并行运算，且无需创建那些可能导致过度使用的不必要的线程。

当然，预期在同一算法中，基于英特尔® TBB、OpenMP 和本地线程的解决方案的执行效果还是相差无几的（提供同等水平的性能）。但是，低水平本地线程 API 必然会产生大量附加编码成本，因此，相比而言，TBB 和 OpenMP 更可取一些。

共存

TBB、OpenMP 和本地线程可以共同使用，三者之间也可实现互操作。但是，由于 TBB 和 OpenMP 运行时库创建独立的线程池，且在缺省状态下，每个线程池还会创建多条线程来匹配内核数量，这就可能导致线程过量的问题。此外，两组 worker 线程还均用于计算密集型工作，这也会不可避免地造成线程过量问题。因此，我们建议您利用英特尔® TBB 来重写 OpenMP 代码（如果 TBB 符合应用程序设计标准）。这样，OpenMP 工作就不会与 TBB 活动交迭，线程过量也就自然而然地解决了。

鉴于英特尔® TBB 任务调度程序未采用公平和优先机制。因此，不推荐您使用英特尔® TBB 来处理 I/O 有界任务（bound task）。这时，本地线程是您最佳选择，而且它还可与英特尔® TBB 组件共存。

结论

线程化方法的选择是并行应用程序设计流程中的重要环节。没有一款解决方案能够满足所有需求、适用于各种环境。它们有些需要编译器支持，有些不可跨 OS 迁移，或者未采用专门的线程化分析工具。英特尔® 线程构建模块拥有丰富的结构框架，涵盖了众多常用并行设计模式，能够通过提供并发数据容器、同步基元、并行算法以及可扩展内存分配算符，帮助开发人员更快地创建可扩展程序。