# ldd

在linux中， ldd是list dynamic dependencies的缩写， 意思是， 列出动态库依赖关系。 

当然， 你也可以用`ldd --help`或者`man ldd`来看其用法。

ldd本身不是一个程序，而仅是一个shell脚本：ldd可以列出一个程序所需要得动态链接库（so）

ldd 用于打印程序或者库文件所依赖的共享库列表。。
ldd 位于/usr/bin/ldd。

`ldd -r` 可打印进程数据和函数重寻址

## help
```
$ ldd --help
用法：ldd [选项]… 文件…
      --help              印出这份说明然后离开
      --version           印出版本信息然后离开
  -d, --data-relocs       进程数据重寻址
  -r, --function-relocs   进程数据和函数重寻址
  -u, --unused            印出未使用的直接依赖关系
  -v, --verbose           印出所有信息

要知道错误报告指令，请参看:
<https://bugs.launchpad.net/ubuntu/+source/glibc/+bugs>.
```

### c demo

```
$ldd /home/parseDemo

linux-vdso.so.1 (0x00007ffe7c7ea000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f4d5e1bd000)
/lib64/ld-linux-x86-64.so.2 (0x00007f4d5e7b3000)
```
### c++ demo
```
$ldd /home/jsonDemo

linux-vdso.so.1 (0x00007ffe44ed2000)
libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007fc1cd3c1000)
libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007fc1cd1a9000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fc1ccdb8000)
libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fc1cca1a000)
/lib64/ld-linux-x86-64.so.2 (0x00007fc1cd9fa000)
```

```
$ldd /usr/lib/x86_64-linux-gnu/libstdc++.so.6
linux-vdso.so.1 (0x00007fff7c5bb000)
libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fa6e4693000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fa6e42a2000)
/lib64/ld-linux-x86x-64.so.2 (0x00007fa6e4dba000)
libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007fa6e408a000)
```

```
$ ldd /lib/x86_64-linux-gnu/libgcc_s.so.1 
linux-vdso.so.1 (0x00007ffd0e2c0000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f5d82a24000)
/lib64/ld-linux-x86-64.so.2 (0x00007f5d8302d000)
``` 

## source
### 原理
ldd不是一个可执行程序，而只是一个shell脚本 ldd能够显示可执行模块的dependency(所属)(所属)，其原理是通过设置一系列的环境变量，如下：LD_TRACE_LOADED_OBJECTS、LD_WARN、LD_BIND_NOW、LD_LIBRARY_VERSION、LD_VERBOSE等。当LD_TRACE_LOADED_OBJECTS环境变量不为空时，任何可执行程序在运行时，它都会只显示模块的dependency(所属)，而程序并不真正执行。要不你可以在shell终端测试一下，如下： `export LD_TRACE_LOADED_OBJECTS=1` 再执行任何的程序，如ls等，看看程序的运行结果。

ldd显示可执行模块的dependency(所属)的工作原理，其实质是通过ld-linux.so（elf动态库的装载器）来实现的。我们知道，ld-linux.so模块会先于executable模块程序工作，并获得控制权，因此当上述的那些环境变量被设置时，ld-linux.so选择了显示可执行模块的dependency(所属)。 实际上可以直接执行ld-linux.so模块，如：`/lib/ld-linux.so.2 --list program`（这相当于ldd program）

### source
``` bash
#! /bin/bash
# Copyright (C) 1996-2018 Free Software Foundation, Inc.
# This file is part of the GNU C Library.

# The GNU C Library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.

# The GNU C Library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public
# License along with the GNU C Library; if not, see
# <http://www.gnu.org/licenses/>.


# This is the `ldd' command, which lists what shared libraries are
# used by given dynamically-linked executables.  It works by invoking the
# run-time dynamic linker as a command and setting the environment
# variable LD_TRACE_LOADED_OBJECTS to a non-empty value.

# We should be able to find the translation right at the beginning.
TEXTDOMAIN=libc
TEXTDOMAINDIR=/usr/share/locale

RTLDLIST="/lib/ld-linux.so.2 /lib64/ld-linux-x86-64.so.2 /libx32/ld-linux-x32.so.2"
warn=
bind_now=
verbose=

while test $# -gt 0; do
  case "$1" in
  --vers | --versi | --versio | --version)
    echo 'ldd (Ubuntu GLIBC 2.27-3ubuntu1) 2.27'
    printf $"Copyright (C) %s Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
