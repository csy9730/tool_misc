# sphinx

[sphinx](https://www.sphinx-doc.org/) 适用于book的生成。


支持以下格式
* htmlview
* html
* epub
* latex
* pdf

## install
```
pip install sphinx sphinx-doc
```

[https://github.com/sphinx-doc/sphinx](https://github.com/sphinx-doc/sphinx)

## main

* sphinx-quickstart.exe 可以通过交互方式生成项目，包括conf.bat，makefile
* sphinx-build.exe 核心命令,生成文档
* sphinx-apidoc.exe
* sphinx-autogen.exe


``` bash
sphinx-build --version

sphinx-build.exe . _build 
sphinx-build.exe . _build -a  -b text
sphinx-build.exe . _build -a  -b xml
sphinx-build.exe . _build -a  -b epub
sphinx-build.exe . _build -a  -b latex
# 需要安装 latex
```
## project arch

- conf.py 项目配置，包含作者信息，项目信息，插件等
- make.bat windows下使用的make脚本
- Makefile linux下使用的make脚本
- index.rst 入口文件
- source 源文件夹。默认配置下，将会把所有rst文件加入到源文件中。
- _build：生成的文件的输出目录。
- _static：静态文件目录，比如图片等。
- _templates：模板目录。





### make.bat

#### format

```
make htmlview
make html
make epub
make latex
make pdf
```

## misc
### 支持markdown文档

启用markdown插件
``` python
extensions = [
    'recommonmark',
    'sphinx.ext.autodoc',
    "sphinx.ext.viewcode"
]
```

搜索路径中添加md后缀名
``` python
source_suffix = ['.rst', '.md', '.MD']
html_theme = 'sphinx_rtd_theme'
```

### category


- readme
- install
- overview
- tutorial
- example
- frequent Q&A

## misc

```
(base) H:\tool_misc\tools>sphinx-build.exe . build -a  -b html
Running Sphinx v2.2.0
loading translations [zh-CN]... not available for built-in messages
making output directory... done
WARNING: html_static_path entry '_static' does not exist

Theme error:
sphinx_rtd_theme is no longer a hard dependency since version 1.4.0. Please install it manually.(pip install sphinx_rtd_theme)
```

```
pip install recommonmark sphinx_rtd_theme

```