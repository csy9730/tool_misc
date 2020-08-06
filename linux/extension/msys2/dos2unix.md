
# dos2unix

 下载的开源代码换行符通常都是 Linux 风格(LF), 如果在 Windows 平台(CRLF)进行二次开发，同时需要用到 git 作为版本控制工具时。由于不希望 两种风格混用，通常 core.safecrlf 设置为 true ，这时就会遇到无法提交的情况，必须统一所有文件的换行符才行。
dos2unix可以把转换dos文本格式转换成unix文本格式，即把行尾的CRLF换成LF.
unix2dos可以把转换unix文本格式转换成dos文本格式，即把行尾的LF换成CRLF.
unix2dos 只能对单文件使用。
## help
```
$ dos2unix --help
Usage: dos2unix [options] [file ...] [-n infile outfile ...]
 --allow-chown         allow file ownership change
 -ascii                convert only line breaks (default)
 -iso                  conversion between DOS and ISO-8859-1 character set
   -1252               use Windows code page 1252 (Western European)
   -437                use DOS code page 437 (US) (default)
   -850                use DOS code page 850 (Western European)
   -860                use DOS code page 860 (Portuguese)
   -863                use DOS code page 863 (French Canadian)
   -865                use DOS code page 865 (Nordic)
 -7                    convert 8 bit characters to 7 bit space
 -b, --keep-bom        keep Byte Order Mark
 -c, --convmode        conversion mode
   convmode            ascii, 7bit, iso, mac, default to ascii
 -f, --force           force conversion of binary files
 -h, --help            display this help text
 -i, --info[=FLAGS]    display file information
   file ...            files to analyze
 -k, --keepdate        keep output file date
 -L, --license         display software license
 -l, --newline         add additional newline
 -m, --add-bom         add Byte Order Mark (default UTF-8)
 -n, --newfile         write to new file
   infile              original file in new-file mode
   outfile             output file in new-file mode
 --no-allow-chown      don't allow file ownership change (default)
 -o, --oldfile         write to old file (default)
   file ...            files to convert in old-file mode
 -q, --quiet           quiet mode, suppress all warnings
 -r, --remove-bom      remove Byte Order Mark (default)
 -s, --safe            skip binary files (default)
 -u,  --keep-utf16     keep UTF-16 encoding
 -ul, --assume-utf16le assume that the input format is UTF-16LE
 -ub, --assume-utf16be assume that the input format is UTF-16BE
 -v,  --verbose        verbose operation
 -F, --follow-symlink  follow symbolic links and convert the targets
 -R, --replace-symlink replace symbolic links with converted files
                         (original target files remain unchanged)
 -S, --skip-symlink    keep symbolic links and targets unchanged (default)
 -V, --version         display version number

```
## 文件夹使用


下面列出怎么对整个目录中的文件做dos2unix操作:
```
$ find . -type f -exec dos2unix {} \;
```
其中具体命令的解释如下：
```
find .
= find files in the current directory

-type f
= of type f

-exec dos2unix {} \;
= and execute dos2unix on each file found
```

批量替换java文件
`find . -name "*.java" -exec dos2unix {} \;`

## sed

用sed进行转换

以下 sed 调用将把 DOS/Windows 格式的文本------->>可信赖的 UNIX 格式：  

sed -i 's/^M$//g' 即寻找以 ^M 结尾的行，string^M\n----》string\n.

sed -i 's/\r$//g'    #这个命令也可以。


反过来，也可以把UNIX---->DOS.    \n----->\r\n.
sed -i 's/$/\r\n/'      #在该脚本中，'$' 规则表达式将与行的末尾匹配，而 '\r' 告诉 sed 在其之前插入一个回车。在换行之前插入回车，立即，每一行就以 CR/LF 结束。
