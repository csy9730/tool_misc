# 解决vcpkg编译curl出错

[叶迎宪](https://www.jianshu.com/u/a872ecba5193)关注

2018.08.15 20:05:08字数 241阅读 2,898

今天想用vcpkg装一个libcurl的开发包，使用命令 vcpkg install curl

结果报错

> -- Building x86-windows-rel
> CMake Error at scripts/cmake/vcpkg_build_cmake.cmake:175 (message):
> Command failed: C:/Program Files/CMake/bin/cmake.exe;--build;.;--config;Release;--target;install;--;-v;-j1
> Working Directory: E:/vcpkg-master/buildtrees/curl/x86-windows-rel
> See logs for more information:
> E:\vcpkg-master\buildtrees\curl\install-x86-windows-rel-out.log
>
> Call Stack (most recent call first):
> scripts/cmake/vcpkg_install_cmake.cmake:24 (vcpkg_build_cmake)
> ports/curl/portfile.cmake:97 (vcpkg_install_cmake)
> scripts/ports.cmake:71 (include)
>
> Error: Building package curl:x86-windows failed with: BUILD_FAILED
> Please ensure you're using the latest portfiles with `.\vcpkg update`, then
> submit an issue at <https://github.com/Microsoft/vcpkg/issues> including:
> Package: curl:x86-windows
> Vcpkg version: 0.0.113-nohash

解决办法参考github的
<https://github.com/Microsoft/vcpkg/issues/1833>

需要把Visual Studio改成英文的。更改VS2015语言设置的地方在“工具”--“选项”，“环境”--“区域设置”。改成英文的可能还需要下载一个英文的语言包