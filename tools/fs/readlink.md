# readlink

readlink可以打印链接文件的路径。

``` bash
admin@abc:~/bin$ readlink --help
Usage: readlink [OPTION]... FILE...
Print value of a symbolic link or canonical file name

  -f, --canonicalize            canonicalize by following every symlink in
                                every component of the given name recursively;
                                all but the last component must exist
  -e, --canonicalize-existing   canonicalize by following every symlink in
                                every component of the given name recursively,
                                all components must exist
  -m, --canonicalize-missing    canonicalize by following every symlink in
                                every component of the given name recursively,
                                without requirements on components existence
  -n, --no-newline              do not output the trailing delimiter
  -q, --quiet,
  -s, --silent                  suppress most error messages
  -v, --verbose                 report error messages
  -z, --zero                    end each output line with NUL, not newline
      --help     display this help and exit
      --version  output version information and exit

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
Full documentation at: <http://www.gnu.org/software/coreutils/readlink>
or available locally via: info '(coreutils) readlink invocation'
```


### linux进入软连接所指向的原目录
软连接就是一个快捷方式，建立软连接的方法
```
ln -s source-path-or-file link-file
```
建立硬连接
```
ln source-path-or-file link-file
```
 

linux进入软连接所指向的原目录
```
cd $(readlink -f link-file)
```

```
cd $(readlink -f "$0"|xargs dirname)
```