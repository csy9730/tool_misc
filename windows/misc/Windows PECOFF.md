# [Windows PE/COFF](https://www.cnblogs.com/fr-ruiyang/p/10877330.html)



# Windows PE/COFF

## Windows的二进制文件格式PE/COFF

在32位Windows平台下，微软引入了一种叫**PE（Portable Executable）**的可执行格式。作为Win32平台的标准可执行文件格式，PE有着跟ELF一样良好的平台扩展性和灵活性。PE文件格式事实上与ELF同根同源，他们都是由**COFF（Common Object File Format）**格式发展而来的，更加具体地讲是来源于当时著名的**DEC（Digital Equipment Corporation）**的VAX/VMS上的COFF文件格式。因为当微软开始开发Windows NT的时候，最初的成员都是来自于DEC公司的VAX/VMS小组，所以他们很自然就将原来系统上熟悉的工具和文件格式都搬了过来，并且在此基础上做重新设计和改动。

请注意，上面在讲到PE文件格式的时候，只是说Windows平台下的可执行文件采用该格式。事实上，在Windows平台，VISUAL C++编译器产生的目标文件仍然使用COFF格式。由于PE是COFF的一种扩展，所以它们的结构在很大程度上相同，甚至跟ELF文件的基本结构也相同，都是基于段的结构。所以我们下面在讨论Windows平台上的文件结构时，目标文件默认为COFF格式，而可执行文件为PE格式。但很多时候我们可以将它们统称为PE/COFF文件。

随着64位Windows的发布，微软对64位Windows平台上的PE文件结构稍微做了一些修改，这个新的文件格式叫做PE32+。新的PE32+并没有添加任何结构，最大的变化就是把那些原来32位的字段变成了64位，比如文件头中与地址相关的字段。

## PE的前身——COFF

### COFF文件结构

几乎跟ELF文件一样，COFF也是由文件头及后面的若干个段组成，再加上文件末尾的符号表、调试信息的内容就构成了COFF文件的基本结构，我们在COFF文件中几乎都可以找到与ELF文件结构相对应的地方。COFF文件的文件头部包括了两部分，一个是描述文件总体结构和属性的**映像头(Image Header)**，另外一个是描述该文件中包含的段属性的**段表(Section Table)**。文件头后面紧跟着的就是文件的段，包括代码段、数据段等，最后还有符号表等。

```C++
// 文件头
typedef struct _IMAGE_FILE_HEADER {
    WORD Machine;
    WORD NumberOfSections;
    DWORD TimeDateStamp;
    DWORD PointerToSymbolTable;
    DWORD NumberOfSymbols;
    WORD SizeOfOptionalHeader;
    WORD Characteristics;
} IMAGE_FILE_HEADER, *PIMAGE_FILE_HEADER;

// 段头
typedef struct _IMAGE_SECTION_HEADER {
    BYTE Name[8];
    union {
        DWORD PhysicalAddress;
    	DWORD VirtualSize;
    } Misc;
    DWORD VirtualAddress;
    DWORD SizeOfRawData;
    DWORD PointerToRawData;
    DWORD PointerToRelocations;
    DWORD PointerToLinenumbers;
    WORD NumberOfRelocations;
    WORD NumberOfLinenumbers;
    DWORD Characteristics;
} IMAGE_SECTION_HEADER, *PIMAGE_SECTION_HEADER;
```

## 链接指示信息

".drectve"段的内容是编译器传递给链接器的指令(Derective)，即编译器希望告诉链接器应该怎样链接这个目标文件。段名后面就是段的属性，包括地址、长度、位置等，最后一个属性是标志位“flags”，即IMAGE_SECTION_HEADER里面的Characteristics成员。".drectve"段的标志位为“0x100A00”，它是表中的标志位的组合。

| 标志位     | 宏定义                 | 意义                         |
| ---------- | ---------------------- | ---------------------------- |
| 0x00100000 | IMAGE_SCN_ALIGN_1BYTES | 1个字节对齐。相当于不对齐    |
| 0x00000800 | IMAGE_SCN_LNK_REMOVE   | 最终链接成映像文件时抛弃该段 |
| 0x00000200 | IMAGE_SCN_LNK_INFO     | 该段包含的是注释或其他信息   |

## 调试信息

COFF文件中所有以“.debug”开始的段都包含着调试信息。比如".debugS"表示包含的是符号相关的调试信息段；".debugS"表示包含的是符号相关的调试信息段；".debugP"表示包含的是预编译头文件相关的调试信息段；".debug$T"表示包含的是类型相关的调试信息段。调试信息段的具体格式被定义在**PE格式文件标准**中。

## 大家都有符号表

最后部分是COFF符号表，内容几乎跟ELF文件的符号表一样，主要就是符号名、符号的类型、所在的位置。

## Windows下的ELF——PE

PE文件是基于COFF的扩展，它比COFF文件多 几个结构。最主要的变化有两个：第一个是文件最开始的部分不是COFF文件头，而是**DOS MZ 可执行文件格式的文件头和桩代码（DOS MZ File Header and Stub）**；第二个变化是原来的COFF文件头中的“IMAGE_FILE_HEADER”部分扩展成了PE文件文件头结构，这个结构包括了原来的“Image Header”及新增的**PE扩展头部结构（PE Optional Header）**。

DOS下的可执行文件的扩展名与Windows下的可执行文件扩展名一样，都是“.exe”，但是DOS下的可执行文件格式是“MZ”格式，与Windows下的PE格式完全不同，虽然它们使用相同的扩展名。在Windows发展的早期，那时候DOS系统还如日中天，而且早期的Windows版本还不能脱离DOS环境独立运行，所以为了照顾DOS系统，那些为Windows编写的程序必须尽量兼容原有的DOS系统，所以PE文件在设计之初就背负着历史的累赘。PE文件中“Image DOS Header”和“DOS Stub”这两个结构就是为了兼容DOS系统而设计的，其中“Image DOS Header”结构跟DOS的“MZ”可执行结构的头部完全一样，其结构中有前两个字节是e_magic结构，它是里面包含了MZ两个字母的ASCII码；e_cs和e_ip两个成员指向程序的入口地址。然而PE文件中这两个成员却是指向“DOS Stub”，它是一段可以在DOS下运行的一小段代码，向终端输出一行字：“This program cannot be run in DOS”。

```C++
// PE真正的文件头
typedef struct _IMAGE_NT_HEADERS {
    DWORD Signature; // 标记，对应"PE\0\0"的ASCII码
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER OptionalHeader; //很多成员，有些部分跟PE文件的装载与运行相关
} IMAGE_NT_HEADERS, *PIMAGE_NT_HEADERS;
```

### PE数据目录

在Windows系统装载PE可执行文件时，往往需要很快的找到一些装载所需要的数据结构，比如导入表、导出表、资源、重定位表等。这些常用的数据的位置和长度都被保存在了一个叫数据目录（Data Directory）的结构里面，其实它就是前面“IMAGE_OPTIONAL_HEADER”结构里面的DataDirectory成员。

```C++
typedef struct _IMAGE_DATA_DIRECTORY {
    DWORD VirtualAddress;
    DWORD Size;
} IMAGE_DATA_DIRECTORY, *PIMAGE_DATA_DIRECTORY;

#define IMAGE_DATA_DIRECTORY_ENTRIES 16
```



[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)