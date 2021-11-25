# nm

nm 支持obj文件和可执行文件，可以从静态库和动态库中获取到函数名称。均可以获得其中的函数，全局变量。

```
nm --help
用法：nm [选项] [文件]
 列举 [文件] 中的符号 (默认为 a.out)。
 The options are:
  -a, --debug-syms       Display debugger-only symbols
  -A, --print-file-name  Print name of the input file before every symbol
  -B                     Same as --format=bsd
  -C, --demangle[=STYLE] Decode low-level symbol names into user-level names
                          The STYLE, if specified, can be `auto' (the default),
                          `gnu', `lucid', `arm', `hp', `edg', `gnu-v3', `java'
                          or `gnat'
      --no-demangle      Do not demangle low-level symbol names
      --recurse-limit    Enable a demangling recursion limit.  This is the default.
      --no-recurse-limit Disable a demangling recursion limit.
  -D, --dynamic          Display dynamic symbols instead of normal symbols
      --defined-only     Display only defined symbols
  -e                     (ignored)
  -f, --format=FORMAT    Use the output format FORMAT.  FORMAT can be `bsd',
                           `sysv' or `posix'.  The default is `bsd'
  -g, --extern-only      Display only external symbols
  -l, --line-numbers     Use debugging information to find a filename and
                           line number for each symbol
  -n, --numeric-sort     Sort symbols numerically by address
  -o                     Same as -A
  -p, --no-sort          Do not sort the symbols
  -P, --portability      Same as --format=posix
  -r, --reverse-sort     Reverse the sense of the sort
      --plugin NAME      Load the specified plugin
  -S, --print-size       Print size of defined symbols
  -s, --print-armap      Include index for symbols from archive members
      --size-sort        Sort symbols by size
      --special-syms     Include special symbols in the output
      --synthetic        Display synthetic symbols as well
  -t, --radix=RADIX      Use RADIX for printing symbol values
      --target=BFDNAME   Specify the target object format as BFDNAME
  -u, --undefined-only   Display only undefined symbols
      --with-symbol-versions  Display version strings after symbol names
  -X 32_64               (ignored)
  @FILE                  Read options from FILE
  -h, --help             Display this information
  -V, --version          Display this program's version number

nm：支持的目标： elf64-x86-64 elf32-i386 elf32-iamcu elf32-x86-64 a.out-i386-linux pei-i386 pei-x86-64 elf64-l1om elf64-k1om elf64-little elf64-big elf32-little elf32-big pe-x86-64 pe-bigobj-x86-64 pe-i386 plugin srec symbolsrec verilog tekhex binary ihex
将 bug 报告到 <http://www.sourceware.org/bugzilla/>。
```


## demo

### nm
```
DESKTOP-CTAGE42# nm librknn_obfs.a 

rknn_decryption.cpp.o:
                 U _GLOBAL_OFFSET_TABLE_
0000000000000118 T _Z14decrypte_modelPhS_i
0000000000000000 T _Z15hardward_verifyv
                 U _Z20create_kmodza_objectv
                 U exit
                 U puts
                 U zal_deobfs_model
```

### nm -D
```
DESKTOP-CTAGE42# nm -D zal_obfs       
00000000000028a0 R _IO_stdin_used
                 w _ITM_deregisterTMCloneTable
                 w _ITM_registerTMCloneTable
0000000000203010 B __bss_start
                 w __cxa_finalize
0000000000203000 D __data_start
                 w __gmon_start__
0000000000002890 T __libc_csu_fini
0000000000002820 T __libc_csu_init
                 U __libc_start_main
                 U __stack_chk_fail
0000000000203010 D _edata
0000000000203018 B _end
0000000000002894 T _fini
0000000000000a38 T _init
0000000000000b50 T _start
0000000000203000 W data_start
                 U fclose
                 U fopen
                 U fread
                 U free
                 U fseek
                 U ftell
                 U fwrite
0000000000000c5a T main
                 U malloc
                 U printf
                 U puts
                 U rand
                 U srand
                 U time
0000000000001bb1 T zal_deobfs_model
0000000000001b84 T zal_obfs_model
0000000000000e6b T zal_obfskey_model
```
### nm -X
```
DESKTOP-CTAGE42# nm -X 32_64  zal_obfs
0000000000202d60 d _DYNAMIC
0000000000202f50 d _GLOBAL_OFFSET_TABLE_
00000000000028a0 R _IO_stdin_used
                 w _ITM_deregisterTMCloneTable
                 w _ITM_registerTMCloneTable
0000000000002b24 r __FRAME_END__
0000000000002960 r __GNU_EH_FRAME_HDR
0000000000203010 d __TMC_END__
0000000000203010 B __bss_start
                 w __cxa_finalize@@GLIBC_2.2.5
0000000000203000 D __data_start
0000000000000c10 t __do_global_dtors_aux
0000000000202d58 t __do_global_dtors_aux_fini_array_entry
0000000000203008 d __dso_handle
0000000000202d50 t __frame_dummy_init_array_entry
                 w __gmon_start__
0000000000202d58 t __init_array_end
0000000000202d50 t __init_array_start
0000000000002890 T __libc_csu_fini
0000000000002820 T __libc_csu_init
                 U __libc_start_main@@GLIBC_2.2.5
                 U __stack_chk_fail@@GLIBC_2.4
0000000000203010 D _edata
0000000000203018 B _end
0000000000002894 T _fini
0000000000000a38 T _init
0000000000000b50 T _start
0000000000203010 b completed.7698
0000000000203000 W data_start
0000000000000b80 t deregister_tm_clones
                 U fclose@@GLIBC_2.2.5
                 U fopen@@GLIBC_2.2.5
0000000000000c50 t frame_dummy
                 U fread@@GLIBC_2.2.5
                 U free@@GLIBC_2.2.5
                 U fseek@@GLIBC_2.2.5
                 U ftell@@GLIBC_2.2.5
                 U fwrite@@GLIBC_2.2.5
0000000000000c5a T main
                 U malloc@@GLIBC_2.2.5
                 U printf@@GLIBC_2.2.5
                 U puts@@GLIBC_2.2.5
                 U rand@@GLIBC_2.2.5
0000000000000bc0 t register_tm_clones
                 U srand@@GLIBC_2.2.5
                 U time@@GLIBC_2.2.5
0000000000001bb1 T zal_deobfs_model
0000000000001b84 T zal_obfs_model
0000000000000e6b T zal_obfskey_model
```

## misc

1. 命令 `nm -D`，如下所示：
2. 命令 `objdump -tT`，如下所示：

``` bash
nm -D liblistdevs.so > listdevs.txt　　# 列出 liblistdevs.so 的函数 输出到 listdevs.txt 文本文件里面

objdump -tT liblistdevs.so > listdevs.txt　　# 列出 liblistdevs.so 的函数 输出到 listdevs.txt 文本文件里面
```
