# iconv

iconv 支持gbk,utf8编码转换

```
Usage: iconv [OPTION...] [-f ENCODING] [-t ENCODING] [INPUTFILE...]
or:    iconv -l

Converts text from one encoding to another encoding.

Options controlling the input and output format:
  -f ENCODING, --from-code=ENCODING
                              the encoding of the input
  -t ENCODING, --to-code=ENCODING
                              the encoding of the output

Options controlling conversion problems:
  -c                          discard unconvertible characters
  --unicode-subst=FORMATSTRING
                              substitution for unconvertible Unicode characters
  --byte-subst=FORMATSTRING   substitution for unconvertible bytes
  --widechar-subst=FORMATSTRING
                              substitution for unconvertible wide characters

Options controlling error output:
  -s, --silent                suppress error messages about conversion problems

Informative output:
  -l, --list                  list the supported encodings
  --help                      display this help and exit
  --version                   output version information and exit

Report bugs to <bug-gnu-libiconv@gnu.org>.

```

## demo
``` bash
iconv -f gb2312 -t utf-8 -c 111.LOG
# 将gbk文件转化为utf-8并打印

iconv -f gb2312 -t utf-8 -c 111.LOG > 111.utf.LOG
# shell脚本将gbk文件转化为utf-8文件


# iconv 不支持原地修改文件，以下命令会导致内容丢失
iconv -f gb2312 -t utf-8 -c 111.LOG > 111.LOG
```


#### 批量转码

``` bash
echo 'iconv -f gb2312 -t utf-8 -c "$1" > "$2"' > iconv_file_utf8.sh
chmod +x iconv_file_utf8.sh
mkdir -p utf8
find . -type f -name "*.md" -exec ./iconv_file_utf8.sh {} utf8/{} \;

mkdir -p utf8/include/
mkdir -p utf8/src/
find . -type f \( -name "*.cpp" -o -name "*.h*" \) -exec ./iconv_file_utf8.sh {} utf8/{} \;
rm iconv_file_utf8.sh
```
