# objdump help

objdump 可以打印obj文件的信息。


- x86-64      在 64 位模式下反汇编
- i386        在 32 位模式下反汇编
- i8086       在 16 位模式下反汇编



pei-i386 
pei-x86-64 
pe-x86-64 
pe-bigobj-x86-64 
pe-i386

elf64-x86-64 
elf64-l1om 
elf64-k1om 
elf64-little 
elf64-big 

elf32-i386
elf32-iamcu 
elf32-x86-64 
elf32-little 
elf32-big 

a.out-i386-linux 

## help
```
$ objdump --help
用法：objdump <选项> <文件>
 显示来自目标 <文件> 的信息。
 至少必须给出以下选项之一：
  -a, --archive-headers    Display archive header information
  -f, --file-headers       Display the contents of the overall file header
  -p, --private-headers    Display object format specific file header contents
  -P, --private=OPT,OPT... Display object format specific contents
  -h, --[section-]headers  Display the contents of the section headers
  -x, --all-headers        Display the contents of all headers
  -d, --disassemble        Display assembler contents of executable sections
  -D, --disassemble-all    Display assembler contents of all sections
  -S, --source             Intermix source code with disassembly
  -s, --full-contents      Display the full contents of all sections requested
  -g, --debugging          Display debug information in object file
  -e, --debugging-tags     Display debug information using ctags style
  -G, --stabs              Display (in raw form) any STABS info in the file
  -W[lLiaprmfFsoRtUuTgAckK] or
  --dwarf[=rawline,=decodedline,=info,=abbrev,=pubnames,=aranges,=macro,=frames,
          =frames-interp,=str,=loc,=Ranges,=pubtypes,
          =gdb_index,=trace_info,=trace_abbrev,=trace_aranges,
          =addr,=cu_index,=links,=follow-links]
                           Display DWARF info in the file
  -t, --syms               Display the contents of the symbol table(s)
  -T, --dynamic-syms       Display the contents of the dynamic symbol table
  -r, --reloc              Display the relocation entries in the file
  -R, --dynamic-reloc      Display the dynamic relocation entries in the file
  @<file>                  Read options from <file>
  -v, --version            Display this program's version number
  -i, --info               List object formats and architectures supported
  -H, --help               Display this information

 以下选项是可选的：
  -b, --target=BFDNAME           Specify the target object format as BFDNAME
  -m, --architecture=MACHINE     Specify the target architecture as MACHINE
  -j, --section=NAME             Only display information for section NAME
  -M, --disassembler-options=OPT Pass text OPT on to the disassembler
  -EB --endian=big               Assume big endian format when disassembling
  -EL --endian=little            Assume little endian format when disassembling
      --file-start-context       Include context from start of file (with -S)
  -I, --include=DIR              Add DIR to search list for source files
  -l, --line-numbers             Include line numbers and filenames in output
  -F, --file-offsets             Include file offsets when displaying information
  -C, --demangle[=STYLE]         Decode mangled/processed symbol names
                                  The STYLE, if specified, can be `auto', `gnu',
                                  `lucid', `arm', `hp', `edg', `gnu-v3', `java'
                                  or `gnat'
      --recurse-limit            Enable a limit on recursion whilst demangling.  [Default]
      --no-recurse-limit         Disable a limit on recursion whilst demangling
  -w, --wide                     Format output for more than 80 columns
  -z, --disassemble-zeroes       Do not skip blocks of zeroes when disassembling
      --start-address=ADDR       Only process data whose address is >= ADDR
      --stop-address=ADDR        Only process data whose address is <= ADDR
      --prefix-addresses         Print complete address alongside disassembly
      --[no-]show-raw-insn       Display hex alongside symbolic disassembly
      --insn-width=WIDTH         Display WIDTH bytes on a single line for -d
      --adjust-vma=OFFSET        Add OFFSET to all displayed section addresses
      --special-syms             Include special symbols in symbol dumps
      --inlines                  Print all inlines for source line (with -l)
      --prefix=PREFIX            Add PREFIX to absolute paths for -S
      --prefix-strip=LEVEL       Strip initial directory names for -S
      --dwarf-depth=N        Do not display DIEs at depth N or greater
      --dwarf-start=N        Display DIEs starting with N, at the same depth
                             or deeper
      --dwarf-check          Make additional dwarf internal consistency checks.      

objdump：支持的目标： elf64-x86-64 elf32-i386 elf32-iamcu elf32-x86-64 a.out-i386-linux pei-i386 pei-x86-64 elf64-l1om elf64-k1om elf64-little elf64-big elf32-little elf32-big pe-x86-64 pe-bigobj-x86-64 pe-i386 plugin srec symbolsrec verilog tekhex binary ihex
objdump：支持的体系结构： i386 i386:x86-64 i386:x64-32 i8086 i386:intel i386:x86-64:intel i386:x64-32:intel i386:nacl i386:x86-64:nacl i386:x64-32:nacl iamcu iamcu:intel l1om l1om:intel k1om k1om:intel plugin

下列 i386/x86-64 特定的反汇编器选项在使用 -M 开关时可用（使用逗号分隔多个选项）：
  x86-64      在 64 位模式下反汇编
  i386        在 32 位模式下反汇编
  i8086       在 16 位模式下反汇编
  att         用 AT&T 语法显示指令
  intel       用 Intel 语法显示指令
  att-mnemonic
              Display instruction in AT&T mnemonic
  intel-mnemonic
              Display instruction in Intel mnemonic
  addr64      假定 64 位地址大小
  addr32      假定 32 位地址大小
  addr16      假定 16 位地址大小
  data32      假定 32 位数据大小
  data16      假定 16 位数据大小
  suffix      在 AT&T 语法中始终显示指令后缀
  amd64       Display instruction in AMD64 ISA
  intel64     Display instruction in Intel64 ISA
将 bug 报告到 <http://www.sourceware.org/bugzilla/>。
```


