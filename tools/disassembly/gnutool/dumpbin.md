# dumpbin

msvc 自带工具

需要激活 vsvar环境，环境有多个，需要正确选择
- x64
- x86


## usage
```
dumpbin /SYMBOLS a.lib

```
## help
```

H:\project\works\code_sharing\build\os\Debug>dumpbin /?
Microsoft (R) COFF/PE Dumper Version 14.00.24210.0
Copyright (C) Microsoft Corporation.  All rights reserved.

用法: DUMPBIN [选项] [文件]

  选项:

   /ALL
   /ARCHIVEMEMBERS
   /CLRHEADER
   /DEPENDENTS
   /DIRECTIVES
   /DISASM[:{BYTES|NOBYTES}]
   /ERRORREPORT:{NONE|PROMPT|QUEUE|SEND}
   /EXPORTS
   /FPO
   /HEADERS
   /IMPORTS[:文件名]
      /LINENUMBERS
   /LINKERMEMBER[:{1|2}]
   /LOADCONFIG
   /NOLOGO
      /OUT:filename
   /PDATA
   /PDBPATH[:VERBOSE]
   /RANGE:vaMin[,vaMax]
   /RAWDATA[:{NONE|1|2|4|8}[,#]]
   /RELOCATIONS
   /SECTION:名称
   /SUMMARY
   /SYMBOLS
   /TLS
   /UNWINDINFO
```