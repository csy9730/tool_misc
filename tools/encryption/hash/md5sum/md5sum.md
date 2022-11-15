# md5sum



Message Digest Algorithm MD5为计算机安全领域广泛使用的一种散列函数，用以提供消息的完整性保护。该算法的文件号为RFC 1321（R.Rivest,MIT Laboratory for Computer Science and RSA Data Security Inc. April 1992）
keywords:Hash,SHA,Ronald L. Rivest,MD5,IETF(Internet Engineering Task Force)

### MD5计算

字符串“hello”的MD5：

```
$ echo -n 'hello'|md5sum|cut -d ' ' -f1
# 得到的MD5值：
5d41402abc4b2a76b9719d911017c592
```



获取文件的MD5值：

```
D:\Projects>md5sum CMakeLists.txt
ab81a986476bb000d47292c5ff7658b9 *CMakeLists.txt
```



md5 -c: 从文件中读取MD5 的校验值并予以检查
```
md5sum a.txt > a.md5
md5sum -c a.md5
```

显示ok表示校验成功。
```
.gitignore: OK
```

## help

```

D:\Projects>md5sum --help
Usage: md5sum [OPTION]... [FILE]...
Print or check MD5 (128-bit) checksums.

With no FILE, or when FILE is -, read standard input.

  -b, --binary         read in binary mode (default unless reading tty stdin)
  -c, --check          read MD5 sums from the FILEs and check them
      --tag            create a BSD-style checksum
  -t, --text           read in text mode (default if reading tty stdin)
  -z, --zero           end each output line with NUL, not newline,
                       and disable file name escaping

The following five options are useful only when verifying checksums:
      --ignore-missing  don't fail or report status for missing files
      --quiet          don't print OK for each successfully verified file
      --status         don't output anything, status code shows success
      --strict         exit non-zero for improperly formatted checksum lines
  -w, --warn           warn about improperly formatted checksum lines

      --help     display this help and exit
      --version  output version information and exit

The sums are computed as described in RFC 1321.  When checking, the input
should be a former output of this program.  The default mode is to print a
line with checksum, a space, a character indicating input mode ('*' for binary,
' ' for text or where binary is insignificant), and name for each FILE.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report md5sum translation bugs to <https://translationproject.org/team/>
Full documentation at: <https://www.gnu.org/software/coreutils/md5sum>
or available locally via: info '(coreutils) md5sum invocation'

```

