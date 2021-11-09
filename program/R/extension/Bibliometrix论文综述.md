# Bibliometrix论文综述

作者：知乎用户

链接：https://www.zhihu.com/question/317450604/answer/1398705794

来源：知乎

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

## 那当然是要推荐小众但异常强大的Bibliometrix了！！！

![img](https://pic1.zhimg.com/50/v2-6e588ad2eab341609c728a9d995c297e_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-6e588ad2eab341609c728a9d995c297e_720w.jpg?source=1940ef5c)

## **写在前边**

不管是了解一个新的领域还是开启科研的第一步，一般都是从写一篇综述开始的。下边我将通过介绍是如何通过这个网站一步一步完成一个新领域的综述的。首先是导师给了一个研究方向——城市微生物。正常初级选手写综述的逻辑一般是这样子的：首先我在谷歌学术或者各种数据库搜索关键词或相近关键词，然后开始找高引用量的几篇，高被引用量的几篇，最新最相关的几篇。然后开始一篇篇地来读。读的时候基本也都是精读（虽然过程往往难以坚持）并做笔记勾画，顺势为这篇综述列一个大纲，当再次读的时候就已经开始整合句子写到自己的综述里了。初稿写完然后再修改一下，一篇综述基本就这么诞生了。
**但是，这并不是一个好办法。**
首先，凡是流程化标准化生产操作都会极大的提高速度，而“流程”和“标准”的设定直接决定了这件事情的效率，虽然上边这种常规方法可以写出不少东西，绝对能完成一篇综述，但还不够高效。
其次，能交给计算机解决的重复性、经验性劳动都不需要再浪费人力时间。筛选文献这个过程中很多流程是可以交给代码和算法解决的。就比如怎么确定哪些文献需要精读，哪些过一遍就好，哪些可以直接排除，这可不是单纯的看被引次数就可以决定的。而这可以用很多软件来解决，筛选出来的文献直接决定你能否在短时间内对这个领域有比较全面的了解，从而决定综述的质量。
最后，阅读文献的过程也需要一个标准化流程，它不是简单地从头读到尾，你可能会在读完100篇文献后对这个方向的文献结构有初步的了解，但是不如先在读之前就了解某类文献的架构。
所以，借写综述这件事，一方面当然是了解这个领域，一方面就是要思考这些问题，寻找可以优化的方案。
所以这个专题，一边记录一边分享接下来的三个问题。
**第一，如何高效地了解一个新的科研领域？**
**第二，如何高效筛选某个领域的重要文献？**

[如何快速筛选领域内必读文献500 赞同 · 94 评论文章](https://zhuanlan.zhihu.com/p/107053243)



[研究生如何高效地阅读文献，并总结成读书报告？82 赞同 · 5 评论回答![img](https://pic3.zhimg.com/v2-3a758f0aa1c6c33c6fbfd99faf6e348a_180x120.jpg)](https://www.zhihu.com/question/51424240/answer/1764044790)


**第三，如何写出自己的第一篇综述类文章？**



**如果通过这篇文章让你更加高效的阅读文献，那请点个赞让我知道~**

## **如何高效地了解一个新的科研领域？**

以研究方向“城市微生物”为例，这里我们需要借助一款神器，在R语言下的一款软件包Bibliometrix，可以完成很多文献计量分析的功能，你可以用它来发现谁是这个领域的大牛，哪些文献值得一读，什么主题更值得研究，最重要的是，你可以把这些统计通过这个软件可视化处理。

### **1、如何安装Bibliometrix**

首先需要安装R和Rstudio，具体操作简单，可以去网上看教程或者直接找到官网下载便可。需要注意的一点是安装目录必须全是英文，这样会避免很多奇怪的错误。安装好后打开Rstudio。

![img](https://pic3.zhimg.com/50/v2-28cf14d860844199a4144b3bdb0b3906_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-28cf14d860844199a4144b3bdb0b3906_720w.jpg?source=1940ef5c)

这时候需要安装一个package，"bibliometrix"，新建一个项目，然后输入下面代码运行：

> install.packages("bibliometrix")
> library('bibliometrix')
> biblioshiny()

等待代码运行完成，便进入一个网页操作界面。显示这个界面说明这个包已经安装好了。接下来就可以正常进行文献分析。

![img](https://pic3.zhimg.com/50/v2-1b17925ef27685c493215f5c15f487f8_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-1b17925ef27685c493215f5c15f487f8_720w.jpg?source=1940ef5c)操作界面

## **2、如何分析现有相关文献**

### **关键词的选取**

在分析文献前，我们先需要确定关键词来检索方向。
在选取关键词除了导师确定的主题，还应该考虑有没有其他的替代词(animalcule/microorganism/)，是否有词汇拼写的变体，断词的词干是什么（micro--microorganism/microbe/microbiota）,是否有常用缩略语，有没有需要排除的类型。
这里我们选microbial、organism、Microbe、germ、microorganism结合urban、city，进行搜索，选用WOS核心合集数据库。
但是如果真的用这么多关键词来搜索文章，工作量相当大。就比如下边是一个大数据和机器学习领域的文章，如果要按关键词尽可能找到相关的文章就太麻烦了，虽然精确。

![img](https://pic2.zhimg.com/50/v2-799a8014acc65ed74a4cf7c7081d98fc_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-799a8014acc65ed74a4cf7c7081d98fc_720w.jpg?source=1940ef5c)

但是如果能找到文章之间的关系，只要用几个关键词简单勾勒出一篇文章的相关文章，给一个大致方向，再借助之前我们提到的HistCite软件中，就能分析出这个领域其他相关文章。所以筛选的时候选择常见的一些单词就可以。这里我们选urban、city、microbial、microorganism四个单词，两两组合。筛选导出相关文献分析。

![img](https://pica.zhimg.com/50/v2-6f3b900ff919af7f1ad6b67864805eea_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-6f3b900ff919af7f1ad6b67864805eea_720w.jpg?source=1940ef5c)

### **导出相关文献**

如果是WOS选择核心合集，然后再输入关键词，搜索文章后，选择导出。

![img](https://pic3.zhimg.com/50/v2-59958b69dd3551fc3b075f9057acfd47_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-59958b69dd3551fc3b075f9057acfd47_720w.jpg?source=1940ef5c)

导出时依次选择**"导出--其它文件格式-全记录与引用的参考文献--BibTex"。**

![img](https://pic3.zhimg.com/50/v2-480b1985427dc9dbc850da9b7a353b3c_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-480b1985427dc9dbc850da9b7a353b3c_720w.jpg?source=1940ef5c)

![img](https://pic3.zhimg.com/50/v2-83592cae47ea42ed25a8d1bd5d7f4145_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-83592cae47ea42ed25a8d1bd5d7f4145_720w.jpg?source=1940ef5c)

Bibliometrix目前支持很多数据库，除了WOS还有Scopus，Dimension，PudMed，Cochrane library都可以选择BibTex格式导出然后分析。Bibliometrix的整个工作思路如下图介绍。数据收集--导入分析--可视化呈现。

![img](https://pica.zhimg.com/50/v2-194dede825179939d809ed4b1d0d98db_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-194dede825179939d809ed4b1d0d98db_720w.jpg?source=1940ef5c)

### **导入待分析文献**

上一步收集到的文献可以放到一个压缩包里，一起分析。一次只能分析一个文件夹。用Rstudio将Bibliometrix运行后，依次选择下图所示模块，将收集导出的文献导入Bibliometrix。

![img](https://pic3.zhimg.com/50/v2-a47753bd6737671bee902cbedaa9eb8c_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-a47753bd6737671bee902cbedaa9eb8c_720w.jpg?source=1940ef5c)

![img](https://pic2.zhimg.com/50/v2-d4e7c69aa3e6017f042f63d140c0d297_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-d4e7c69aa3e6017f042f63d140c0d297_720w.jpg?source=1940ef5c)

导入成功后，导入的文献基本信息被呈现出来，绿色的部分超链接可以直接点击跳转，DOI，AU这行可以通过点击，使文献按不同的指标排序。

![img](https://pic2.zhimg.com/50/v2-77f80df50ced6e2525a7b9d7c21c1e18_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-77f80df50ced6e2525a7b9d7c21c1e18_720w.jpg?source=1940ef5c)

所筛选的文献可以通过选择Filter进行筛选过滤。

![img](https://pica.zhimg.com/50/v2-efd89f4eec0fb86bafd6c9f2c1549a27_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-efd89f4eec0fb86bafd6c9f2c1549a27_720w.jpg?source=1940ef5c)

导出文献的一些基本信息统计数据汇总。

![img](https://pic3.zhimg.com/50/v2-f37581be71c90f7c8da4e22e952398b2_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-f37581be71c90f7c8da4e22e952398b2_720w.jpg?source=1940ef5c)

## **3、依靠软件分析要解决的问题**

一些基本的操作大家可以随便去点，尝试不同的功能会展示出什么样的信息和图表。下面我们来分析一下“城市微生物”领域的这些问题。

### **问题一：【期刊分析】哪个期刊跟这个领域最相关？**

Most Relevant Sources

![img](https://pica.zhimg.com/50/v2-511336cb6e813f5f01f3926d3190b536_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-511336cb6e813f5f01f3926d3190b536_720w.jpg?source=1940ef5c)

横纵坐标可以看到**Science of the Total Environment**这本杂志最相关，然后依次是**Water Research**、**Frontiers in Microbiology**等。而基于我们目前收集到的文献，又是另外一个排序。（说明这几个关键词搜索的并不准确，但够用了，已经起到了抛砖迎玉的效果）

Most Local Cited Sources (from Reference Lists)

![img](https://pic2.zhimg.com/50/v2-4e3bc4e615ea840b71e1709cf703f420_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-4e3bc4e615ea840b71e1709cf703f420_720w.jpg?source=1940ef5c)

另外还可以看到这个领域相关的文献都集中在哪些期刊上。

![img](https://pic2.zhimg.com/50/v2-afe26e6c5951abf8916f19e5a88bad58_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-afe26e6c5951abf8916f19e5a88bad58_720w.jpg?source=1940ef5c)Source clustering through Bradford&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;#39;s Law

我们放大看。（在深灰色区域可以进行放大查看）如下图。

![img](https://pic1.zhimg.com/50/v2-ff233dfe108871b1065da4e6af675b3e_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-ff233dfe108871b1065da4e6af675b3e_720w.jpg?source=1940ef5c)

但是不如直接给出列表，什么期刊指标多少，依次排序。（这个包有很多的功能，虽然是用不同的图表，但是展示同样的内容）可以看到排序还是跟刚才一致。投稿时候可以多关注一下排名靠前的几个期刊。

![img](https://pic1.zhimg.com/50/v2-a90abbccf15d146b8a95e0ebd87e1d46_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-a90abbccf15d146b8a95e0ebd87e1d46_720w.jpg?source=1940ef5c)

看完来源，我们来看一下这些来源的影响力是不是跟它相关文献的数量相关。

![img](https://pic3.zhimg.com/50/v2-cb69cde9691a9876f9e53c3cc00ba46c_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-cb69cde9691a9876f9e53c3cc00ba46c_720w.jpg?source=1940ef5c)Source Impact


所谓的H指数，是指有H篇高于H的文章。这里期刊影响力也是按这个指标来排序的。

我们分析的再深入一些，这些期刊的相关文献增长的数量趋势如何。投稿或者阅读文献时候可以稍作参考。这里可以按每年增长排序也可以按累计增长排序。

![img](https://pic2.zhimg.com/50/v2-5cd0e90d67be485e16deb4d394631a36_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-5cd0e90d67be485e16deb4d394631a36_720w.jpg?source=1940ef5c)Source Dynamics

我们对相关领域的期刊范围有大致的了解后，再考虑第二个问题。

### **问题二：【作者分析】这个领域都有哪些大牛？**

同样的逻辑，我们可以分析以下指标：

![img](https://pic3.zhimg.com/50/v2-7316b70ced6c905f0cb8616889fce621_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-7316b70ced6c905f0cb8616889fce621_720w.jpg?source=1940ef5c)

全球范围最相关的作者，已经导入的文献中最相关的作者，最相关的机构，每个国家产量等等指标。多图如下。

**Most Local Cited Authors**

![img](https://pic2.zhimg.com/50/v2-278d1ce7d0db612ccd6dd1aec5dcc868_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-278d1ce7d0db612ccd6dd1aec5dcc868_720w.jpg?source=1940ef5c)Most Local Cited Authors

**Author Impact**

![img](https://pic2.zhimg.com/50/v2-08daf40921b3b35659e2309e8c14e5fd_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-08daf40921b3b35659e2309e8c14e5fd_720w.jpg?source=1940ef5c)Author Impact

**Most Relevant Affiliations**

![img](https://pic3.zhimg.com/50/v2-226e1ed092fff0d24c0b44f4209afa06_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-226e1ed092fff0d24c0b44f4209afa06_720w.jpg?source=1940ef5c)Most Relevant Affiliations

**Corresponding Author's Country**

![img](https://pic1.zhimg.com/50/v2-6d7cf4dbeabf5cdbf678a09fec764b95_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-6d7cf4dbeabf5cdbf678a09fec764b95_720w.jpg?source=1940ef5c)Corresponding Author&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;#39;s Country

**Country Scientific Production**

![img](https://pic3.zhimg.com/50/v2-4b53d20a1f1e400e46a86a2914e53476_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-4b53d20a1f1e400e46a86a2914e53476_720w.jpg?source=1940ef5c)Country Scientific Production

本地文章被引用次数。这个跟直接在数据库中按被引排序是一致的。有同学会说，查看被引用次数高的文章不就可以了吗，为什么还要这么麻烦去分析引文。其实举个例子，一些选秀节目常会有两类评委，一类是专家评委，一类是大众评委，两者权重不一样，因为专业程度不同。一篇文章就类似于参赛选手。如果只看被引次数，就相当于专家评委和大众评委按相同的权重给这个“选手”打分，这样的排名结果并不能真正反映“选手”的真实水平。所以我们要分析引文，找同行评价，也就是“专家"评委。一篇被同行引用次数高的文章（专家打分高）要比一篇总被引用量高的文章更值得去读（大众评委和专家评委权重相同打分）

Most Local Cited Documents

![img](https://pic2.zhimg.com/50/v2-82b253d557ab7d6537d9d9f563c97f84_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-82b253d557ab7d6537d9d9f563c97f84_720w.jpg?source=1940ef5c)Most Local Cited Documents

也确实当我点开这里排在最前边的文章，发现跟“城市微生物”并不相关。这个部分我们得到一些关于作者、机构的信息。对于专业领域相关的高产作者，可以谷歌学术设置订阅，当他有新文章发表，就会自动给你发送到邮箱提醒。同时你也可以以作者为中心，进行文献的阅读，同样也会非常精准高效。

另外，作者间的相互关系也非常重要，哪些领域有哪些人来研究，我们可以通过Co-citation Network了解一下。

Co-citation Network

![img](https://pic3.zhimg.com/50/v2-31f92a8ca05df1a5296418761c3a1bd6_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-31f92a8ca05df1a5296418761c3a1bd6_720w.jpg?source=1940ef5c)Co-citation Network

功能很多，按需分析就好。

### **问题三：【关键词分析】这个领域有哪些高频关键词？**

我们继续分析，看摘要需要看近万字才能对某个领域方向有一定的了解，但是看出现的高频词，效率会极大提高（虽然依然还要阅读文献摘要吧）这里我们用三种不同的形式，依次分析作者关键词，领域关键词，摘要关键词,以及他们的变化趋势。如下图WordCloud：

![img](https://pic3.zhimg.com/50/v2-054b3089693953628d47f80ddbe8ab75_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-054b3089693953628d47f80ddbe8ab75_720w.jpg?source=1940ef5c)Keywords

**Author‘s keywords：**

![img](https://pic1.zhimg.com/50/v2-f038be84a160708e779fea80f93e4115_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-f038be84a160708e779fea80f93e4115_720w.jpg?source=1940ef5c)

**Abstracts:**

![img](https://pic3.zhimg.com/50/v2-4dee6ef823f51d5af96ac81367e2a076_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-4dee6ef823f51d5af96ac81367e2a076_720w.jpg?source=1940ef5c)

### Word Dynamics

**Keywords plus：**

![img](https://pic2.zhimg.com/50/v2-8da3d113f3a37e4a4907a71f9b42bf62_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-8da3d113f3a37e4a4907a71f9b42bf62_720w.jpg?source=1940ef5c)Keywords plus

**Author's keywords:**

![img](https://pica.zhimg.com/50/v2-983744fbac1daa4985d52e89980fbf29_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-983744fbac1daa4985d52e89980fbf29_720w.jpg?source=1940ef5c)Author&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;#39;s keywords

**Abstracts：**

![img](https://pic3.zhimg.com/50/v2-b31fb3167b54540e79767de13ac0321f_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-b31fb3167b54540e79767de13ac0321f_720w.jpg?source=1940ef5c)Abstracts

这些指标信息除了直观的可视化呈现，也可以选择使用表格呈现具体细节。面积越大，出现的频率越高。

我们可以看到这些关键词按出现次数从高到低排序。多样性、细菌、微生物、大肠杆菌、废水、土壤、城市化、真菌、群落、有机的、修复这些词出现的频率很高。下图是Keywords plus：

![img](https://pic1.zhimg.com/50/v2-d5efe80240fe0f12db1e38d6a8aa4727_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-d5efe80240fe0f12db1e38d6a8aa4727_720w.jpg?source=1940ef5c)Keywords plus

接下来我们再分析这些关键词的变化趋势：

**Word Dynamics**

**Keywords plus（领域关键词）**

![img](https://pica.zhimg.com/50/v2-8da3d113f3a37e4a4907a71f9b42bf62_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-8da3d113f3a37e4a4907a71f9b42bf62_720w.jpg?source=1940ef5c)Keywords plus

**Abstracts（摘要关键词）**

![img](https://pic1.zhimg.com/50/v2-b31fb3167b54540e79767de13ac0321f_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-b31fb3167b54540e79767de13ac0321f_720w.jpg?source=1940ef5c)Abstracts

**Author's keywords（作者自己写的关键词）**

![img](https://pic3.zhimg.com/50/v2-983744fbac1daa4985d52e89980fbf29_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-983744fbac1daa4985d52e89980fbf29_720w.jpg?source=1940ef5c)Author&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;#39;s keywords

这里就可以很明显的看出这些不同类别下的关键词变化趋势了。你可以在选题或者选方向时候，以此作为初步参考。这里的显示分析关键词的数量也可以自己调整。但是就是看完这些关键词，依然会是一个比较模糊的总体上的认识。需要借助关键词的一些变化，再尽可能多的了解。

**问题四：【领域研究】有哪些方向值得被研究？**

**Trend Topics**
从Keywords plus和Abstrcts的trend topics中我们可以看到这些主题词被以横坐标为年份，纵坐标为出现的频率的对数放在了一个坐标内。哪些方向是比较新的，哪些方向是研究最多的一目了然。就比如**城市、迁移、饮用水、土地利用、群落、降解、16s核糖体核糖核酸、生物多样性、多环芳香烃、流行病、序列、实时的PCR、城市污泥、抗生素、大肠杆菌**等都是研究的热点方向/方法。而**气象因素、耐药基因组、雾霾天气、风险评估**目前比较新，研究的人也较少。当然至于这些是因为刚开始研究导致出现的频率低还是因为非常小众或者昙花一现就得做进一步判断了。但有一点是肯定的，越靠近坐标轴的右上方，越值得多关注。

![img](https://pica.zhimg.com/50/v2-4bb1a81f51ae04c13cc674507350bc9e_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-4bb1a81f51ae04c13cc674507350bc9e_720w.jpg?source=1940ef5c)Trend Topics

![img](https://pic2.zhimg.com/50/v2-236cd610d93c9a8ff5448a98a45608ba_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-236cd610d93c9a8ff5448a98a45608ba_720w.jpg?source=1940ef5c)

分析了关键词，我们可以让这个package直接给我们一个参考，哪些领域值得研究？这里选择工具栏中的**Conceptual Structure--Thematic Map**，选择好参数后点击**Apply!**，会呈现出下图，横轴表示中心度，纵轴表示密度。

- 第一象限（右上角）是最值得研究的领域，因为它们及重要又有了良好的发展；
- 第二象限（左上角）表示发展的虽然好，但是似乎对这个领域没有产生多大影响；
- 第三象限（左下角）表示比较边缘的领域，研究的人很少，既可能是很新，也可能是昙花一现。
- 第四象限（右下角）小而精的领域，很重要但是目前发展的并不是太好，一般多是一些基础概念。
  我们发现之前单独分析关键词，如果仅仅按时间和频率两个维度分析是远远不够的，就比如水污染，虽然出现频率很高，但是影响却小。因此还需要结合这个象限，对关键词再加上影响力和密度等维度进行分析。当然一切的数据分析都只是作为参考，就像航拍图，精度不是那么够，但是能快速的宏观呈现。

![img](https://pic2.zhimg.com/50/v2-4425a7b668fe8f12be332801c4ba973d_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-4425a7b668fe8f12be332801c4ba973d_720w.jpg?source=1940ef5c)

说到这里，又有另外一个问题了，因为我们之前的关键词只选了四个，两两组合，那么相近关键词的选择以及被分析文献的数量对分析的结果有没有影响，影响大不大。如下图：

分析500篇参考文献：

![img](https://pic1.zhimg.com/50/v2-b46ecaf1876b53cecfb7d158cf065566_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-b46ecaf1876b53cecfb7d158cf065566_720w.jpg?source=1940ef5c)

1500篇：

![img](https://pic3.zhimg.com/50/v2-d0adb425edd14a972bb1f86faea41287_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-d0adb425edd14a972bb1f86faea41287_720w.jpg?source=1940ef5c)

2500篇：

![img](https://pic3.zhimg.com/50/v2-b71b79f78496668362d1497b082aa684_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-b71b79f78496668362d1497b082aa684_720w.jpg?source=1940ef5c)

4000篇：

![img](https://pic1.zhimg.com/50/v2-05e48dca11e4beea5ad7fe1c6a4552b5_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-05e48dca11e4beea5ad7fe1c6a4552b5_720w.jpg?source=1940ef5c)

我们发现差距并不太明显，当然数量越多越精确，但是3000-4000篇就足够了。

**问题五：【领域关系】不同方向之间有怎样的相互关系？**

或者说，我该用哪几个关键词来限制一篇文章？如果需要进一步了解这些主题之间的关系，我们同样也可以分析哪些主题会经常出现在统一领域内：

![img](https://pica.zhimg.com/50/v2-5e9147da2b80ecfbc7b93b00c3aaf747_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-5e9147da2b80ecfbc7b93b00c3aaf747_720w.jpg?source=1940ef5c)

![img](https://pic3.zhimg.com/50/v2-ccd1a54b47e6e9a67e50ad7b016b3d6a_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-ccd1a54b47e6e9a67e50ad7b016b3d6a_720w.jpg?source=1940ef5c)

第一个图比较直观，离得越近说明联系越紧密，第二个图就可以看一些具体指数了（点击Table）。我们看到，多环芳烃、废水处理、生物降解、活性污泥、微生物群落被分为第三组，经常同时出现，大肠杆菌、患病率、饮用水、16s核糖体RNA、城市、实时PCR、细菌、鉴定、污染被分为第一组，多样性、微生物群落、碳、氮、生物质、土地利用、动力学、沉积物、管理、微生物量被分为第二组。这种做法就相当于在黑夜中，发射几枚照明弹，你能短时间了解整个状况，但要想长时间照亮，还得多读文献，真正对这个领域有更深入了解。但是毕竟Something is better than nothing。对于小白来说，这会极大降低阅读文献时候的难度和“懵”度。

要想再具体清晰地对这些词之间有了解，也是可以的，如下图：

![img](https://pic1.zhimg.com/50/v2-b96959ba7b81ee6741f297348c94610f_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-b96959ba7b81ee6741f297348c94610f_720w.jpg?source=1940ef5c)Word map

![img](https://pic2.zhimg.com/50/v2-d1ae0aa8c8fce2210e46f6cde588061d_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-d1ae0aa8c8fce2210e46f6cde588061d_720w.jpg?source=1940ef5c)Topic Dendrogram

同样也可以分析该领域文章的影响力。

### **问题六：【文章筛选】哪些文章值得真正去精读？**

在上一篇**《如何高效筛选领域内必读文献》**中提到了我们该怎么挑文献。可以参考一下，配合使用。

[如何快速筛选领域内必读文献500 赞同 · 94 评论文章](https://zhuanlan.zhihu.com/p/107053243)

这里如果单纯靠Bibliometrix这个包效果并不好。这里同样用到两个指标：
LCS，GCS。

> The total global citation score (TGCS) is a bibliometric measure that indicates the number of citations of studies by all other studies indexed in the WoS database.
> Another citation metric, the total local citation score (TLCS), refers to the number of citations of studies by the sample of studies in a certain field.

这里把分析的结果附上，其实读不出太多有用的信息。第一个是某领域文献的发展历程。

![img](https://pic3.zhimg.com/50/v2-5fa7357a61f519fd36125f0a58aae16a_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-5fa7357a61f519fd36125f0a58aae16a_720w.jpg?source=1940ef5c)

第二个是对于收集的文献按不同指标排序：

![img](https://pic2.zhimg.com/50/v2-bf2f5336772a9db114899ccb3e54f790_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-bf2f5336772a9db114899ccb3e54f790_720w.jpg?source=1940ef5c)

然而没有对比就没有伤害，分析趋势，当然还是Bibliometrix强大，但是筛选文献，还是得靠HistCite，具体步骤可参考上篇文章。这里把分析后的文章间关系直接呈现给大家。这是分析后展示排名前60篇相互关系的图像：

![img](https://pic1.zhimg.com/50/v2-ffe5696a3e30b1e3698cd8a71a6f1b5c_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-ffe5696a3e30b1e3698cd8a71a6f1b5c_720w.jpg?source=1940ef5c)

这是分析后排名前200篇相互间关系图像：**［软件安装包直接私信我就好，看到我会一个个发给大家的，记得点赞关注哦］**

![img](https://pica.zhimg.com/50/v2-0c8432c025b867fcd04a7a8234a61f13_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-0c8432c025b867fcd04a7a8234a61f13_720w.jpg?source=1940ef5c)

当然可以导出高清大图，上边节点标注了文献的序号，可以对应找到。通过这个图，我们能获得下边三个问题的答案：

- **这个领域被分为哪几部分？**

可以根据上边的图看到，城市微生物大致分成了三大块（可以看到这三块之间的联系明显没有三块各自内部之间的联系丰富）。

- **哪些文献是这个领域的经典文献？**

图片的上方是早期发表的文献，指向这篇文献的箭头越多，说明他被同行引用的次数越多，各种同行专家都看这篇文章，那毫无疑问它大概率上很重要。

- **如果想了解这个领域的发展脉络该按什么顺序来读？**

按照从上到下，可以看到一个领域开山鼻祖是哪篇文献，之后又经历了怎样的一步步发展，阅读文献时候，可以看下这篇文献处于这个图或者这个领域的哪个地方，你就知道自己接下来该读哪些文献，是不是最新的研究，还有没有更好的介绍等信息。

**如果通过这篇文章让你更加高效的阅读文献，那请不要吝啬您的点赞关注，这将成为我创作和探索的动力~感谢！**

[编辑于 11-01](http://www.zhihu.com/question/317450604/answer/1398705794)