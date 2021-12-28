# OpenCppCoverage

OpenCppCoverage是基于Windows下的Visual Studio的一个开源代码覆盖工具，主要用途是得到单元测试的覆盖率。
## install

### exe
打开[OpenCppCoverage](https://github.com/OpenCppCoverage/OpenCppCoverage/releases)，安装OpenCppCoverageSetup-x86-0.9.5.2.exe 默认下一步安装
### vsix
可以在Visual Studio软件中直接通过 扩展 -> 管理扩展 -> 搜索OpenCppCoverage下载，但是速度巨慢无比，一般推荐在官网直接下载：OpenCppCoverage Plugin - Visual Studio Marketplace（一般来说都可以下载，如果不行可以更换网络环境再尝试），[https://marketplace.visualstudio.com/_apis/public/gallery/publishers/OpenCppCoverage/vsextensions/OpenCppCoveragePlugin/0.9.7.1/vspackage](https://marketplace.visualstudio.com/_apis/public/gallery/publishers/OpenCppCoverage/vsextensions/OpenCppCoveragePlugin/0.9.7.1/vspackage)。下载后得到vsix文件
[OpenCppCoverage](https://opencppcoverage.gallerycdn.vsassets.io/extensions/opencppcoverage/opencppcoverageplugin/0.9.7.1/1581265346391/OpenCppCoverage-0.9.7.1.vsix)

然后安装OpenCppCoverage-0.9.1.1.vsix，这是一个VS的插件。

接双击运行，选择对应的VS版本即可安装完成。
安装完成后重启VS，可以在工具栏中看到“运行OpenCppCoverage”和“OpenCppCoverage设置”两个功能。

两者安装完成以后打开VS的工具菜单可以看到：


## demo

### cmd

``` cmd
OpenCppCoverage –sources D:\QT\qt_test_vs –export_type=binary — D:\QT\qt_test_vs\debug\tst_qt_test_vstest.exe

OpenCppCoverage –sources D:\QT\qt_test_vs –export_type=html — D:\QT\qt_test_vs\debug\tst_qt_test_vstest.exe

OpenCppCoverage –sources D:\QT\qt_test_vs –export_type=cobertura — D:\QT\qt_test_vs\debug\tst_qt_test_vstest.exe
```

-- exePath 指定测试的exe文件
–sources D:\QT\qt_test_vs指向项目所在路径，这个路径下应该包含.cpp .h文件等

–export_type=XXX 为报表显示类型，上述三行代码分别是二进制报表、html报表、cobertura的xml报表。若不写默认为html。

最后路径指向被测程序exe文件。

若为html类型报表结果如下：