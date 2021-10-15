# TeX 家族（TeX, pdfTeX, XeTeX, LuaTeX, LaTeX, pdfLaTeX, XeLaTeX …）



[不要再见](https://blog.csdn.net/henu111) 2018-07-27 16:26:10 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 11548 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 6

分类专栏： [LaTex](https://blog.csdn.net/henu111/category_7879323.html) 文章标签： [TeX](https://so.csdn.net/so/search/s.do?q=TeX&t=blog&o=vip&s=&l=&f=&viparticle=) [pdfTeX](https://so.csdn.net/so/search/s.do?q= pdfTeX&t=blog&o=vip&s=&l=&f=&viparticle=) [XeTeX](https://so.csdn.net/so/search/s.do?q= XeTeX&t=blog&o=vip&s=&l=&f=&viparticle=) [LuaTeX](https://so.csdn.net/so/search/s.do?q= LuaTeX&t=blog&o=vip&s=&l=&f=&viparticle=) [La](https://so.csdn.net/so/search/s.do?q= La&t=blog&o=vip&s=&l=&f=&viparticle=) [TeX家族](https://so.csdn.net/so/search/s.do?q=TeX家族&t=blog&o=vip&s=&l=&f=&viparticle=)



[![img](https://img-blog.csdnimg.cn/20201014180756927.png?x-oss-process=image/resize,m_fixed,h_64,w_64)LaTex](https://blog.csdn.net/henu111/category_7879323.html)专栏收录该内容

4 篇文章0 订阅

订阅专栏

## TeX 家族

带有 TeX 的词，仅仅是本文就已经提到了 TeX, LaTeX, XeLaTeX。通常中国学生面对不了解意思的一群形近单词，都会有一种「本能的恐惧」（笑~）。
因此，「大神们」在为新手介绍 TeX 的时候，如果互相争论 「XXTeX 比 YYTeX 好」或者是「XXTeX 的 YYTeX 如何如何」，往往会蹦出下面这些带有 TeX 的词汇：
TeX, pdfTeX, XeTeX, LuaTeX, LaTeX, pdfLaTeX, XeLaTeX …

事实上，这部分的内容太过复杂，我自己的了解也实在有限。所以下面这部分的内容也只能是对我了解到的知识的一个概括，甚至可能有些许谬误。所以大家只需要将这部分的内容当做是一个参考就可以了。

### TeX - LaTeX

TeX 是高德纳（Donald Ervin Knuth，1938年1月10日 –）教授愤世嫉俗（大雾；追求完美）做出来的排版引擎，同时也是该引擎使用的标记语言（Markup Lang）的名称。这里所谓的引擎，是指能够实现断行、分页等操作的程序（请注意这并不是定义）；这里的标记语言，是指一种将控制命令和文本结合起来的格式，它的主体是其中的文本而控制命令则实现一些特殊效果（同样请注意这并不是定义）。

> 你可以在[这里](http://en.wikipedia.org/wiki/TeX)找到关于 TeX 引擎的具体描述；
>
> 你可以在[这里](http://en.wikipedia.org/wiki/Markup_language)找到关于标记语言的具体描述。

而 LaTeX 则是 L. Lamport （1941年2月7日 – ） 教授开发的基于 TeX 的排版系统。实际上 LaTeX 利用 TeX 的控制命令，定义了许多新的控制命令并封装成一个可执行文件。这个可执行文件会去解释 LaTeX 新定义的命令成为 TeX 的控制命令，并最终交由 TeX 引擎进行排版。

> 实际上，LaTeX 是基于一个叫做 plain TeX 的格式的。plain TeX 是高德纳教授为了方便用户，自己基于原始的 TeX 定义的格式，但实际上 plain TeX 的命令仍然十分晦涩。至于原始的 TeX 直接使用的人就更少了，因此 plain TeX 格式逐渐就成为了 TeX 格式的同义词，尽管他们事实上是不同的。

因此在 TeX - LaTeX 组合中，

1. 最终进行断行、分页等操作的，是 TeX 引擎；
2. LaTeX 实际上是一个工具，它将用户按照它的格式编写的文档解释成 TeX 引擎能理解的形式并交付给 TeX 引擎处理，再将最终结果返回给用户。

### pdfTeX - pdfLaTeX

TeX 系统生成的文件是 *dvi* 格式，虽然可以用其他程序将其转换为例如 pdf 等更为常见的格式，但是毕竟不方便。

> dvi 格式是为了排版而产生的，它本身并不支持所谓的「交叉引用」，pdfTeX 直接输出 pdf 格式的文档，这也是 pdfTeX 相对 TeX 进步（易用性方面）的地方。

为了解决这个问题，Hàn Thế Thành 博士在他的博士论文中提出了 pdfTeX 这个对 TeX 引擎的扩展。二者最主要的差别就是 pdfTeX 直接输出 pdf 格式文档，而 TeX 引擎则输出 dvi 格式的文档。

> pdfTeX 的信息可以查看[wiki](http://en.wikipedia.org/wiki/PdfTeX).

pdfLaTeX 这个程序的主要工作依旧是将 LaTeX 格式的文档进行解释，不过此次是将解释之后的结果交付给 pdfTeX 引擎处理。

### XeTeX - XeLaTeX

高德纳教授在实现 TeX 的当初并没有考虑到中日韩等字符的处理，而只支持 ASCII 字符。这并不是说中日韩字符就无法使用 TeX 引擎排版了，事实上 TeX 将每个字符用一个框包括起来（这被称为**盒子**）然后将一个个的盒子按照一定规则排列起来，因而 TeX 的算法理论上适用于任何字符。ASCII 字符简单理解，就是在半角模式下你的键盘能直接输出的字符。

在 XeTeX 出现之前，为了能让 TeX 系统排版中文，国人曾使用了 天元、CCT、**CJK** 等手段处理中文。其中 天元和CCT 现在已经基本不用，CJK 因为使用时间长且效果相对较好，现在还有人使用。

不同于 CJK 等方式使用 TeX 和 pdfTeX 这两个不直接支持 Unicode 字符的引擎，XeTeX 引擎直接支持 Unicode 字符。也就是说现在不使用 CJK 也能排版中日韩文的文档了，并且这种方式要比之前的方式更加优秀。

XeLaTeX 和 XeTeX 的关系与 pdfLaTeX 和 pdfTeX 的关系类似，这里不再赘述。

使用 XeTeX 引擎需要使用 UTF-8 编码。

> 所谓编码就是字符在计算机储存时候的对应关系。例如，假设有一种编码，将汉字「你」对应为数字「1」；「好」对应为数字「2」，则含有「你好」的纯文本文件，在计算机中储存为「12」（读取文件的时候，将「12」再转换为「你好」显示在屏幕上或打印出来）。
>
> UTF-8 编码是 Unicode 编码的一种，可以参考它的 [wiki](http://en.wikipedia.org/wiki/UTF-8).

### LuaTeX

LuaTeX 是正在开发完善的一个 TeX 引擎，相对它的前辈们还相当的不完善，这里不赘述。

### CTeX - MiKTeX - TeX Live

之前介绍了 TeX, LaTeX, pdfTeX, pdfLaTeX, XeTeX, XeLaTeX, LuaTeX 等，他们都是 TeX 家族的一部分。但是作为一个能够使用的 TeX 系统，仅仅有他们还是不够的。CTeX, MiKTeX, TeX Live 都是被称为「发行」的软件合集。他们包括了上述各种引擎的可执行程序，以及一些文档类、模板、字体文件、辅助程序等等。其中 CTeX 是建立在 MiKTeX 的基础之上的。