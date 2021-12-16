# vcpkg

[https://github.com/microsoft/vcpkg](https://github.com/microsoft/vcpkg)

vcpkg 是windows下的包管理工具
windows系统：使用的时候只需要在vcpkg的安装目录下运行terminal，然后用：
`vcpkg install [name]`, 便可以方便地安装各种c++库啦，使用起来和anaconda感觉很像。


## install
首先，请下载vcpkg并执行 bootstrap.bat 脚本。
它可以安装在任何地方，但是通常我们建议您使用 vcpkg 作为 CMake 项目的子模块，并将其全局安装到 Visual Studio 项目中。
我们建议您使用例如 `C:\src\vcpkg` 或 `C:\dev\vcpkg` 的安装目录，否则您可能遇到某些库构建系统的路径问题。
```cmd
> git clone https://github.com/microsoft/vcpkg
> .\vcpkg\bootstrap-vcpkg.bat
```


另外，vcpkg默认安装32位的包，为了让它安装64位的包，可以添加系统环境变量：
`set VCPKG_DEFAULT_TRIPLET=x64-windows`，默认是x86架构：`set VCPKG_DEFAULT_TRIPLET=x86-windows`

### VS

若您希望在 Visual Studio 中使用vcpkg，请运行以下命令 (首次启动需要管理员权限)

```cmd
> .\vcpkg\vcpkg integrate install
```
### cmake

为了在IDE以外在cmake中使用vcpkg，您需要使用以下工具链文件:

```cmd
> cmake -B [build directory] -S . -DCMAKE_TOOLCHAIN_FILE=[path to vcpkg]/scripts/buildsystems/vcpkg.cmake
> cmake --build [build directory]
```
## arch

### files
```
buildtrees/
    protobuf/
        x86-windows-rel/
        x86-windows-dbg/
        x64-windows-rel/
        x64-windows-dbg/
docs/
downloads/
installed/
    vcpkg/
    x64-windows/
        bin/*.dll
        include/
        debug/
        lib/
        tools/
    x86-windows/
scripts/
toolsrc/
packages/
    7zip_x86-windows/
        bin/
        include/
        debug/
        lib/
        tools/
ports/ 
    protobuf/ 
        portfile.cmake
triplets/
    community/*.cmake
    x64-windows.cmake
    x86-windows.cmake
    x64-linux.cmake
bootstrap-vcpkg.bat
bootstrap-vcpkg.sh
README.md
README_es.md
README_fr.md
README_zh_CN.md
CHANGELOG.md
CONTRIBUTING.md

vcpkg.exe
LICENSE.txt
NOTICE.txt
```

- ports 包含上千个库的描述信息，cmake相关信息。
- buildtrees 本地的编译文件？
- packages 包含包文件夹，次级目录是包名+cpu架构，次次级目录是bin，lib。
- installed 包含包文件夹, 次级目录是cpu架构（例如x64-windows），次次级目录是bin，lib。


packages和installed文件夹有什么区别？
目录结构不同。


## demo

### vcpkg search 
```
H:\Project\tmp\vcpkg>vcpkg  search 7zip
7zip                 19.00#2          Library for archiving file with a high compression ratio.

If your library is not listed, please open an issue at and/or consider making a pull request:
    https://github.com/Microsoft/vcpkg/issues
```

### vcpkg install

#### vcpkg install 7zip
```
H:\Project\tmp\vcpkg>vcpkg install 7zip
Your feedback is important to improve Vcpkg! Please take 3 minutes to complete our survey by running: vcpkg contact --su
rvey
Computing installation plan...
The following packages will be built and installed:
    7zip[core]:x86-windows
Detecting compiler hash for triplet x86-windows...
A suitable version of git was not found (required v2.26.2). Downloading portable git v2.26.2...
Downloading git...
  https://github.com/git-for-windows/git/releases/download/v2.26.2.windows.1/PortableGit-2.26.2-32-bit.7z.exe -> H:\Proj
ect\tmp\vcpkg\downloads\PortableGit-2.26.2-32-bit.7z.exe
Extracting git...
A suitable version of 7zip was not found (required v18.1.0). Downloading portable 7zip v18.1.0...
Extracting 7zip...
A suitable version of nuget was not found (required v5.5.1). Downloading portable nuget v5.5.1...
Downloading nuget...
  https://dist.nuget.org/win-x86-commandline/v5.5.1/nuget.exe -> H:\Project\tmp\vcpkg\downloads\22ea847d-nuget.exe
A suitable version of powershell-core was not found (required v7.0.3). Downloading portable powershell-core v7.0.3...
Downloading powershell-core...
  https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/PowerShell-7.0.3-win-x86.zip -> H:\Project\tmp\vcpkg
\downloads\PowerShell-7.0.3-win-x86.zip
Extracting powershell-core...
Starting package 1/1: 7zip:x86-windows
Building package 7zip[core]:x86-windows...
Could not locate cached archive: C:\Users\admin\AppData\Local\vcpkg\archives\5d\5dc2397d7a28d0f7a4d6666bf3352d03eab45630
.zip
-- Downloading https://www.7-zip.org/a/7z1900-src.7z...
-- Extracting source H:/Project/tmp/vcpkg/downloads/7z1900-src.7z
-- Using source at H:/Project/tmp/vcpkg/buildtrees/7zip/src/19.00-d6071f9706.clean
-- Configuring x86-windows
-- Building x86-windows-dbg
-- Building x86-windows-rel
-- Warning: Could not find a matching pdb file for:
    H:/Project/tmp/vcpkg/packages/7zip_x86-windows/bin/7zip.dll
    H:/Project/tmp/vcpkg/packages/7zip_x86-windows/debug/bin/7zip.dll

-- Installing: H:/Project/tmp/vcpkg/packages/7zip_x86-windows/share/7zip/copyright
-- Performing post-build validation
-- Performing post-build validation done
Stored binary cache: C:\Users\admin\AppData\Local\vcpkg\archives\5d\5dc2397d7a28d0f7a4d6666bf3352d03eab45630.zip
Building package 7zip[core]:x86-windows... done
Installing package 7zip[core]:x86-windows...
Installing package 7zip[core]:x86-windows... done
Elapsed time for package 7zip:x86-windows: 1.24 min

Total elapsed time: 2.526 min

The package 7zip:x86-windows provides CMake targets:

    find_package(7zip CONFIG REQUIRED)
    target_link_libraries(main PRIVATE 7zip::7zip)

```
#### vcpkg install curl:x64-windows
```

```


### vcpkg list
```

H:\Project\tmp\vcpkg>
H:\Project\tmp\vcpkg>vcpkg list
7zip:x86-windows                                   19.00#2          Library for archiving file with a high compressi...
```

## help

```
# vcpkg
Commands:
  vcpkg search [pat]              Search for packages available to be built
  vcpkg install <pkg>...          Install a package
  vcpkg remove <pkg>...           Uninstall a package
  vcpkg remove --outdated         Uninstall all out-of-date packages
  vcpkg list                      List installed packages
  vcpkg update                    Display list of packages for updating
  vcpkg upgrade                   Rebuild all outdated packages
  vcpkg x-history <pkg>           (Experimental) Shows the history of CONTROL versions of a package
  vcpkg hash <file> [alg]         Hash a file by specific algorithm, default SHA512
  vcpkg help topics               Display the list of help topics
  vcpkg help <topic>              Display help for a specific topic

  vcpkg integrate install         Make installed packages available user-wide. Requires admin
                                  privileges on first use
  vcpkg integrate remove          Remove user-wide integration
  vcpkg integrate project         Generate a referencing nuget package for individual VS project use
  vcpkg integrate powershell      Enable PowerShell tab-completion

  vcpkg export <pkg>... [opt]...  Exports a package
  vcpkg edit <pkg>                Open up a port for editing (uses %EDITOR%, default 'code')
  vcpkg import <pkg>              Import a pre-built library
  vcpkg create <pkg> <url> [archivename]
                                  Create a new package
  vcpkg owns <pat>                Search for files in installed packages
  vcpkg depend-info <pkg>...      Display a list of dependencies for packages
  vcpkg env                       Creates a clean shell environment for development or compiling
  vcpkg version                   Display version information
  vcpkg contact                   Display contact information to send feedback

Options:
  --triplet=<t>                   Specify the target architecture triplet. See 'vcpkg help triplet'
                                  (default: %VCPKG_DEFAULT_TRIPLET%)
  --overlay-ports=<path>          Specify directories to be used when searching for ports
                                  (also: %VCPKG_OVERLAY_PORTS%)
  --overlay-triplets=<path>       Specify directories containing triplets files
                                  (also: %VCPKG_OVERLAY_TRIPLETS%)
  --binarysource=<path>           Add sources for binary caching. See 'vcpkg help binarycaching'
  --downloads-root=<path>         Specify the downloads root directory
                                  (default: %VCPKG_DOWNLOADS%)
  --vcpkg-root=<path>             Specify the vcpkg root directory
                                  (default: %VCPKG_ROOT%)
  --x-buildtrees-root=<path>      (Experimental) Specify the buildtrees root directory
  --x-install-root=<path>         (Experimental) Specify the install root directory
  --x-packages-root=<path>        (Experimental) Specify the packages root directory
  --x-scripts-root=<path>         (Experimental) Specify the scripts root directory
  --x-json                        (Experimental) Request JSON output

  @response_file                  Specify a response file to provide additional parameters

For more help (including examples) see the accompanying README.md and docs folder.
```

