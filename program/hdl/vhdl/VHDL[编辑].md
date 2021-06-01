# VHDL[[编辑](https://zh.wikipedia.org/w/index.php?title=VHDL&action=edit&section=0&summary=/* top */ )]

维基百科，自由的百科全书

跳到导航

跳到搜索

[![Confusion grey.svg](https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Confusion_grey.svg/24px-Confusion_grey.svg.png)](https://zh.wikipedia.org/wiki/Wikipedia:消歧义)  **提示**：此条目的主题不是**VHD**。

| [![Antistub.svg](https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Antistub.svg/44px-Antistub.svg.png)](https://zh.wikipedia.org/wiki/File:Antistub.svg) | 此条目**需要扩充。** *(2011年11月10日)* 请协助[改善这篇条目](https://zh.wikipedia.org/w/index.php?title=VHDL&action=edit)，更进一步的信息可能会在[讨论页](https://zh.wikipedia.org/wiki/Talk:VHDL)或[扩充请求](https://zh.wikipedia.org/wiki/Wikipedia:扩充请求)中找到。请在扩充条目后将此模板移除。 |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
|                                                              |                                                              |

|      [编程范型](https://zh.wikipedia.org/wiki/编程范型)      | [并发](https://zh.wikipedia.org/wiki/并发计算), [响应式](https://zh.wikipedia.org/wiki/响应式编程), [数据流程](https://zh.wikipedia.org/wiki/数据流程编程) |
| :----------------------------------------------------------: | ------------------------------------------------------------ |
|                           发行时间                           | 1980年代                                                     |
|                                                              |                                                              |
|    [稳定版本](https://zh.wikipedia.org/wiki/軟件版本週期)    | IEEE 1076-2019 （ 2019年12月23日，16个月前 ）                |
|      [型态系统](https://zh.wikipedia.org/wiki/類型系統)      | [强类型](https://zh.wikipedia.org/wiki/类型系统)             |
|    [文件扩展名](https://zh.wikipedia.org/wiki/文件扩展名)    | .vhd                                                         |
|                             网站                             | [IEEE VASG](http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/WebHome) |
|                          衍生副语言                          |                                                              |
|      [VHDL-AMS](https://zh.wikipedia.org/wiki/VHDL-AMS)      |                                                              |
|                           启发语言                           |                                                              |
| [Ada](https://zh.wikipedia.org/wiki/Ada),[[1\]](https://zh.wikipedia.org/wiki/VHDL#cite_note-Coelho1989-1) [Pascal](https://zh.wikipedia.org/wiki/Pascal_(程式語言)) |                                                              |
| ![img](https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Wikibooks-logo-en-noslogan.svg/16px-Wikibooks-logo-en-noslogan.svg.png) [维基教科书](https://zh.wikipedia.org/wiki/維基教科書)中有关[Programmable Logic/VHDL](https://en.wikibooks.org/wiki/Programmable_Logic/VHDL)的文本 |                                                              |

![img](https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Vhdl_signed_adder_source.svg/220px-Vhdl_signed_adder_source.svg.png)



一个有符号的

加法器

的VHDL源代码。

**VHDL**，全称**超高速集成电路硬件描述语言**（英语：**VHSIC very high-speed hardware description language**），在基于[复杂可编程逻辑器件](https://zh.wikipedia.org/wiki/複雜可程式邏輯裝置)、[现场可编程逻辑门阵列](https://zh.wikipedia.org/wiki/现场可编程逻辑门阵列)和[专用集成电路](https://zh.wikipedia.org/wiki/特殊應用積體電路)的[数字系统](https://zh.wikipedia.org/wiki/数字电路)设计中有着广泛的应用。

VHDL语言诞生于1983年，1987年被[美国国防部](https://zh.wikipedia.org/wiki/美国国防部)和[IEEE](https://zh.wikipedia.org/wiki/IEEE)确定为标准的硬件描述语言。自从IEEE发布了VHDL的第一个标准版本IEEE 1076-1987后，各大EDA公司都先后推出了自己支援VHDL的EDA工具。VHDL在电子设计行业得到了广泛的认同。此后IEEE又先后发布了IEEE 1076-1993和IEEE 1076-2000版本。

## 目录



- 1编程语言
  - [1.1单体（entity）](https://zh.wikipedia.org/wiki/VHDL#單體（entity）)
  - [1.2架构（architecture）](https://zh.wikipedia.org/wiki/VHDL#架構（architecture）)
  - [1.3组态（configuration）](https://zh.wikipedia.org/wiki/VHDL#組態（configuration）)
- [2参见](https://zh.wikipedia.org/wiki/VHDL#参见)

## 编程语言[[编辑](https://zh.wikipedia.org/w/index.php?title=VHDL&action=edit&section=1)]

注：VHDL不区分大小写；

```
library ieee;--库声明，声明工程中用到的库，这里声明的是IEEE库
use ieee.std_logic_1164.all;--包声明，声明工程中用到的包，这里声明的是IEEE的STD_LOGIC_1164包
```

### 单体（entity）[[编辑](https://zh.wikipedia.org/w/index.php?title=VHDL&action=edit&section=2)]

它负责宣告一个硬件的外部输入与输出，一个简单的范例（尖括号内为必填，方括号内为可选）：

```
 entity <实体名称> is
  port(
         a : IN STD_LOGIC;
         b : OUT STD_LOGIC
      );
 end [实体名称];
```

### 架构（architecture）[[编辑](https://zh.wikipedia.org/w/index.php?title=VHDL&action=edit&section=3)]

它负责实现内部的硬件电路。

```
architecture <结构体名称> of <实体名称> is
begin
  --此处可编写结构体内部操作
end [结构体名称];
```

### 组态（configuration）[[编辑](https://zh.wikipedia.org/w/index.php?title=VHDL&action=edit&section=4)]

配置用来描述各种层与层的连接关系以及实体与结构体之间的关系，此处不赘述

VHDL编写触发器简例：

```
library ieee;                 	--库声明
use ieee.std_logic_1164.all;  	--包声明
entity test is                 	--实体定义
  port(
       d     : in   std_logic;
       clk   : in   std_logic;
       q     : out  std_logic);
end test;
architecture trigger of test is	--结构体定义
  signal q_temp:std_logic;
begin
  q<=q_temp;
  process(clk)
  begin
    if clk'event and clk='1' then
      q_temp<=d;
    end if;
  end process;
end trigger;
configuration d_trigger of test is--配置，将结构体配置给实体，配置名为d_trigger
  for trigger
  end for;
end d_trigger;
```

## 参见[[编辑](https://zh.wikipedia.org/w/index.php?title=VHDL&action=edit&section=5)]

- [硬件描述语言](https://zh.wikipedia.org/wiki/硬件描述语言)







1. **^** David R. Coelho. [The VHDL Handbook](https://books.google.com/books?id=IxZqlbYMJCIC&q=Ada). Springer Science & Business Media. 30 June 1989. [ISBN 978-0-7923-9031-2](https://zh.wikipedia.org/wiki/Special:网络书源/978-0-7923-9031-2).

分类

：

- [硬件描述语言](https://zh.wikipedia.org/wiki/Category:硬件描述语言)
- [Ada编程语言家族](https://zh.wikipedia.org/wiki/Category:Ada编程语言家族)



## 导航菜单

- 没有登录
- [讨论](https://zh.wikipedia.org/wiki/Special:我的讨论页)
- [贡献](https://zh.wikipedia.org/wiki/Special:我的贡献)
- [创建账户](https://zh.wikipedia.org/w/index.php?title=Special:创建账户&returnto=VHDL)
- [登录](https://zh.wikipedia.org/w/index.php?title=Special:用户登录&returnto=VHDL)

- [条目](https://zh.wikipedia.org/wiki/VHDL)
- [讨论](https://zh.wikipedia.org/wiki/Talk:VHDL)

### 大陆简体

- 
- 
- 
- 
- 
- 

- [汉漢](https://zh.wikipedia.org/wiki/VHDL#)

- [阅读](https://zh.wikipedia.org/wiki/VHDL)
- [编辑](https://zh.wikipedia.org/w/index.php?title=VHDL&action=edit)
- [查看历史](https://zh.wikipedia.org/w/index.php?title=VHDL&action=history)

### 搜索





- [首页](https://zh.wikipedia.org/wiki/Wikipedia:首页)
- [分类索引](https://zh.wikipedia.org/wiki/Wikipedia:分类索引)
- [特色内容](https://zh.wikipedia.org/wiki/Portal:特色內容)
- [新闻动态](https://zh.wikipedia.org/wiki/Portal:新聞動態)
- [最近更改](https://zh.wikipedia.org/wiki/Special:最近更改)
- [随机条目](https://zh.wikipedia.org/wiki/Special:随机页面)
- [资助维基百科](https://donate.wikimedia.org/?utm_source=donate&utm_medium=sidebar&utm_campaign=spontaneous&uselang=zh-hans)

### 帮助

- [帮助](https://zh.wikipedia.org/wiki/Help:目录)
- [维基社群](https://zh.wikipedia.org/wiki/Wikipedia:社群首页)
- [方针与指引](https://zh.wikipedia.org/wiki/Wikipedia:方針與指引)
- [互助客栈](https://zh.wikipedia.org/wiki/Wikipedia:互助客栈)
- [知识问答](https://zh.wikipedia.org/wiki/Wikipedia:知识问答)
- [字词转换](https://zh.wikipedia.org/wiki/Wikipedia:字词转换)
- [IRC即时聊天](https://zh.wikipedia.org/wiki/Wikipedia:IRC聊天频道)
- [联络我们](https://zh.wikipedia.org/wiki/Wikipedia:联络我们)
- [关于维基百科](https://zh.wikipedia.org/wiki/Wikipedia:关于)

### 工具

- [链入页面](https://zh.wikipedia.org/wiki/Special:链入页面/VHDL)
- [相关更改](https://zh.wikipedia.org/wiki/Special:链出更改/VHDL)
- [上传文件](https://zh.wikipedia.org/wiki/Project:上传)
- [特殊页面](https://zh.wikipedia.org/wiki/Special:特殊页面)
- [固定链接](https://zh.wikipedia.org/w/index.php?title=VHDL&oldid=64269185)
- [页面信息](https://zh.wikipedia.org/w/index.php?title=VHDL&action=info)
- [引用本页](https://zh.wikipedia.org/w/index.php?title=Special:引用此页面&page=VHDL&id=64269185&wpFormIdentifier=titleform)
- [维基数据项](https://www.wikidata.org/wiki/Special:EntityPage/Q209455)
- [短链接](https://zh.wikipedia.org/wiki/VHDL#)

### 打印/导出

- [下载为PDF](https://zh.wikipedia.org/w/index.php?title=Special:DownloadAsPdf&page=VHDL&action=show-download-screen)
- [打印版本](javascript:print();)

### 在其他项目中

- [维基共享资源](https://commons.wikimedia.org/wiki/Category:VHDL)

### 其他语言

- [العربية](https://ar.wikipedia.org/wiki/في_إتش_دي_إل)
- [Deutsch](https://de.wikipedia.org/wiki/Very_High_Speed_Integrated_Circuit_Hardware_Description_Language)
- [English](https://en.wikipedia.org/wiki/VHDL)
- [Español](https://es.wikipedia.org/wiki/VHDL)
- [Français](https://fr.wikipedia.org/wiki/VHDL)
- [Bahasa Indonesia](https://id.wikipedia.org/wiki/VHDL)
- [Bahasa Melayu](https://ms.wikipedia.org/wiki/VHDL)
- [Português](https://pt.wikipedia.org/wiki/VHDL)
- [Русский](https://ru.wikipedia.org/wiki/VHDL)

[编辑链接](https://www.wikidata.org/wiki/Special:EntityPage/Q209455#sitelinks-wikipedia)





- 本页面最后修订于2021年2月13日 (星期六) 15:08。