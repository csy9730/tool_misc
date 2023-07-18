# 7zip

7zip支持以下格式：
- 压缩 / 解压缩：7z, XZ, BZIP2, GZIP, TAR, ZIP 和 WIM
- 仅解压缩：ARJ,CAB, CHM, CPIO, CramFS, DEB, DMG, FAT, HFS, ISO, LZH, LZMA, MBR, MSI, NSIS, NTFS, RAR, RPM, SquashFS, UDF, VHD, WIM, XAR, Z

## install
```
sudo apt install p7zip-full
```
## usage

7zip 包括多个子命令，如下表所示

- a : 添加文件到存档中
- l : 列出存档的所有文件
- rn : 重命名存档的文件名
- d : 从存档中删除文件
- e : 解压文件
- x : 完整路径解压文件 
- h : 计算文件的哈希值，默认是CRC32
- i : Show information about supported formats
- t : Test integrity of archive
- b : Benchmark
- u : Update files to archive

### demo


``` bash
7z.exe  a tmp_new.7z tmp # 压缩tmp文件夹, 生成 tmp_new.7z
7z.exe rn  tmp_new.7z tmp tmp2 # 从压缩文件中重命名文件夹
7z.exe d tmp_new.7z tmp/*.bat # 从压缩文件中删除文件
7z a  -x deploy\*.bat deploy.7z deploy # 打包文件，并且排除*.bat文件
7z x deploy.7z # 解压到当前文件夹之下
7z x deploy.7z -oFoo # 解压到Foo文件夹之下，Foo文件夹不存在就创建Foo文件夹
```
## help
``` 
$ 7zip --help
7-Zip 19.00 (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2019-02-21

Usage: 7z <command> [<switches>...] <archive_name> [<file_names>...] [@listfile]

<Commands>
  a : Add files to archive
  b : Benchmark
  d : Delete files from archive
  e : Extract files from archive (without using directory names)
  h : Calculate hash values for files
  i : Show information about supported formats
  l : List contents of archive
  rn : Rename files in archive
  t : Test integrity of archive
  u : Update files to archive
  x : eXtract files with full paths

<Switches>
  -- : Stop switches and @listfile parsing
  -ai[r[-|0]]{@listfile|!wildcard} : Include archives
  -ax[r[-|0]]{@listfile|!wildcard} : eXclude archives
  -ao{a|s|t|u} : set Overwrite mode
  -an : disable archive_name field
  -bb[0-3] : set output log level
  -bd : disable progress indicator
  -bs{o|e|p}{0|1|2} : set output stream for output/error/progress line
  -bt : show execution time statistics
  -i[r[-|0]]{@listfile|!wildcard} : Include filenames
  -m{Parameters} : set compression Method
    -mmt[N] : set number of CPU threads
    -mx[N] : set compression level: -mx1 (fastest) ... -mx9 (ultra)
  -o{Directory} : set Output directory
  -p{Password} : set Password
  -r[-|0] : Recurse subdirectories
  -sa{a|e|s} : set Archive name mode
  -scc{UTF-8|WIN|DOS} : set charset for for console input/output
  -scs{UTF-8|UTF-16LE|UTF-16BE|WIN|DOS|{id}} : set charset for list files
  -scrc[CRC32|CRC64|SHA1|SHA256|*] : set hash function for x, e, h commands
  -sdel : delete files after compression
  -seml[.] : send archive by email
  -sfx[{name}] : Create SFX archive
  -si[{name}] : read data from stdin
  -slp : set Large Pages mode
  -slt : show technical information for l (List) command
  -snh : store hard links as links
  -snl : store symbolic links as links
  -sni : store NT security information
  -sns[-] : store NTFS alternate streams
  -so : write data to stdout
  -spd : disable wildcard matching for file names
  -spe : eliminate duplication of root folder for extract command
  -spf : use fully qualified file paths
  -ssc[-] : set sensitive case mode
  -sse : stop archive creating, if it can't open some input file
  -ssw : compress shared files
  -stl : set archive timestamp from the most recently modified file
  -stm{HexMask} : set CPU thread affinity mask (hexadecimal number)
  -stx{Type} : exclude archive type
  -t{Type} : Set type of archive
  -u[-][p#][q#][r#][x#][y#][z#][!newArchiveName] : Update options
  -v{Size}[b|k|m|g] : Create volumes
  -w[{path}] : assign Work directory. Empty path means a temporary directory
  -x[r[-|0]]{@listfile|!wildcard} : eXclude filenames
  -y : assume Yes on all queries
  ```

## misc

### 7z 与 exe文件

- 7z可以解压部分exe文件：
- 可以完全解压nsis安装脚本，
- 可以从electron安装程序中分离出更新程序，主程序和依赖dll。
- 可以从electron主程序中分出图标，data，pdata，rdata，text。
- 可以从qt生成程序中分出图标，data，pdata，rdata，text。
- 不能解压pyinstaller打包的程序。