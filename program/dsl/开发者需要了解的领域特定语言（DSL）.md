# 开发者需要了解的领域特定语言（DSL）

[![Java进阶程序员xx](https://pic1.zhimg.com/v2-c23060a374a96e49871e43fb7596b001_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/qq475968700)

[Java进阶程序员xx](https://www.zhihu.com/people/qq475968700)





8 人赞同了该文章



![img](https://pic4.zhimg.com/80/v2-7f031ffd44dbc828e90f1f25325c540f_720w.jpg)

领域特定语言是在特定领域下用于特定上下文的语言。作为开发者，很有必要了解领域特定语言的含义，以及为什么要使用特定领域语言。

领域特定语言domain-specific language （DSL）是一种旨在特定领域下的上下文的语言。这里的领域是指某种商业上的（例如银行业、保险业等）上下文，也可以指某种应用程序的（例如 Web 应用、数据库等）上下文。与之相比的另一个概念是 通用语言general-purpose language （GPL，LCTT 译注：注意不要和 GPL 许可证混淆），通用语言则可以广泛应用于各种商业或应用问题当中。

DSL 并不具备很强的普适性，它是仅为某个适用的领域而设计的，但它也足以用于表示这个领域中的问题以及构建对应的解决方案。HTML 是 DSL 的一个典型，它是在 Web 应用上使用的语言，尽管 HTML 无法进行数字运算，但也不影响它在这方面的广泛应用。

而 GPL 则没有特定针对的领域，这种语言的设计者不可能知道这种语言会在什么领域被使用，更不清楚用户打算解决的问题是什么，因此 GPL 会被设计成可用于解决任何一种问题、适合任何一种业务、满足任何一种需求。例如 Java 就属于 GPL，它可以在 PC 或移动设备上运行，嵌入到银行、金融、保险、制造业等各种行业的应用中去。

### **DSL 的类别**

从使用方式的角度，语言可以划分出以下两类：

- DSL：使用 DSL 形式编写或表示的语言
- 宿主语言host language ：用于执行或处理 DSL 的语言

由不同的语言编写并由另一种宿主语言处理的 DSL 被称为 外部external DSL。

以下就是可以在宿主语言中处理的 SQL 形式的 DSL：

```text
SELECT account
FROM accounts
WHERE account = '123' AND branch = 'abc' AND amount >= 1000
```

因此，只要在规定了词汇和语法的情况下，DSL 也可以直接使用英语来编写，并使用诸如 ANTLR 这样的 解析器生成器parser generator 以另一种宿主语言来处理 DSL：

```text
if smokes then increase premium by10%
```

如果 DSL 和宿主语言是同一种语言，这种 DSL 称为 内部internal DSL，其中 DSL 由以同一种语义的宿主语言编写和处理，因此又称为 嵌入式embedded DSL。以下是两个例子：

- Bash 形式的 DSL 可以由 Bash 解释器执行：

```text
if today_is_christmas; then apply_christmas_discount; fi
```

同时这也是一段看起来符合英语语法的 Bash。

使用类似 Java 语法编写的 DSL：

```text
orderValue = orderValue       
       .applyFestivalDiscount()          
       .applyCustomerLoyalityDiscount()        
       .applyCustomerAgeDiscount();  
  
```

这一段的可读性也相当强。

实际上，DSL 和 GPL 之间并没有非常明确的界限。

### **DSL 家族**

以下这些语言都可以作为 DSL 使用：

- Web 应用：HTML
- Shell：用于类 Unix 系统的 sh、Bash、CSH 等；用于 Windows 系统的 MS-DOS、Windows Terminal、PowerShell 等
- 标记语言：XML
- 建模：UML
- 数据处理：SQL 及其变体
- 业务规则管理：Drools
- 硬件：Verilog、VHD
- 构建工具：Maven、Gradle
- 数值计算和模拟：MATLAB（商业）、GNU Octave、Scilab
- 解析器和生成器：Lex、YACC、GNU Bison、ANTLR

### **为什么要使用 DSL？**

DSL 的目的是在某个领域中记录一些需求和行为，在某些方面（例如金融商品交易）中，DSL 的适用场景可能更加狭窄。业务团队和技术团队能通过 DSL 有效地协同工作，因此 DSL 除了在业务用途上有所发挥，还可以让设计人员和开发人员用于设计和开发应用程序。

DSL 还可以用于生成一些用于解决特定问题的代码，但生成代码并不是 DSL 的重点并不在此，而是对专业领域知识的结合。当然，代码生成在领域工程中是一个巨大的优势。

### **DSL 的优点和缺点**

DSL 的优点是，它对于领域的特征捕捉得非常好，同时它不像 GPL 那样包罗万有，学习和使用起来相对比较简单。因此，它在专业人员之间、专业人员和开发人员之间都提供了一个沟通的桥梁。

而 DSL 最显著的缺点就在于它只能用于一个特定的领域和目标。尽管学习起来不算太难，但学习成本仍然存在。如果使用到 DSL 相关的工具，即使对工作效率有所提升，但开发或配置这些工具也会增加一定的工作负担。另外，如果要设计一款 DSL，设计者必须具备专业领域知识和语言开发知识，而同时具备这两种知识的人却少之又少。

### **DSL 相关软件**

开源的 DSL 软件包括：

- Xtext：Xtext 可以与 Eclipse 集成，并支持 DSL 开发。它能够实现代码生成，因此一些开源和商业产品都用它来提供特定的功能。用于农业活动建模分析的 多用途农业数据系统Multipurpose Agricultural Data System（MADS）就是基于 Xtext 实现的一个项目，可惜的是这个项目现在已经不太活跃了。
- JetBrains MPS：JetBrains MPS 是一个可供开发 DSL 的 集成开发环境Integrated Development Environment ，它将文档在底层存储为一个抽象树结构（Microsoft Word 也使用了这一概念），因此它也自称为一个 投影编辑器projectional editor 。JetBrains MPS 支持 Java、C、JavaScript 和 XML 的代码生成。

### **DSL 的最佳实践**

如果你想使用 DSL，记住以下几点：

- DSL 不同于 GPL，DSL 只能用于解决特定领域中有限范围内的问题。
- 不必动辄建立自己的 DSL，可以首先尝试寻找已有的 DSL。例如 **DSLFIN** 这个网站就提供了很多金融方面的 DSL。在实在找不到合适的 DSL 的情况下，才需要建立自己的 DSL。
- DSL 最好像平常的语言一样具有可读性。
- 尽管代码生成不是一项必需的工作，但它确实会大大提高工作效率。
- 虽然 DSL 被称为语言，但 DSL 不需要像 GPL 一样可以被执行，可执行性并不是 DSL 需要达到的目的。
- DSL 可以使用文本编辑器编写，但专门的 DSL 编辑器可以更轻松地完成 DSL 的语法和语义检查。

![img](https://pic4.zhimg.com/80/v2-c8e844fe256b8cf0855e9fe9e3b4fddf_720w.jpg)

上面都是自己整理好的！我就把资料贡献出来给有需要的人！顺便求一波关注，哈哈~各位小伙伴关注我后私信[【Java】](https://link.zhihu.com/?target=https%3A//jq.qq.com/%3F_wv%3D1027%26k%3D5lQ85BZ)就可以免费领取哒

发布于 2020-03-04 14:14

开发者

开放平台

领域特定语言