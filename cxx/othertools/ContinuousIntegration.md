# Continuous integration

互联网软件的开发和发布，已经形成了一套标准流程，最重要的组成部分就是持续集成（Continuous integration，简称CI）
与持续集成相关的，还有两个概念，分别是持续交付和持续部署。


CI系统对个人来说反而降低效率，只有对团队开发才有意义，而且要比较大点的团队，我觉得起码10人以上吧，否则指定个人手工做也不费事。

持续集成包括： 
1. 安装依赖
2. 自动代码检查
3. 分支管理 git
4. 自动编译构建 build
5. 自动运行测试，coverage
6. 自动部署
7. 其他web事件钩子hook
8. 全局变量定于（常用于账户密钥相关）

## version
版本管理工具，常用的是svn和git
### git
### svn
## build
### makefile
### sc

### cmake

## unittest&coverage&lint

包括lint工具，单元测试框架和覆盖率扫描工具，mock工具。


### lint工具
#### pc-lint
#### SourceMonitor

### unittest

#### gtest&gmock

#### ctest
cmake,ctest,cpack,cdash

#### python-unittest
#### python-pytest

#### qtest
### coverage

#### OpenCppCoverage
[https://github.com/OpenCppCoverage/OpenCppCoverage/releases](OpenCppCoverage)
#### lcov

## deploy

## CI
### gitlab-runer

### travis CI

### jenkins

### Appveyor