## demo

### 打印符号表 
```
DESKTOP-CTAGE42# objdump -t zal_obfs

zal_obfs:     file format elf64-x86-64

SYMBOL TABLE:
0000000000000238 l    d  .interp        0000000000000000              .interp
0000000000000254 l    d  .note.ABI-tag  0000000000000000              .note.ABI-tag
0000000000000274 l    d  .note.gnu.build-id     0000000000000000              .note.gnu.build-id
0000000000000298 l    d  .gnu.hash      0000000000000000              .gnu.hash
0000000000000300 l    d  .dynsym        0000000000000000              .dynsym
0000000000000648 l    d  .dynstr        0000000000000000              .dynstr
00000000000007b0 l    d  .gnu.version   0000000000000000              .gnu.version
00000000000007f8 l    d  .gnu.version_r 0000000000000000              .gnu.version_r
0000000000000828 l    d  .rela.dyn      0000000000000000              .rela.dyn
00000000000008e8 l    d  .rela.plt      0000000000000000              .rela.plt
0000000000000a38 l    d  .init  0000000000000000              .init
0000000000000a50 l    d  .plt   0000000000000000              .plt
0000000000000b40 l    d  .plt.got       0000000000000000              .plt.got
0000000000000b50 l    d  .text  0000000000000000              .text
0000000000002894 l    d  .fini  0000000000000000              .fini
00000000000028a0 l    d  .rodata        0000000000000000              .rodata
0000000000002960 l    d  .eh_frame_hdr  0000000000000000              .eh_frame_hdr
00000000000029b8 l    d  .eh_frame      0000000000000000              .eh_frame
0000000000202d50 l    d  .init_array    0000000000000000              .init_array
0000000000202d58 l    d  .fini_array    0000000000000000              .fini_array
0000000000202d60 l    d  .dynamic       0000000000000000              .dynamic
0000000000202f50 l    d  .got   0000000000000000              .got
0000000000203000 l    d  .data  0000000000000000              .data
0000000000203010 l    d  .bss   0000000000000000              .bss
0000000000000000 l    d  .comment       0000000000000000              .comment
0000000000000000 l    df *ABS*  0000000000000000              crtstuff.c
0000000000000b80 l     F .text  0000000000000000              deregister_tm_clones
0000000000000bc0 l     F .text  0000000000000000              register_tm_clones
0000000000000c10 l     F .text  0000000000000000              __do_global_dtors_aux
0000000000203010 l     O .bss   0000000000000001              completed.7698
0000000000202d58 l     O .fini_array    0000000000000000              __do_global_dtors_aux_fini_array_entry
0000000000000c50 l     F .text  0000000000000000              frame_dummy
0000000000202d50 l     O .init_array    0000000000000000              __frame_dummy_init_array_entry
0000000000000000 l    df *ABS*  0000000000000000              zal_obfs_file.c
0000000000000000 l    df *ABS*  0000000000000000              zal_obfs.c
0000000000000000 l    df *ABS*  0000000000000000              crtstuff.c
0000000000002b24 l     O .eh_frame      0000000000000000              __FRAME_END__
0000000000000000 l    df *ABS*  0000000000000000              
0000000000202d58 l       .init_array    0000000000000000              __init_array_end
0000000000203008 l     O .data  0000000000000000              __dso_handle
0000000000202d60 l     O .dynamic       0000000000000000              _DYNAMIC
0000000000202d50 l       .init_array    0000000000000000              __init_array_start
0000000000002960 l       .eh_frame_hdr  0000000000000000              __GNU_EH_FRAME_HDR
0000000000203010 l     O .data  0000000000000000              __TMC_END__
0000000000202f50 l     O .got   0000000000000000              _GLOBAL_OFFSET_TABLE_
0000000000002890 g     F .text  0000000000000002              __libc_csu_fini
0000000000000000       F *UND*  0000000000000000              free@@GLIBC_2.2.5
0000000000000000  w      *UND*  0000000000000000              _ITM_deregisterTMCloneTable
0000000000203000  w      .data  0000000000000000              data_start
0000000000001bb1 g     F .text  0000000000000c6f              zal_deobfs_model
0000000000000000       F *UND*  0000000000000000              puts@@GLIBC_2.2.5
0000000000000000       F *UND*  0000000000000000              fread@@GLIBC_2.2.5
0000000000203010 g       .data  0000000000000000              _edata
0000000000000000       F *UND*  0000000000000000              fclose@@GLIBC_2.2.5
0000000000002894 g     F .fini  0000000000000000              _fini
0000000000000000       F *UND*  0000000000000000              __stack_chk_fail@@GLIBC_2.4
0000000000000000       F *UND*  0000000000000000              printf@@GLIBC_2.2.5
0000000000000000       F *UND*  0000000000000000              __libc_start_main@@GLIBC_2.2.5
0000000000000000       F *UND*  0000000000000000              srand@@GLIBC_2.2.5
0000000000203000 g       .data  0000000000000000              __data_start
0000000000000000       F *UND*  0000000000000000              ftell@@GLIBC_2.2.5
0000000000000000  w      *UND*  0000000000000000              __gmon_start__
00000000000028a0 g     O .rodata        0000000000000004              _IO_stdin_used
0000000000000000       F *UND*  0000000000000000              time@@GLIBC_2.2.5
0000000000002820 g     F .text  0000000000000065              __libc_csu_init
0000000000000000       F *UND*  0000000000000000              malloc@@GLIBC_2.2.5
0000000000203018 g       .bss   0000000000000000              _end
0000000000000e6b g     F .text  0000000000000d19              zal_obfskey_model
0000000000000b50 g     F .text  000000000000002b              _start
0000000000000000       F *UND*  0000000000000000              fseek@@GLIBC_2.2.5
0000000000203010 g       .bss   0000000000000000              __bss_start
0000000000000c5a g     F .text  0000000000000211              main
0000000000000000       F *UND*  0000000000000000              fopen@@GLIBC_2.2.5
0000000000001b84 g     F .text  000000000000002d              zal_obfs_model
0000000000000000       F *UND*  0000000000000000              fwrite@@GLIBC_2.2.5
0000000000000000  w      *UND*  0000000000000000              _ITM_registerTMCloneTable
0000000000000000  w    F *UND*  0000000000000000              __cxa_finalize@@GLIBC_2.2.5
0000000000000a38 g     F .init  0000000000000000              _init
0000000000000000       F *UND*  0000000000000000              rand@@GLIBC_2.2.5
```

