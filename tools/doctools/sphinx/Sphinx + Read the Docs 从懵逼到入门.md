# Sphinx + Read the Docs 从懵逼到入门

[![阿基米东](https://pic2.zhimg.com/v2-1b71f2cbc662cfcc7516dc9cbf92b4e8_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/armstrong2014)

[阿基米东](https://www.zhihu.com/people/armstrong2014)

Just an eco-friendly hacker

创作声明：内容包含虚构创作



82 人赞同了该文章

继[《GitBook 从懵逼到入门》](https://link.zhihu.com/?target=https%3A//blog.csdn.net/lu_embedded/article/details/81100704)，时隔两年，终于推出姐妹篇《Read the Docs 从懵逼到入门》。从阅读量来看，笔者已经感受到大家对 GitBook 和 Markdown 写作的关注度，所以决定再给大家介绍一种常见的文档管理方案 —— Sphinx + GitHub + Read the Docs 的文档管理方法。

**简单来说，就是先用 Sphinx 生成文档，然后用 GitHub 托管文档，再导入到 Read the Docs 生成在线文档。**

无论是管理技术文档、写书、写笔记，亦或想搭建一个属于你的个人知识库，都是一个不错的选择。那我们现在开始吧！

![img](https://pic4.zhimg.com/80/v2-fdcaee474b9b39dba79023f300c0d8a7_1440w.jpg)

------

## **1. 背景知识**

### **1.1 ReadtheDocs**

Read the Docs 是一个基于 Sphinx 的免费文档托管项目。该项目在 2010 年由 Eric Holscher、Bobby Grace 和 Charles Leifer 共同发起。2011年3月，Python 软件基金会曾给 Read the Docs 项目资助 840 美元，作为一年的服务器托管费用。此后，受到越来越多开源社区和开发者的关注，2017年11月，Linux Mint 宣布将所有文档转移到 Read the Docs，目前 Read the Docs 已经托管了超过 90000 份文档。

![img](https://pic4.zhimg.com/80/v2-7379d1706ee6c1b77882a3a185d6849b_1440w.jpg)

Read the Docs 网站：[https://readthedocs.org/](https://link.zhihu.com/?target=https%3A//readthedocs.org/)



### **1.2 Sphinx**

Sphinx 是一个基于 Python 的文档生成项目。最早只是用来生成 Python 的项目文档，使用 reStructuredText 格式。但随着 Sphinx 项目的逐渐完善，目前已发展成为一个大众可用的框架，很多非 Python 的项目也采用 Sphinx 作为文档写作工具，甚至完全可以用 Sphinx 来写书。

![img](https://pic4.zhimg.com/80/v2-9fdbce0b71aed220be83c58d26c172eb_1440w.jpg)

Sphinx 是 Python 社区编写和使用的文档构建工具，由 Georg Brandl 在 BSD 许可证下开发，它可以令人轻松的撰写出清晰且优美的文档。除了天然支持 Python 项目以外，Sphinx 对 C/C++ 项目也有很好的支持，并在不断增加对其它开发语言的支持，有需要的小伙伴可以持续关注。

- Sphinx 网站：[http://sphinx-doc.org/](https://link.zhihu.com/?target=http%3A//sphinx-doc.org/)
- Sphinx 使用手册：[https://zh-sphinx-doc.readthedocs.io/en/latest/index.html](https://link.zhihu.com/?target=https%3A//zh-sphinx-doc.readthedocs.io/en/latest/index.html)

Sphinx（斯芬克斯）一词源自希腊语 Sphiggein，在古埃及神话中被描述为长有翅膀的怪物，大家熟知的人面狮身像就是 Sphinx 的一种。

![img](https://pic2.zhimg.com/80/v2-94d331cab7d184e5b167e70771e4b1f9_1440w.jpg)



### **1.3 reStructuredText**

reStructuredText 是一种轻量级标记语言。它是 Python Doc-SIG（Documentation Special Interest Group）的 Docutils 项目的一部分，旨在为 Python 创建一组类似于 Java 的 Javadoc 或 Perl 的 Plain Old Documentation（pod）的工具。Docutils 可以从 Python 程序中提取注释和信息，并将它们格式化为各种形式的程序文档。

值得注意的是，reStructuredText 是一个单词，不是两个，也不是三个。可以简写为 RST、ReST 或 reST，作为一种用于文本数据的文件格式，通常采用 .rst 作为文件后缀。

![img](https://pic4.zhimg.com/80/v2-9344a3bf88f1c75c725d14939af404cf_1440w.png)

前面提到，Sphinx 使用 reST 作为标记语言。实际上，reST 与 Markdown 非常相似，都是轻量级标记语言。由于设计初衷不同，reST 的语法更为复杂一些。

Markdown 的目标很简单，就是为了更简单地写 HTML，完成 text-to-HTML 的任务。而 reST 的目标是，建立一套标准文本结构化格式用以将文档转化为有用的数据格式（简单来说，就是要实现一套简单、直观、明确、原文本可阅读的，且可以转化为其他格式的文档标记语言）。显然，reST 的目标更大一些。

- reStructuredText 网站：[http://docutils.sf.net/rst.html](https://link.zhihu.com/?target=http%3A//docutils.sf.net/rst.html)



## **2. 环境搭建**

这里以 Ubuntu 为例（其他 Linux 发行版、MacOS 或 Windows 也行），首先安装 Python3、Git、Make 等基础软件。

``` bash
 sudo apt install git
 sudo apt install make
 sudo apt install python3
 sudo apt install python3-pip 
```

然后安装最新版本的 Sphinx 及依赖。

``` bash
 pip3 install -U Sphinx
```

为了完成本示例，还需要安装以下软件包。

``` bash
 pip3 install sphinx-autobuild
 pip3 install sphinx_rtd_theme
 pip3 install recommonmark
 pip3 install sphinx_markdown_tables
```

安装完成后，系统会增加一些 `sphinx-` 开头的命令。

```
 sphinx-apidoc    sphinx-autobuild    sphinx-autogen    sphinx-build    sphinx-quickstart
```



## **3. 快速开始**

### **3.1 创建项目**

我们以建立 diary 日记文档系统为例，先创建并进入 diary 文件夹（后续所有操作都在该文件夹内）。执行 `sphinx-quickstart` 构建项目框架，将会出现如下对话窗口。

```
 欢迎使用 Sphinx 3.2.1 快速配置工具。
 
 Please enter values for the following settings (just press Enter to
 accept a default value, if one is given in brackets).
 
 Selected root path: .
 
 You have two options for placing the build directory for Sphinx output.
 Either, you use a directory "_build" within the root path, or you separate
 "source" and "build" directories within the root path.
 > 独立的源文件和构建目录（y/n） [n]: 
```

首先，询问你是否要创建独立的源文件和构建目录。实际上对应两种目录结构，一种是在根路径下创建“_build”目录，另一种是在根路径下创建“source”和“build”两个独立的目录，前者用于存放文档资源，后者用于保存构建生成的各种文件。根据个人喜好选择即可，比如我更倾向于独立目录，因此输入 `y`。

接着，需要输入项目名称、作者等信息。

```
 The project name will occur in several places in the built documentation.
 > 项目名称: diary
 > 作者名称: Rudy
 > 项目发行版本 []: v1
```

然后，可以设置项目的语言，我们这里选择简体中文。

```
 If the documents are to be written in a language other than English,
 you can select a language here by its language code. Sphinx will then
 translate text that it generates into that language.
 
 For a list of supported codes, see
 https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-language.
 > 项目语种 [en]: zh_CN
```

OK，项目创建完成！（两种目录结构分别如下）

![img](https://pic3.zhimg.com/80/v2-57a6bce2fd59b833702f0379adc80ee2_1440w.jpg)

- `Makefile`：可以看作是一个包含指令的文件，在使用 make 命令时，可以使用这些指令来构建文档输出。
- `build`：生成的文件的输出目录。
- `make.bat`：Windows 用命令行。
- `_static`：静态文件目录，比如图片等。
- `_templates`：模板目录。
- `conf.py`：存放 Sphinx 的配置，包括在 `sphinx-quickstart` 时选中的那些值，可以自行定义其他的值。
- `index.rst`：文档项目起始文件。

此时我们在 diary 目录中执行 `make html`，就会在 build/html 目录生成 html 相关文件。

![img](https://pic2.zhimg.com/80/v2-ad735059a7ab2b53a367c64b951c5625_1440w.jpg)

在浏览器中打开 index.html，将会看到如下页面。

![img](https://pic1.zhimg.com/80/v2-15c93b36d0a0c4c4d242799aa47934d8_1440w.jpg)

当然，直接访问 html 文件不是很方便，所以我们借助 `sphinx-autobuild` 工具启动 HTTP 服务。

``` bash
 sphinx-autobuild source build/html
```

默认启动 8000 端口，在浏览器输入 [http://127.0.0.1:8000](https://link.zhihu.com/?target=http%3A//127.0.0.1%3A8000/) 。但是看到的页面跟上图一样，那换个主题吧！



### **3.2 修改主题**

打开 conf.py 文件，找到 html_theme 字段，修改为“classic”主题。

```python
 #html_theme = 'alabaster'
 html_theme = 'classic'
```

保存！可以看到网页变成这样了

![img](https://pic2.zhimg.com/80/v2-50248253435cb5d9a77363e20a20ac45_1440w.jpg)

Sphinx 为我们提供了好多可选的主题，在 [Sphinx Themes](https://link.zhihu.com/?target=https%3A//sphinx-themes.org/) 都可以找到。大家最熟悉的应该是 sphinx_rtd_theme 主题，其实我们前面已经安装好了。

```python
 html_theme = 'sphinx_rtd_theme'
```

那就用这个主题吧！

![img](https://pic3.zhimg.com/80/v2-00bee13674daab558393a61ea9efea12_1440w.jpg)



## **4. 最佳实践**

### **4.1 index.rst 语法**

受篇幅限制，本文无法详细介绍 reST 语法，具体可查看官方文档 [RESTRUCTUREDTEXT 简介](https://link.zhihu.com/?target=https%3A//zh-sphinx-doc.readthedocs.io/en/latest/rest.html)，这里主要分析 index.rst 的内容。

```rst
 .. diary documentation master file, created by
    sphinx-quickstart on Sat Oct 10 22:31:33 2020.
    You can adapt this file completely to your liking, but it should at least
    contain the root `toctree` directive.
 
 Welcome to diary's documentation!
 =================================
 
 .. toctree::
    :maxdepth: 2
    :caption: Contents:
 
 
 
 Indices and tables
 ==================
 
 * :ref:`genindex`
 * :ref:`modindex`
 * :ref:`search`
```

- 第1-4行由 `..` + 空格开头，属于多行评论（类似于注释），不会显示到网页上。
- 第6-7行是标题，reST 的标题需要被双下划线（或单下划线）包裹，并且符号的长度不能小于文本的长度。
- 第9-11行是文档目录树结构的描述，`.. toctree::` 声明了一个树状结构（toc 即 Table of Content），`:maxdepth: 2` 表示目录的级数（页面最多显示两级），`:caption: Contents:` 用于指定标题文本（可以暂时去掉）。
- 第15-20行是索引标题以及该标题下的三个索引和搜索链接。



### **4.2 《我的日记》**

我们进入 source 目录，修改 index.rst 文件，将标题改为“我的日记”，并添加一个 about 页面。

```rst
我的日记
=================================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   about
```

因此我们需要在 source 目录下新建一个 about.rst 文件，并写下内容：

```rst
 关于
 ========
 
 这是我的公开日记
```

打开浏览器，输入 [http://127.0.0.1:8000](https://link.zhihu.com/?target=http%3A//127.0.0.1%3A8000/)，将会看到如下页面。

![img](https://pic2.zhimg.com/80/v2-0f1a4c4cb088bd138d04b4fd0bb568fd_1440w.jpg)

![img](https://pic4.zhimg.com/80/v2-dab56ecffa361a1d0d1329cea283acff_1440w.jpg)

接下来，我们为日记添加一级子目录。先在 source/index.rst 中添加路径信息。

```rst
 我的日记
 =================================
 
 .. toctree::
    :maxdepth: 2
    :caption: Contents:
 
    2020/index
    about
```

在 source 目录下新建一个名为“2020”的文件夹，在“2020”文件夹中再创建“春、夏、秋、冬”四个文件夹，并且在其中分别创建 contents.rst 文件。最后，别忘了还有要新建一个 index.rst 文件。这一步完成后，2020 目录结构如下：

```
 2020
 ├── index.rst
 ├── 春
 │   └── contents.rst
 ├── 冬
 │   └── contents.rst
 ├── 秋
 │   └── contents.rst
 └── 夏
     └── contents.rst
```

在 2020/index.rst 文件中添加如下内容。

```text
 2020年
 =================================
 
 .. toctree::
    :maxdepth: 2
 
    春/contents
    夏/contents
    秋/contents
    冬/contents
```

以及四个 contents.rst 文件的内容：

- 春/contents.rst

```text
 春季
 ========
 
 春眠不觉晓，处处闻啼鸟。
```

- 夏/contents.rst

```text
 夏季
 ========
 
 夏早日初长，南风草木香。
```

- 秋/contents.rst

```text
 秋季
 ========
 
 秋风吹不尽，总是玉关情。
```

- 冬/contents.rst

```text
 冬季
 ========
 
 冬尽今宵促，年开明日长。
```

好啦！打开浏览器看一下吧～

![img](https://pic3.zhimg.com/80/v2-938017418dd1f3b7634df20dea5e705a_1440w.jpg)

![img](https://pic2.zhimg.com/80/v2-39b9b17ca0f291c586c9b3bed55a06b9_1440w.jpg)

好啦，日记就先写到这吧！喜欢的小伙伴可以在 [luhuadong/diary](https://link.zhihu.com/?target=https%3A//github.com/luhuadong/diary) 点赞+下载。



### **4.3 支持 Markdown**

前面我们都是用 reST 语法来操作，但如果我们想用 Markdown 写，或者有大量 Markdown 文档需要迁移怎么办呢？

虽然 Sphinx 默认不支持 Markdown 语法，但可以通过 recommonmark 插件来支持。另外，如果需要支持 markdown 的表格语法，还需要安装 sphinx-markdown-tables 插件。这两个插件其实我们前面已经安装好了，现在只需要在 conf.py 配置文件中添加扩展支持即可。

``` python
 extensions = [
     'recommonmark',
     'sphinx_markdown_tables'
 ]
```

我们以“秋”为例，将 rst 文件修改为 md 文件。

``` bash
 cd 秋
 mv contents.rst contents.md
```

修改 contents.md 文件，增加一些 Markdown 语法内容：

```text
 # 秋季
 
 秋风吹不尽，总是玉关情。
 
 ## 二级标题
 
 
 ### 三级标题
 
 
 #### 四级标题
 
 
 这是一个**段落**
 
 | 作者 | 朝代 | 评分 |
 | :--: | :--: | :--: |
 | 李白 |  唐  | 100  |
 
```

噔噔！打开浏览器，完美～

![img](https://pic2.zhimg.com/80/v2-39b9b17ca0f291c586c9b3bed55a06b9_1440w.jpg)



## **5. 文档托管**

### **5.1 上传 GitHub**

首先在 GitHub 上创建一个 diary 仓库。

![img](https://pic4.zhimg.com/80/v2-dbffb2c4b68a87fc1aaf6b10e9de6c07_1440w.jpg)

在本地 diary 目录中添加 README.md 和 .gitignore 文件，在 .gitignore 文件中写入下面一行。

```text
 build/
```

表示不跟踪 build 目录，因为我们后面将使用 Read the Docs 进行文档的构建和托管。

接着依次执行如下命令即可。

```bash
 git init
 git add .
 git commit -m "first commit"
 git branch -M main
 git remote add origin git@github.com:luhuadong/diary.git
 git push -u origin main
```



### **5.2 网页托管**

在 Read the Docs 网站 [https://readthedocs.org/](https://link.zhihu.com/?target=https%3A//readthedocs.org/) 注册，并绑定 GitHub 账户。点击“Import a Project”导入项目，输入项目名称和仓库地址即可。

![img](https://pic1.zhimg.com/80/v2-ee7cec909d8f53b3f5f4640171769ef4_1440w.jpg)

翻车啦，构建失败！（构建成功的话，可以通过 [diary-demo.readthedocs.io](https://link.zhihu.com/?target=https%3A//diary-demo.readthedocs.io/) 链接访问在线文档）

![img](https://pic4.zhimg.com/80/v2-ee7af09771752f8d1d482764301d921f_1440w.jpg)

原因是 GitHub 从 2020年10月1日起，把主分支的名称从 master 修改为 main 了，但是 Read the Docs 的构建脚本还没兼容。。。

（好吧，你们操作的时候应该修好了）

------

![img](https://pic1.zhimg.com/80/v2-7658e7059fcc5c1090121cc07ac05474_1440w.jpg)



编辑于 2020-10-11 10:00

[信息技术（IT）](https://www.zhihu.com/topic/19556498)