# ld


ar命令是GCC的相关工具，路径为/usr/bin/ld。

## help
```
 ld --help
用法：ld [选项] 文件...
选项：
  -a 关键字                为了 HP/UX 兼容性的共用程序库控制
  -A 架构, --architecture 架构
                              设置 CPU 架构
  -b 目标, --format 目标  指定随后的输入文件的目标
  -c 文件, --mri-script 文件
                              读取 MRI 格式的链接脚本
  -d, -dc, -dp                强制公共符号必须定义
  --force-group-allocation    Force group members out of groups
  -e 地址, --entry 地址   设置起始地址
  -E, --export-dynamic        导出所有动态符号
  --no-export-dynamic         复原 --export-dynamic 的效果
  -EB                         链接高位字节在前的目标文件
  -EL                         链接低位字节在前的目标文件
  -f 共享库, --auxiliary 共享库
                              指定为某共享对象符号表的辅助过滤器
  -F 共享库, --filter 共享库
                              指定为某共享对象符号表的过滤器
  -g                          忽略
  -G 大小, --gpsize 大小  小数据的大小(如果未给出大小，与 --shared 相同)
  -h 文件名, -soname 文件名
                              设置共享库的内部名称
  -I 程序, --dynamic-linker 程序
                              将“程序”设为要使用的动态链接器
  --no-dynamic-linker         Produce an executable with no program interpreter header
  -l 库名, --library 库名 搜索库“库名”
  -L 目录, --library-path 目录
                              将“目录”添加到库搜索路径中
  --sysroot=<DIRECTORY>       强制覆写缺省的 sysroot 位置
  -m 仿真                   设置仿真
  -M, --print-map             在标准输出上打印链接图文件
  -n, --nmagic                不将数据对齐至页边界
  -N, --omagic                不将数据对齐至页边界，不将 text 节只读
  --no-omagic                 将数据对齐至页边界，令 text 节只读
  -o 文件, --output 文件  设置输出文件名
  -O                          优化输出文件
  --out-implib 文件         Generate import library
  -plugin 插件程序        加载具名的插件程序
  -plugin-opt 参数          发送参数给最后加载的插件程序
  -flto                       忽略了 GCC LTO 选项兼容性
  -flto-partition=            忽略了 GCC LTO 选项兼容性
  -fuse-ld=                   为 GCC 链接器选项兼容性忽略
  --map-whole-files           Ignored for gold option compatibility
  --no-map-whole-files        Ignored for gold option compatibility
  -Qy                         为 SVR4 兼容性所忽略
  -q, --emit-relocs           Generate relocations in final output
  -r, -i, --relocatable       生成可重新定位的输出
  -R 文件, --just-symbols 文件
                              仅链接符号 (如果是目标，与 --rpath 相同)
  -s, --strip-all             剔除所有符号信息
  -S, --strip-debug           剔除调试符号信息
  --strip-discarded           剔除被丢弃的节中的符号
  --no-strip-discarded        不剔除被丢弃的节中的符号
  -t, --trace                 跟踪文件打开操作
  -T 文件, --script 文件  读取链接脚本
  --default-script 文件, -dT
                              读取缺省链结器指令稿
  -u 符号, --undefined 符号
                              以未定义的符号参考开始
  --require-defined 符号    Require SYMBOL be defined in the final output
  --unique [=节]             不合并名为“节”的输入节或孤立节
  -Ur                         生成全局构造/析构函数表
  -v, --version               显示版本信息
  -V                          显示版本和仿真信息
  -x, --discard-all           丢弃所有局部符号
  -X, --discard-locals        丢弃临时局部符号(默认)
  --discard-none              不丢弃任何局部符号
  -y 符号, --trace-symbol 符号
                              符号的追踪表记
  -Y 路径                   为了 Solaris 兼容性的缺省搜索路径
  -(, --start-group           开始一个组
  -), --end-group             结束一个组
  --accept-unknown-input-arch 接受无法决定其架构的输入文件
  --no-accept-unknown-input-arch
                              拒绝架构不明的输入文件
  --as-needed                 如果使用的话，只有设置 DT_NEEDED 于下述的动态函数库
  --no-as-needed              一律设置 DT_NEEDED 用于命令行提及的动态函数库
  -assert 关键字           为 SunOS 兼容性所忽略
  -Bdynamic, -dy, -call_shared
                              链接到共享库
  -Bstatic, -dn, -non_shared, -static
                              不链接到共享库
  -Bsymbolic                  局部地绑定全域参考
  -Bsymbolic-functions        将全域函数参考绑定于本地
  --check-sections            检查节地址是否重叠(缺省)
  --no-check-sections         不检查节地址是否重叠
  --copy-dt-needed-entries    复制于其后追随 DSOs 内部所提及的 DT_NEEDED 链结
  --no-copy-dt-needed-entries 不复制于其后追随 DSOs 内部所提及的 DT_NEEDED 链结
  --cref                      输出交叉引用表
  --defsym 符号=表达式   定义一个符号
  --demangle [=风格]        解修饰符号名[使用“风格”]
  --embedded-relocs           产生嵌入式重寻址
  --fatal-warnings            将警告当作错误
  --no-fatal-warnings         不将警告当做错误 (缺省)
  -fini 符号                在卸载时间调用符号
  --force-exe-suffix          强制为生成的文件添加 .exe 后缀
  --gc-sections               删除未使用的节(在某些目标上)
  --no-gc-sections            不删除未使用的节(默认)
  --print-gc-sections         于标准勘误列出已移除的未使用节
  --no-print-gc-sections      不要列出已移除的未使用节
  --gc-keep-exported          Keep exported symbols when removing unused sections
  --hash-size=<NUMBER>        设置初始的散列表大小应接近<数>
  --help                      显示选项帮助
  -init 符号                在加载时间调用符号
  -Map 文件                 写入一个链接图文件
  --no-define-common          不定义公共储藏
  --no-demangle               不解读符号名称
  --no-keep-memory            更多地使用磁盘 I/O 而不是内存
  --no-undefined              不允许在目标文件中存在无法解析的引用
  --allow-shlib-undefined     允许共用函数库中有无法解析的参照
  --no-allow-shlib-undefined  不允许在共享库中存在无法解析的引用
  --allow-multiple-definition 允许多个定义
  --no-undefined-version      不允许未定义的版本
  --default-symver            生成默认的符号版本
  --default-imported-symver   为导入符号生成默认的符号版本
  --no-warn-mismatch          不为不匹配的输入文件发出警告
  --no-warn-search-mismatch   找到不兼容的函数库时不要警告
  --no-whole-archive          关闭 --whole-archive
  --noinhibit-exec            即使发生错误也要创建输出文件
  -nostdlib                   只使用于命令行指定的函数库目录
  --oformat 目标            指定输出文件的目标
  --print-output-format       印出缺省输出格式
  --print-sysroot             Print current sysroot
  -qmagic                     为 Linux 兼容性所忽略
  --reduce-memory-overheads   降低内存额外负担，可能会花费更多时间
  --relax                     通过使用目标特定的最佳化以缩减代码大小
  --no-relax                  不使用松弛技术以缩减代码大小
  --retain-symbols-file 文件
                              只保留在“文件”中列出的符号
  -rpath 路径               设置运行时共享库的搜索路径
  -rpath-link 路径          设置链接时共享库的搜索路径
  -shared, -Bshareable        创建一个共享库
  -pie, --pic-executable      生成一个位置无关的可执行文件
  --sort-common [=ascending|descending]
                              依照对齐来排序一般符号 [以指定的排序]
  --sort-section 名称|对齐
                              依名称或最大值对齐来排序节
  --spare-dynamic-tags 计数 有多少标记要保留在 .dynamic 节中
  --split-by-file [=大小]   依每[大小]八字节来分割输出节
  --split-by-reloc [=计数]  依每[计数]重寻址来分割输出节
  --stats                     打印内存使用统计
  --target-help               显示目标相关的选项
  --task-link 符号          运行工作等级链结
  --traditional-format        使用与原生链结器相同的格式
  --section-start 节=地址  设置有名节的地址
  -Tbss 地址                设置 .bss 节的地址
  -Tdata 地址               设置 .data 节的地址
  -Ttext 地址               设置 .text 节的地址
  -Ttext-segment 地址       设置文本数据段的地址
  -Trodata-segment 地址     设置 rodata 只读数据段的地址
  -Tldata-segment 地址      设置 ldata 数据段的地址
  --unresolved-symbols=<method>
                              如何处理无法解析的符号。 <方法> 可以是:
                                ignore-all, report-all, ignore-in-object-files,
                                ignore-in-shared-libs
  --verbose [=数字]         链接过程中输出大量相关信息
  --version-script 文件     读取版本信息脚本
  --version-exports-section 符号
                              从 .exports 取得导出符号清单，使用 SYMBOL 作为版本。
  --dynamic-list-data         加入数据符号到动态清单
  --dynamic-list-cpp-new      使用 C++ 运算子以添加/删除动态清单
  --dynamic-list-cpp-typeinfo 使用 C++ typeinfo 动态清单
  --dynamic-list 文件       读取动态清单
  --warn-common               为重复的公共符号给出警告
  --warn-constructors         如果看得见全域建构子/解构式就给予警告
  --warn-multiple-gp          如果使用了多重 GP 值就给予警告
  --warn-once                 为每一个未定义的符号只警告一次
  --warn-section-align        如果节的开始由于对齐而变更就给予警告
  --warn-shared-textrel       如果共用对象有 DT_TEXTREL 就给予警告
  --warn-alternate-em         如果对象有交替 ELF 机器码就给予警告
  --warn-unresolved-symbols   将不能解析的符号视作警告
  --error-unresolved-symbols  将不能解析的符号视作错误
  --whole-archive             包含下述文件中的所有对象
  --wrap 符号               使用包装函数作为[符号]
  --ignore-unresolved-symbol 符号
                              未解析的符号 SYMBOL 不会导致错误或警告
  --push-state                Push state of flags governing input file handling
  --pop-state                 Pop state of flags governing input file handling
  --print-memory-usage        Report target memory usage
  --orphan-handling =MODE     Control how orphan sections are handled.
  @文件                       从 FILE 读取选项
ld：支持的目标： elf64-x86-64 elf32-i386 elf32-iamcu elf32-x86-64 a.out-i386-linux pei-i386 pei-x86-64 elf64-l1om elf64-k1om elf64-little elf64-big elf32-little elf32-big pe-x86-64 pe-bigobj-x86-64 pe-i386 plugin srec symbolsrec verilog tekhex binary ihex
ld：支持的仿真： elf_x86_64 elf32_x86_64 elf_i386 elf_iamcu i386linux elf_l1om elf_k1om i386pep i386pe
ld：仿真特定选项：
ELF emulations:
  --ld-generated-unwind-info  Generate exception handling info for PLT
  --no-ld-generated-unwind-info
                              Don't generate exception handling info for PLT
  --build-id[=STYLE]          Generate build ID note
  --compress-debug-sections=[none|zlib|zlib-gnu|zlib-gabi]
                              Compress DWARF debug sections using zlib
                               Default: none
  -z common-page-size=SIZE    Set common page size to SIZE
  -z max-page-size=SIZE       Set maximum page size to SIZE
  -z defs                     Report unresolved symbols in object files.
  -z muldefs                  Allow multiple definitions
  -z execstack                Mark executable as requiring executable stack
  -z noexecstack              Mark executable as not requiring executable stack
  -z globalaudit              Mark executable requiring global auditing
  --audit=AUDITLIB            Specify a library to use for auditing
  -Bgroup                     Selects group name lookup rules for DSO
  --disable-new-dtags         Disable new dynamic tags
  --enable-new-dtags          Enable new dynamic tags
  --eh-frame-hdr              Create .eh_frame_hdr section
  --no-eh-frame-hdr           Do not create .eh_frame_hdr section
  --exclude-libs=LIBS         Make all symbols in LIBS hidden
  --hash-style=STYLE          Set hash style to sysv, gnu or both
  -P AUDITLIB, --depaudit=AUDITLIB
                              Specify a library to use for auditing dependencies
  -z combreloc                Merge dynamic relocs into one section and sort
  -z nocombreloc              Don't merge dynamic relocs into one section
  -z global                   Make symbols in DSO available for subsequently
                               loaded objects
  -z initfirst                Mark DSO to be initialized first at runtime
  -z interpose                Mark object to interpose all DSOs but executable
  -z lazy                     Mark object lazy runtime binding (default)
  -z loadfltr                 Mark object requiring immediate process
  -z nocopyreloc              Don't create copy relocs
  -z nodefaultlib             Mark object not to use default search paths
  -z nodelete                 Mark DSO non-deletable at runtime
  -z nodlopen                 Mark DSO not available to dlopen
  -z nodump                   Mark DSO not available to dldump
  -z now                      Mark object non-lazy runtime binding
  -z origin                   Mark object requiring immediate $ORIGIN
                                processing at runtime
  -z relro                    Create RELRO program header (default)
  -z norelro                  Don't create RELRO program header
  -z separate-code            Create separate code program header
  -z noseparate-code          Don't create separate code program header (default)
  -z common                   Generate common symbols with STT_COMMON type
  -z nocommon                 Generate common symbols with STT_OBJECT type
  -z stack-size=SIZE          Set size of stack segment
  -z text                     Treat DT_TEXTREL in shared object as error
  -z notext                   Don't treat DT_TEXTREL in shared object as error
  -z textoff                  Don't treat DT_TEXTREL in shared object as error
elf_x86_64: 
  -z noextern-protected-data  Do not treat protected data symbol as external
  -z dynamic-undefined-weak   Make undefined weak symbols dynamic
  -z nodynamic-undefined-weak Do not make undefined weak symbols dynamic
  -z noreloc-overflow         Disable relocation overflow check
  -z call-nop=PADDING         Use PADDING as 1-byte NOP for branch
  -z ibtplt                   Generate IBT-enabled PLT entries
  -z ibt                      Generate GNU_PROPERTY_X86_FEATURE_1_IBT
  -z shstk                    Generate GNU_PROPERTY_X86_FEATURE_1_SHSTK
  -z bndplt                   Always generate BND prefix in PLT entries
elf32_x86_64: 
  -z noextern-protected-data  Do not treat protected data symbol as external
  -z dynamic-undefined-weak   Make undefined weak symbols dynamic
  -z nodynamic-undefined-weak Do not make undefined weak symbols dynamic
  -z noreloc-overflow         Disable relocation overflow check
  -z call-nop=PADDING         Use PADDING as 1-byte NOP for branch
  -z ibtplt                   Generate IBT-enabled PLT entries
  -z ibt                      Generate GNU_PROPERTY_X86_FEATURE_1_IBT
  -z shstk                    Generate GNU_PROPERTY_X86_FEATURE_1_SHSTK
elf_i386: 
  -z noextern-protected-data  Do not treat protected data symbol as external
  -z dynamic-undefined-weak   Make undefined weak symbols dynamic
  -z nodynamic-undefined-weak Do not make undefined weak symbols dynamic
  -z call-nop=PADDING         Use PADDING as 1-byte NOP for branch
  -z ibtplt                   Generate IBT-enabled PLT entries
  -z ibt                      Generate GNU_PROPERTY_X86_FEATURE_1_IBT
  -z shstk                    Generate GNU_PROPERTY_X86_FEATURE_1_SHSTK
elf_iamcu: 
  -z noextern-protected-data  Do not treat protected data symbol as external
  -z dynamic-undefined-weak   Make undefined weak symbols dynamic
  -z nodynamic-undefined-weak Do not make undefined weak symbols dynamic
  -z call-nop=PADDING         Use PADDING as 1-byte NOP for branch
elf_l1om: 
  -z noextern-protected-data  Do not treat protected data symbol as external
  -z dynamic-undefined-weak   Make undefined weak symbols dynamic
  -z nodynamic-undefined-weak Do not make undefined weak symbols dynamic
  -z call-nop=PADDING         Use PADDING as 1-byte NOP for branch
elf_k1om: 
  -z noextern-protected-data  Do not treat protected data symbol as external
  -z dynamic-undefined-weak   Make undefined weak symbols dynamic
  -z nodynamic-undefined-weak Do not make undefined weak symbols dynamic
  -z call-nop=PADDING         Use PADDING as 1-byte NOP for branch
i386pep: 
  --base_file <基址文件>             为可重定位的 DLL 生成一个基址文件
  --dll                              设置 DLL 的默认映象基址
  --file-alignment <大小>            设置文件对齐边界
  --heap <大小>                      设置堆的初始大小
  --image-base <地址>                设置可执行文件的起始地址
  --major-image-version <数>         设置可执行文件的版本号
  --major-os-version <数>            设置对操作系统版本的最低要求
  --major-subsystem-version <数>     设置对操作系统子系统版本的最低要求
  --minor-image-version <数>         设置可执行文件的修订版本号
  --minor-os-version <数>            设置对操作系统修订版本的最低要求
  --minor-subsystem-version <数>     设置对操作系统子系统修订版本的最低要求
  --section-alignment <大小>         设置节的对齐边界
  --stack <大小>                     设置初始栈的大小
  --subsystem <名>[:<版本>]          设置需要的操作系统子系统[和版本号]
  --support-old-code                 支持与旧式代码的交互工作
  --[no-]leading-underscore          设置明确的符号底线前缀模式
  --[no-]insert-timestamp            Use a real timestamp rather than zero. (default)
                                     这会使二进制文件存在不确定性
  --add-stdcall-alias                导出带与不带 @nn 的符号
  --disable-stdcall-fixup            不将 _sym 链接至 _sym@nn
  --enable-stdcall-fixup             将 _sym 链接至 _sym@nn 而不给出警告
  --exclude-symbols 符号,符号,...    将一些符号排除在自动导入以外
  --exclude-all-symbols              从自动导出排除所有符号
  --exclude-libs 库,库,...           将一些库排除在自动导入以外
  --exclude-modules-for-implib mod,mod,...
                                     从自动导出排除对象、归档成员
                                     导出，而非放进导入函数库。
  --export-all-symbols               自动将所有全局量导出至 DLL
  --kill-at                          从导出符号中移去 @nn
  --output-def <文件>                为建立的 DLL 生成一个 .DEF 文件
  --warn-duplicate-exports           Warn about duplicate exports.
  --compat-implib                    生成后向兼容的导入库；
                                       同时生成 __imp_<符号>。
  --enable-auto-image-base           Automatically choose image base for DLLs
                                       unless user specifies one
  --disable-auto-image-base          不自动选择映象基址。(默认)
  --dll-search-prefix=<字符串>       动态链接至 DLL 而缺少导入库时，使用
                                      <字符串><基本名>.dll 而不是 lib<基本名>.dll 
  --enable-auto-import               为实现 DATA 引用，使用复杂的手段将 _sym
                                       链接至 __imp_sym
  --disable-auto-import              不为 DLL 自动导入 DATA 项
  --enable-runtime-pseudo-reloc      利用在运行阶段加入已解析的假性重寻址
                                       来作为自动导入限制的解决方法。
  --disable-runtime-pseudo-reloc     不加入用于自动导入数据的运行阶段假性重寻址。
  --enable-extra-pep-debug            Enable verbose debug output when building
                                       or linking to DLLs (esp. auto-import)
  --enable-long-section-names        即使在可运行映像档中也使用
                                       长 COFF 节段名称
  --disable-long-section-names       即使在目的文件中也
                                       永不使用长 COFF 节段名称
  --high-entropy-va                  Image is compatible with 64-bit address space
                                       layout randomization (ASLR)
  --dynamicbase                  映像基底地址可以重新寻址，利用
                                       地址空间布局随机化 (ASLR)
  --forceinteg           已强制编码集成性检查
  --nxcompat             映像兼容于数据运行防止措施
  --no-isolation                 映像理解隔离性但是并不隔离映像
  --no-seh                       映像不使用 SEH。没有 SE 处理程序可在此映像中被调用
  --no-bind                      不要绑定这个映像
  --wdmdriver            驱动程序使用 WDM 式样
  --tsaware                  映像能认知终端服务器
  --build-id[=STYLE]         Generate build ID
i386pe: 
  --base_file <基址文件>             为可重定位的 DLL 生成一个基址文件
  --dll                              设置 DLL 的默认映象基址
  --file-alignment <大小>            设置文件对齐边界
  --heap <大小>                      设置堆的初始大小
  --image-base <地址>                设置可执行文件的起始地址
  --major-image-version <数>         设置可执行文件的版本号
  --major-os-version <数>            设置对操作系统版本的最低要求
  --major-subsystem-version <数>     设置对操作系统子系统版本的最低要求
  --minor-image-version <数>         设置可执行文件的修订版本号
  --minor-os-version <数>            设置对操作系统修订版本的最低要求
  --minor-subsystem-version <数>     设置对操作系统子系统修订版本的最低要求
  --section-alignment <大小>         设置节的对齐边界
  --stack <大小>                     设置初始栈的大小
  --subsystem <名>[:<版本>]          设置需要的操作系统子系统[和版本号]
  --support-old-code                 支持与旧式代码的交互工作
  --[no-]leading-underscore          设置明确的符号底线前缀模式
  --thumb-entry=<符号>               设置入口点为 ARM Thumb <符号>
  --[no-]insert-timestamp            Use a real timestamp rather than zero (default).
                                     这会使二进制文件存在不确定性
  --add-stdcall-alias                导出带与不带 @nn 的符号
  --disable-stdcall-fixup            不将 _sym 链接至 _sym@nn
  --enable-stdcall-fixup             将 _sym 链接至 _sym@nn 而不给出警告
  --exclude-symbols 符号,符号,...    将一些符号排除在自动导入以外
  --exclude-all-symbols              从自动导出排除所有符号
  --exclude-libs 库,库,...           将一些库排除在自动导入以外
  --exclude-modules-for-implib mod,mod,...
                                     从自动导出排除对象、归档成员
                                     导出，而非放进导入函数库。
  --export-all-symbols               自动将所有全局量导出至 DLL
  --kill-at                          从导出符号中移去 @nn
  --output-def <文件>                为建立的 DLL 生成一个 .DEF 文件
  --warn-duplicate-exports           Warn about duplicate exports
  --compat-implib                    生成后向兼容的导入库；
                                       同时生成 __imp_<符号>。
  --enable-auto-image-base[=<address>] Automatically choose image base for DLLs
                                       (optionally starting with address) unless
                                       specifically set with --image-base
  --disable-auto-image-base          不自动选择映象基址。(默认)
  --dll-search-prefix=<字符串>       动态链接至 DLL 而缺少导入库时，使用
                                      <字符串><基本名>.dll 而不是 lib<基本名>.dll 
  --enable-auto-import               为实现 DATA 引用，使用复杂的手段将 _sym
                                       链接至 __imp_sym
  --disable-auto-import              不为 DLL 自动导入 DATA 项
  --enable-runtime-pseudo-reloc      利用在运行阶段加入已解析的假性重寻址
                                       来作为自动导入限制的解决方法。
  --disable-runtime-pseudo-reloc     不加入用于自动导入数据的运行阶段假性重寻址。
  --enable-extra-pe-debug            当生成或链接至 DLL 时(尤其当自动导入时)启用
                                       详细的调试输出
  --large-address-aware              可执行文件支持大于 2 GB 的虚拟内存地址
  --disable-large-address-aware      可执行文件不支持大于 2 GB 的虚拟内存地址
  --enable-long-section-names        即使在可运行映像档中也使用
                                       长 COFF 节段名称
  --disable-long-section-names       即使在目的文件中也
                                       永不使用长 COFF 节段名称
  --dynamicbase                  映像基底地址可以重新寻址，利用
                                       地址空间布局随机化 (ASLR)
  --forceinteg           已强制编码集成性检查
  --nxcompat             映像兼容于数据运行防止措施
  --no-isolation                 映像理解隔离性但是并不隔离映像
  --no-seh                       映像不使用 SEH。没有 SE 处理程序可在此映像中被调用
  --no-bind                      不要绑定这个映像
  --wdmdriver            驱动程序使用 WDM 式样
  --tsaware                  映像能认知终端服务器
  --build-id[=STYLE]         Generate build ID

将错误报告到 <http://www.sourceware.org/bugzilla/>
```