### 打印符号表捕捉代码段

```
DESKTOP-CTAGE42# objdump -t zal_obfs|grep text
0000000000000b50 l    d  .text  0000000000000000              .text
0000000000000b80 l     F .text  0000000000000000              deregister_tm_clones
0000000000000bc0 l     F .text  0000000000000000              register_tm_clones
0000000000000c10 l     F .text  0000000000000000              __do_global_dtors_aux
0000000000000c50 l     F .text  0000000000000000              frame_dummy
0000000000002890 g     F .text  0000000000000002              __libc_csu_fini
0000000000001bb1 g     F .text  0000000000000c6f              zal_deobfs_model
0000000000002820 g     F .text  0000000000000065              __libc_csu_init
0000000000000e6b g     F .text  0000000000000d19              zal_obfskey_model
0000000000000b50 g     F .text  000000000000002b              _start
0000000000000c5a g     F .text  0000000000000211              main
0000000000001b84 g     F .text  000000000000002d              zal_obfs_model
```

### 3
```

D:\gcc\tmp>objdump -h a.exe

a.exe:     file format pei-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00001164  00401000  00401000  00000400  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE, DATA
  1 .data         0000001c  00403000  00403000  00001600  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .rdata        00000270  00404000  00404000  00001800  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .eh_frame     000004f8  00405000  00405000  00001c00  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .bss          00000084  00406000  00406000  00000000  2**2
                  ALLOC
  5 .idata        00000494  00407000  00407000  00002200  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  6 .CRT          00000018  00408000  00408000  00002800  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  7 .tls          00000020  00409000  00409000  00002a00  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  8 .debug_aranges 00000038  0040a000  0040a000  00002c00  2**3
                  CONTENTS, READONLY, DEBUGGING
  9 .debug_info   00001cff  0040b000  0040b000  00002e00  2**0
                  CONTENTS, READONLY, DEBUGGING
 10 .debug_abbrev 0000012f  0040d000  0040d000  00004c00  2**0
                  CONTENTS, READONLY, DEBUGGING
 11 .debug_line   000001c8  0040e000  0040e000  00004e00  2**0
                  CONTENTS, READONLY, DEBUGGING
 12 .debug_frame  00000038  0040f000  0040f000  00005000  2**2
                  CONTENTS, READONLY, DEBUGGING

D:\gcc\tmp>
```