" "2018"
    printf $"Written by %s and %s.
" "Roland McGrath" "Ulrich Drepper"
    exit 0
    ;;
  --h | --he | --hel | --help)
    echo $"Usage: ldd [OPTION]... FILE...
      --help              print this help and exit
      --version           print version information and exit
  -d, --data-relocs       process data relocations
  -r, --function-relocs   process data and function relocations
  -u, --unused            print unused direct dependencies
  -v, --verbose           print all information
"
    printf $"For bug reporting instructions, please see:\\n%s.\\n" \
      "<https://bugs.launchpad.net/ubuntu/+source/glibc/+bugs>"
    exit 0
    ;;
  -d | --d | --da | --dat | --data | --data- | --data-r | --data-re | \
  --data-rel | --data-relo | --data-reloc | --data-relocs)
    warn=yes
    shift
    ;;
  -r | --f | --fu | --fun | --func | --funct | --functi | --functio | \
  --function | --function- | --function-r | --function-re | --function-rel | \
  --function-relo | --function-reloc | --function-relocs)
    warn=yes
    bind_now=yes
    shift
    ;;
  -v | --verb | --verbo | --verbos | --verbose)
    verbose=yes
    shift
    ;;
  -u | --u | --un | --unu | --unus | --unuse | --unused)
    unused=yes
    shift
    ;;
  --v | --ve | --ver)
    echo >&2 $"ldd: option \`$1' is ambiguous"
    exit 1
    ;;
  --)           # Stop option processing.
    shift; break
    ;;
  -*)
    echo >&2 'ldd:' $"unrecognized option" "\`$1'"
    echo >&2 $"Try \`ldd --help' for more information."
    exit 1
    ;;
  *)
    break
    ;;
  esac
done

nonelf ()
{
  # Maybe extra code for non-ELF binaries.
  return 1;
}

add_env="LD_TRACE_LOADED_OBJECTS=1 LD_WARN=$warn LD_BIND_NOW=$bind_now"
add_env="$add_env LD_LIBRARY_VERSION=\$verify_out"
add_env="$add_env LD_VERBOSE=$verbose"
if test "$unused" = yes; then
  add_env="$add_env LD_DEBUG=\"$LD_DEBUG${LD_DEBUG:+,}unused\""
fi

# The following command substitution is needed to make ldd work in SELinux
# environments where the RTLD might not have permission to write to the
# terminal.  The extra "x" character prevents the shell from trimming trailing
# newlines from command substitution results.  This function is defined as a
# subshell compound list (using "(...)") to prevent parameter assignments from
# affecting the calling shell execution environment.
try_trace() (
  output=$(eval $add_env '"$@"' 2>&1; rc=$?; printf 'x'; exit $rc)
  rc=$?
  printf '%s' "${output%x}"
  return $rc
)

case $# in
0)
  echo >&2 'ldd:' $"missing file arguments"
  echo >&2 $"Try \`ldd --help' for more information."
  exit 1
  ;;
1)
  single_file=t
  ;;
*)
  single_file=f
  ;;
esac

result=0
for file do
  # We don't list the file name when there is only one.
  test $single_file = t || echo "${file}:"
  case $file in
  */*) :
       ;;
  *) file=./$file
     ;;
  esac
  if test ! -e "$file"; then
    echo "ldd: ${file}:" $"No such file or directory" >&2
    result=1
  elif test ! -f "$file"; then
    echo "ldd: ${file}:" $"not regular file" >&2
    result=1
  elif test -r "$file"; then
    RTLD=
    ret=1
    for rtld in ${RTLDLIST}; do
      if test -x $rtld; then
        dummy=`$rtld 2>&1` 
        if test $? = 127; then
          verify_out=`${rtld} --verify "$file"`
          ret=$?
          case $ret in
          [02]) RTLD=${rtld}; break;;
          esac
        fi
      fi
    done
    case $ret in
    1)
      # This can be a non-ELF binary or no binary at all.
      nonelf "$file" || {
        echo $" not a dynamic executable"
        result=1
      }
      ;;
    0|2)
      try_trace "$RTLD" "$file" || result=1
      ;;
    *)
      echo 'ldd:' ${RTLD} $"exited with unknown exit code" "($ret)" >&2
      exit 1
      ;;
    esac
  else
    echo 'ldd:' $"error: you do not have read permission for" "\`$file'" >&2
    result=1
  fi
done

exit $result
# Local Variables:
#  mode:ksh
# End:
```
