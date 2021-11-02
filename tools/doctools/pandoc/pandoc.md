# pandoc

[Pandoc](https://pandoc.org/)可以将文档在 Markdown、LaTeX、reStructuredText、HTML、Word docx 等多种标记格式之间相互转换，并支持输出 PDF、EPUB、HTML 幻灯片等多种格式。该程序被称为格式转换界的 “瑞士军刀”。

Pandoc 的作者是 John MacFarlane，他是加州大学伯克利分校的哲学系教授。Pandoc 使用 Haskell 语言编写，被作者用来生成讲义、课件和网站等。该程序开源免费，目前以 GPL 协议托管在 Github 网站上。

## install
### apt-get
sudo apt-get install pandoc
### Anaconda
如果你已经安装了 Anaconda，那么你可以直接使用 Pandoc 了。该程序已经被集成到 Anaconda 中。
## demo


``` bash
# markdwon to html
pandoc sphinx.md -f markdown -t html -s -o sphinx.html

# html to markdown
pandoc sphinx.html -f html -t markdown -s -o sphinx.md

pandoc sphinx.md -f markdown -t pdf -s -o sphinx.pdf --pdf-engine "E:\Program Files\MiKTeX\miktex\bin\x64\pdflatex.exe"


```



```
[frank@LAPTOP-0OCJTGJR pandoc]$ pandoc test1.md -f markdown -t html -s -o test1.html

[frank@LAPTOP-0OCJTGJR pandoc]$ ll
total 4
-rw-rw-r-- 1 frank frank 629 Feb  4 22:06 test1.html
-rw-rw-r-- 1 frank frank  81 Feb  4 22:05 test1.md
```

## help
```

(H:\conda\venv\app_env) H:\project\tool_misc\tools>pandoc --help
pandoc [OPTIONS] [FILES]
  -f FORMAT, -r FORMAT  --from=FORMAT, --read=FORMAT
  -t FORMAT, -w FORMAT  --to=FORMAT, --write=FORMAT
  -o FILE               --output=FILE
                        --data-dir=DIRECTORY
  -M KEY[:VALUE]        --metadata=KEY[:VALUE]
                        --metadata-file=FILE
  -d FILE               --defaults=FILE
                        --file-scope
  -s                    --standalone
                        --template=FILE
  -V KEY[:VALUE]        --variable=KEY[:VALUE]
                        --wrap=auto|none|preserve
                        --ascii
                        --toc, --table-of-contents
                        --toc-depth=NUMBER
  -N                    --number-sections
                        --number-offset=NUMBERS
                        --top-level-division=section|chapter|part
                        --extract-media=PATH
                        --resource-path=SEARCHPATH
  -H FILE               --include-in-header=FILE
  -B FILE               --include-before-body=FILE
  -A FILE               --include-after-body=FILE
                        --no-highlight
                        --highlight-style=STYLE|FILE
                        --syntax-definition=FILE
                        --dpi=NUMBER
                        --eol=crlf|lf|native
                        --columns=NUMBER
  -p                    --preserve-tabs
                        --tab-stop=NUMBER
                        --pdf-engine=PROGRAM
                        --pdf-engine-opt=STRING
                        --reference-doc=FILE
                        --self-contained
                        --request-header=NAME:VALUE
                        --no-check-certificate
                        --abbreviations=FILE
                        --indented-code-classes=STRING
                        --default-image-extension=extension
  -F PROGRAM            --filter=PROGRAM
  -L SCRIPTPATH         --lua-filter=SCRIPTPATH
                        --shift-heading-level-by=NUMBER
                        --base-header-level=NUMBER
                        --strip-empty-paragraphs
                        --track-changes=accept|reject|all
                        --strip-comments
                        --reference-links
                        --reference-location=block|section|document
                        --atx-headers
                        --listings
  -i                    --incremental
                        --slide-level=NUMBER
                        --section-divs
                        --html-q-tags
                        --email-obfuscation=none|javascript|references
                        --id-prefix=STRING
  -T STRING             --title-prefix=STRING
  -c URL                --css=URL
                        --epub-subdirectory=DIRNAME
                        --epub-cover-image=FILE
                        --epub-metadata=FILE
                        --epub-embed-font=FILE
                        --epub-chapter-level=NUMBER
                        --ipynb-output=all|none|best
                        --bibliography=FILE
                        --csl=FILE
                        --citation-abbreviations=FILE
                        --natbib
                        --biblatex
                        --mathml
                        --webtex[=URL]
                        --mathjax[=URL]
                        --katex[=URL]
                        --gladtex
                        --trace
                        --dump-args
                        --ignore-args
                        --verbose
                        --quiet
                        --fail-if-warnings
                        --log=FILE
                        --bash-completion
                        --list-input-formats
                        --list-output-formats
                        --list-extensions[=FORMAT]
                        --list-highlight-languages
                        --list-highlight-styles
  -D FORMAT             --print-default-template=FORMAT
                        --print-default-data-file=FILE
                        --print-highlight-style=STYLE|FILE
  -v                    --version
  -h                    --help
```

## misc

### pdflatex not found
```
pdflatex not found. Please select a different --pdf-engine or install pdflatex

```

首先需要安装latex软件，这里选择[MiKTeX](https://miktex.org/)

安装完成之后，通过pdf-engine指定目标程序。
```
pandoc sphinx.md -f markdown -t pdf -s -o sphinx.pdf --pdf-engine "E:\Program Files\MiKTeX\miktex\bin\x64\pdflatex.exe"
```


> pdf-engine must be one of wkhtmltopdf, weasyprint, prince, pdflatex, lualatex, xelatex, latexmk, tectonic, pdfroff, context