#### 查看头信息

```
D:\Project\mylib\tool_misc\tools\compiler\gcc\gcc\tmp>objdump -a 1.o

1.o:     file format pe-i386
1.o

```
#### 查看架构信息
```
D:\Project\mylib\tool_misc\tools\compiler\gcc\gcc\tmp>objdump -f 1.o

1.o:     file format pe-i386
architecture: i386, flags 0x00000039:
HAS_RELOC, HAS_DEBUG, HAS_SYMS, HAS_LOCALS
start address 0x00000000
```

#### 查看段信息
```
D:\Project\mylib\tool_misc\tools\compiler\gcc\gcc\tmp>objdump -h 1.o

1.o:     file format pe-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000024  00000000  00000000  0000012c  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .data         00000004  00000000  00000000  00000150  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  00000000  00000000  00000000  2**2
                  ALLOC
  3 .drectve      00000014  00000000  00000000  00000154  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  4 .rdata        0000000c  00000000  00000000  00000168  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .rdata$zzz    00000024  00000000  00000000  00000174  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .eh_frame     00000038  00000000  00000000  00000198  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
```

#### 反汇编
```
D:\Project\mylib\tool_misc\tools\compiler\gcc\gcc\tmp>objdump -d 1.o

1.o:     file format pe-i386


Disassembly of section .text:

00000000 <_main>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   83 e4 f0                and    $0xfffffff0,%esp
   6:   83 ec 10                sub    $0x10,%esp
   9:   e8 00 00 00 00          call   e <_main+0xe>
   e:   c7 04 24 00 00 00 00    movl   $0x0,(%esp)
  15:   e8 00 00 00 00          call   1a <_main+0x1a>
  1a:   b8 00 00 00 00          mov    $0x0,%eax
  1f:   c9                      leave
  20:   c3                      ret
  21:   90                      nop
  22:   90                      nop
  23:   90                      nop
```