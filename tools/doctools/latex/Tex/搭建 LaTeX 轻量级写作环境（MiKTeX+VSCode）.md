# 搭建 LaTeX 轻量级写作环境（MiKTeX+VSCode）

[![润莲兄](https://pic2.zhimg.com/v2-4b76484345ba673ff06ef0c260515997_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/yang-xin-bin-zz)

[润莲兄](https://www.zhihu.com/people/yang-xin-bin-zz)

正在努力逃离生物坑



461 人赞同了该文章

**LaTeX** 是一套强大的排版系统，在学术论文排版方面应用广泛，很多西方高效和期刊都会提供自己 LaTeX 模板方便论文提交。虽然 LaTeX 有不少相关的 IDE，如 TeXstudio，BaKoMa，LyX 等，但总给人一种笨重的感觉。如今，VSCode 为我们提供了另一种选择。

我先解释一下，Overleaf 是个非常棒的平台，不过，我平时也需要写 Python，不想来回切换窗口，所以转向了 VSCode。其实，SageMath 也有这样的功能，但我还是更喜欢 VSCode 的补全，美滋滋。

## 安装 LaTeX

对于 LaTeX 的安装，有如下两种方法。

### 手动安装

对于 LaTeX 的常见版本，个人推荐 MiKTeX，即最小安装版本，其 Windows 安装包约 200 多 MB，MacOS 安装包 50 多 MB。相比于很多人推荐的 TeXLive （3.7 G）和 MacTeX（4.0 G）轻便了一个量级。其官方下载地址如下。

[MiKTeXmiktex.org/download](https://miktex.org/download)

### 自动安装

即使用包管理器进行安装。

对 Windows 用户，有 Scoop 和 Chocolatey

```powershell
scoop install latex
choco install miktex
```

对 MacOS 用户，有 Homebrew

```bash
brew cask install basictex
```

## 语法扩展

### LaTeX Workshop

这个基本上没什么可说的，使用 VSCode 写 LaTeX 的都会使用这个扩展，可以认为是必备。

![img](https://pic2.zhimg.com/80/v2-0bfbf2bb3b4785079737437ffb3cf47d_1440w.jpg)

安装完毕后，"ctrl"+"," 打开配置，并在搜索框中输入"json"，打开配置的 .json 文件。

![img](https://pic1.zhimg.com/80/v2-c652fe3a3f263f136680e35374e53758_1440w.png)

对 MacOS 加入如下配置：

```json
{
  "latex-workshop.latex.recipes": [
    {
     "name" : "xelatex -> bibtex -> xelatex*2",
     "tools": [
      "xelatex",
      "bibtex",
      "xelatex",
      "xelatex"
     ]
    }
   ],
   "latex-workshop.latex.tools": [
    {
     "name"   : "xelatex",
     "command": "xelatex",
     "args"   : [
      "-synctex=1",
      "-interaction=nonstopmode",
      "-file-line-error",
      "%DOC%"
     ]
    },
    {
     "name"   : "latexmk",
     "command": "latexmk",
     "args"   : [
      "-synctex=1",
      "-interaction=nonstopmode",
      "-file-line-error",
      "%DOC%"
     ]
    },
    {
     "name"   : "pdflatex",
     "command": "pdflatex",
     "args"   : [
      "-synctex=1",
      "-interaction=nonstopmode",
      "-file-line-error",
      "%DOC%"
     ]
    },
    {
     "name"   : "bibtex",
     "command": "bibtex",
     "args"   : [
      "%DOCFILE%"
     ]
    }
   ],
  "latex-workshop.view.pdf.viewer": "tab",
}
```

对于 Windows 加入如下配置：

```json
{
  "latex-workshop.latex.recipes": [
    {
      "name": "xelatex -> bibtex -> xelatex*2",
      "tools": [
        "xelatex",
        "bibtex",
        "xelatex",
        "xelatex"
      ]
    }
  ],
  "latex-workshop.latex.tools": [
    {
      "name": "xelatex",
      "command": "xelatex",
      "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    },
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    },
    {
      "name": "pdflatex",
      "command": "pdflatex",
      "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    },
    {
      "name": "bibtex",
      "command": "bibtex",
      "args": [
        "%DOCFILE%"
      ]
    }
  ],
  "latex-workshop.view.pdf.viewer": "tab",
}
```

### LaTeX Utilities

这个扩展是上面那个的一个补充。其功能包括：

- 字数统计

- 片段补全

- 格式化的粘贴

- - Unicode 字符 LaTeX 字符（如 "is this...a test" ``is this\ldots a test''）
  - 粘贴表格单元格 表式
  - 粘贴图片，可定制模板
  - 粘贴CSV/图片的位置，使其包含在其中。

- TikZ 预览

![img](https://pic4.zhimg.com/80/v2-a7f3df2e91ef4645929c0ea5cc6afbd7_1440w.jpg)

## 功能扩展

### 拼写检查

LaTeX 的用户里，不少人都是使用它进行英文写作的，这时就不免会需要拼写检查，Street Side Software 公司在 VSCode 中提供了一系列的相关扩展，涵盖了20多种西方主要语言，可以根据需要进行安装。

![img](https://pic1.zhimg.com/80/v2-3bd5cc3904a2263905e787992125d4ec_1440w.jpg)

扩展安装完毕后，同样需要进入 setting.json 中，进行一些调试，如拼写检查针对的语言，文件类型，以及是否忽略诸如组合词（compound words）。

```json
{
  "cSpell.language": "en,es,fr",
  "cSpell.enableFiletypes": [
    "!asciidoc",
    "!haskell",
    "!javascriptreact",
    "!scss",
    "!typescriptreact",
    "fsharp",
    "lua",
    "mermaid",
    "perl",
    "powershell",
    "r",
    "rmd",
    "tex",
    "toml",
    "vue",
    "xml",
    "lrc",
    "py",
    "md"
  ],
  "cSpell.allowCompoundWords": true,
  "cSpell.enabled": true,
}
```

### 格式转换

这里推荐文档格式领域的瑞士军刀 Pandoc。可以去官网手动下载

[https://pandoc.org/pandoc.org/](https://pandoc.org/)

也可以使用包管理器自动下载。

对 Windows 用户，有 Scoop 和 Chocolatey

```powershell
scoop install pandoc
choco install pandoc
```

对 MacOS 用户，有 Homebrew

```bash
brew install pandoc
brew install pandoc-citeproc
```

## 宏包管理

### 基本操作

对于 Windows 用户，不需要特别对包进行管理，当在文档中导入未安装的包时，LaTeX 会自动弹出窗口，询问是否安装。

对于 MacOS 用户，需要使用包管理器 tlmgr 对 LaTeX 包进行管理。

```bash
# 升级自身
sudo tlmgr update --self
# 升级所有包
sudo tlmgr update --all
# 列出已安装包
sudo tlmgr list --only-installed
```

编辑于 2020-07-19

Visual Studio Code

LaTeX

排版软件

赞同 461