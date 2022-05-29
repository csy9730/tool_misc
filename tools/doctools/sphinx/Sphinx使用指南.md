# [Sphinx使用指南](https://www.cnblogs.com/double12gzh/p/13693395.html)



**目录**

- [1. 写在前面](https://www.cnblogs.com/double12gzh/p/13693395.html#_label0)
- \2. 安装Sphinx和Pandoc
  - [2.1 安装 Sphinx](https://www.cnblogs.com/double12gzh/p/13693395.html#_label1_0)
  - [2.2 安装 Pandoc](https://www.cnblogs.com/double12gzh/p/13693395.html#_label1_1)
- \3. 个人文档
  - [3.1 创建目录并进入](https://www.cnblogs.com/double12gzh/p/13693395.html#_label2_0)
  - [3.2 初始化文档](https://www.cnblogs.com/double12gzh/p/13693395.html#_label2_1)
  - [3.3 查看文档结构](https://www.cnblogs.com/double12gzh/p/13693395.html#_label2_2)
  - [3.4 定制conf.py](https://www.cnblogs.com/double12gzh/p/13693395.html#_label2_3)
  - [3.5 修改favicon.ico](https://www.cnblogs.com/double12gzh/p/13693395.html#_label2_4)
  - [3.6 根据需要写组织文档](https://www.cnblogs.com/double12gzh/p/13693395.html#_label2_5)
  - [3.7 生成线下预览](https://www.cnblogs.com/double12gzh/p/13693395.html#_label2_6)
- [4. 个人博客](https://www.cnblogs.com/double12gzh/p/13693395.html#_label3)
- \5. github与readthedocs联动
  - [5.1 注册readthedocs帐号](https://www.cnblogs.com/double12gzh/p/13693395.html#_label4_0)
  - [5.2 导入项目](https://www.cnblogs.com/double12gzh/p/13693395.html#_label4_1)
- [6. 总结](https://www.cnblogs.com/double12gzh/p/13693395.html#_label5)



**正文**

本文介绍 `win10` + [ubuntu on win](https://www.microsoft.com/store/productId/9NBLGGH4MSV6) 下如何使用Sphinx。

[回到顶部](https://www.cnblogs.com/double12gzh/p/13693395.html#_labelTop)

## 1. 写在前面

文中使用的Sphinx的版本信息如下：

```bash
➜  Pictures sphinx-build --version
sphinx-build 3.2.1
```

[回到顶部](https://www.cnblogs.com/double12gzh/p/13693395.html#_labelTop)

## 2. 安装Sphinx和Pandoc



### 2.1 安装 Sphinx

[安装手册](https://www.sphinx-doc.org/en/master/usage/installation.html#windows)

- 安装 python3

- 安装 pip3

- 打开windows终端`win+r`

- 安装 Sphinx

  `pip install -U sphinx`

- 将sphinx的路径添加到系统PATH中

- 验证是否安装成功

  `sphinx-build --version`



### 2.2 安装 Pandoc

[安装手册](https://pandoc.org/installing.html)

[回到顶部](https://www.cnblogs.com/double12gzh/p/13693395.html#_labelTop)

## 3. 个人文档

> 本节中用到的代码示例存放在这里: [sphinx-doc-guide](https://github.com/double12gzh/sphinx-doc-guide)



### 3.1 创建目录并进入

```
mkdir sphinx-doc-guide && cd sphinx-doc-guide
```



### 3.2 初始化文档

```bash
➜  sphinx-doc-guide sphinx-quickstart                         
欢迎使用 Sphinx 3.2.1 快速配置工具。

Please enter values for the following settings (just press Enter to
accept a default value, if one is given in brackets).

Selected root path: .

You have two options for placing the build directory for Sphinx output.
Either, you use a directory "_build" within the root path, or you separate
"source" and "build" directories within the root path.
> 独立的源文件和构建目录（y/n） [n]: y

The project name will occur in several places in the built documentation.
> 项目名称: sphinx-doc-guide
> 作者名称: double12gzh
> 项目发行版本 []: v1.0

If the documents are to be written in a language other than English,
you can select a language here by its language code. Sphinx will then
translate text that it generates into that language.

For a list of supported codes, see
https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-language.
> 项目语种 [en]: zh

创建文件 /mnt/c/Users/jeffrey/Pictures/sphinx-doc-guide/source/conf.py。
创建文件 /mnt/c/Users/jeffrey/Pictures/sphinx-doc-guide/source/index.rst。
创建文件 /mnt/c/Users/jeffrey/Pictures/sphinx-doc-guide/Makefile。
创建文件 /mnt/c/Users/jeffrey/Pictures/sphinx-doc-guide/make.bat。

完成：已创建初始目录结构。

You should now populate your master file /mnt/c/Users/jeffrey/Pictures/sphinx-doc-guide/source/index.rst and create other documentation
source files. Use the Makefile to build the docs, like so:
   make builder
where "builder" is one of the supported builders, e.g. html, latex or linkcheck.
```



### 3.3 查看文档结构

```bash
➜  sphinx-doc-guide tree
.
├── build
├── make.bat
├── Makefile
└── source
    ├── conf.py
    ├── index.rst
    ├── _static
    └── _templates

4 directories, 4 files
```

> 说明：
>
> - `buid`这个目录是每次执行`make html`自动生成的，可以删除
> - 添加.gitignore，忽略build



### 3.4 定制conf.py

根据自己项目提供的信息将`sphinx-doc-guide`进行替换。

```bash
➜  source grep -rin "sphinx-doc-guide" ./
./conf.py:54:project = u'sphinx-doc-guide'
./conf.py:232:  (master_doc, 'sphinx-doc-guide.tex', u'sphinx-doc-guide.Documentation',
./conf.py:262:    (master_doc, 'sphinx-doc-guide', u'sphinx-doc-guide中文文档',
./conf.py:276:  (master_doc, 'sphinx-doc-guide', u'sphinx-doc-guide文档',
./conf.py:277:   author, 'sphinx-doc-guide', 'One line description of project.',
./conf.py:295:    app.add_config_value('sphinx-doc-guide_config', {
```

根据项目情况修改以下信息：

```bash
➜  source grep -rin "double12gzh" ./
./conf.py:55:copyright = u'2020, double12gzh'
./conf.py:56:author = u'double12gzh'
./conf.py:233:   u'double12gzh', 'manual'),
```



### 3.5 修改favicon.ico

ico文件的路径为：

```
sphinx-doc-guide/source/_static/img/favicon.ico
```



### 3.6 根据需要写组织文档

> 可以参考[本例](https://www.cnblogs.com/double12gzh/p/13693395.html)进行组织



### 3.7 生成线下预览

```bash
➜  sphinx-doc-guide make html         
正在运行 Sphinx v3.2.1
正在加载翻译 [zh]... 完成
创建输出目录... 完成
构建 [mo]： 0 个 po 文件的目标文件已过期
构建 [html]： 15 个源文件的目标文件已过期
更新环境: [新配置] 已添加 15，0 已更改，0 已移除
阅读源... [  6%] 0-root                                                                                                                                                     /root/anaconda3/lib/python3.7/site-packages/recommonmark/parser.py:75: UserWarning: Container node skipped: type=document
  warn("Container node skipped: type={0}".format(mdnode.t))
阅读源... [ 13%] index                                                                                                                                                      阅读源... [ 20%] makefile/0-mk                                                                                                                                              阅读源... [ 26%] makefile/1/0-introduction                                                                                                                                  阅读源... [ 33%] makefile/1/index                                                                                                                                           阅读源... [ 40%] makefile/2/1-mk                                                                                                                                            阅读源... [ 46%] makefile/2/2-mk                                                                                                                                            阅读源... [ 53%] makefile/2/index                                                                                                                                           阅读源... [ 60%] makefile/3-pic                                                                                                                                             阅读源... [ 66%] makefile/index                                                                                                                                             阅读源... [ 73%] python/0-py                                                                                                                                                阅读源... [ 80%] python/1-py                                                                                                                                                阅读源... [ 86%] python/11                                                                                                                                                  阅读源... [ 93%] python/2                                                                                                                                                   阅读源... [100%] python/index                                                                                                                                                  
查找当前已过期的文件... 没有找到
pickling环境... 完成
检查一致性... 完成
准备文件... 完成
写入输出... [  6%] 0-root                                                                                                                                                   写入输出... [ 13%] index                                                                                                                                                    写入输出... [ 20%] makefile/0-mk                                                                                                                                            写入输出... [ 26%] makefile/1/0-introduction                                                                                                                                写入输出... [ 33%] makefile/1/index                                                                                                                                         写入输出... [ 40%] makefile/2/1-mk                                                                                                                                          写入输出... [ 46%] makefile/2/2-mk                                                                                                                                          写入输出... [ 53%] makefile/2/index                                                                                                                                         写入输出... [ 60%] makefile/3-pic                                                                                                                                           写入输出... [ 66%] makefile/index                                                                                                                                           写入输出... [ 73%] python/0-py                                                                                                                                              写入输出... [ 80%] python/1-py                                                                                                                                              写入输出... [ 86%] python/11                                                                                                                                                写入输出... [ 93%] python/2                                                                                                                                                 写入输出... [100%] python/index                                                                                                                                                 
generating indices...  genindex完成
writing additional pages...  search完成
复制静态文件... ... 完成
copying extra files... 完成
dumping search index in Chinese (code: zh)... 完成
dumping object inventory... 完成
构建 成功.

HTML 页面保存在 build/html 目录。
```

> 生成的文件位于项目根目录的build中。

如果需要清除生成的文件可使用`make clean`

[回到顶部](https://www.cnblogs.com/double12gzh/p/13693395.html#_labelTop)

## 4. 个人博客

请参考[gzh](https://github.com/double12gzh/gzh)

[回到顶部](https://www.cnblogs.com/double12gzh/p/13693395.html#_labelTop)

## 5. github与readthedocs联动



### 5.1 注册readthedocs帐号

[地址](https://readthedocs.org/)



### 5.2 导入项目

![img](https://gitee.com/double12gzh/wiki-pictures/raw/master/2020-09-18readthedocs.png)

[回到顶部](https://www.cnblogs.com/double12gzh/p/13693395.html#_labelTop)

## 6. 总结

- 文章中完成的文档托管的页面为[sphinx-doc-guide](https://sphinx-doc-guide.readthedocs.io/zh_CN/latest/)
- 博客页面为[gzh](https://gzh.readthedocs.io/)

分类: [工具](https://www.cnblogs.com/double12gzh/category/1370078.html)

标签: [sphinx](https://www.cnblogs.com/double12gzh/tag/sphinx/), [工具](https://www.cnblogs.com/double12gzh/tag/工具/)