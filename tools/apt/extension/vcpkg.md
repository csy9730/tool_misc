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
`VCPKG_DEFAULT_TRIPLET=x64-windows`

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

