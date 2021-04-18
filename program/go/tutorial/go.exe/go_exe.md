# go

## install

[https://golang.org/dl/](https://golang.org/dl/)

### windows
Windows 系统下安装
Windows 下可以使用 .msi 后缀(在下载列表中可以找到该文件，如go1.4.2.windows-amd64.msi)的安装包来安装。

默认情况下 .msi 文件会安装在 c:\Go 目录下。你可以将 c:\Go\bin 目录添加到 Path 环境变量中。添加后你需要重启命令窗口才能生效。
### run test

```
$ H:\project>go version
go version go1.15.3 windows/amd64
```
### 环境变量配置

``` bash
GOPATH=~\go
export GOPROXY=https://goproxy.io # 也可以设置为 https://goproxy.cn 或者其他
export GOPRIVATE=git.xxx.com
```
## arch

### directory

C:\programdata\Go 目录下
```
bin/
    - go.exe
    - gofmt.exe
src/  标准库
    - os/
        - dir.go
api/
lib/
pkg/
doc/
test/
```

## demo
``` go
package main

import "fmt"

func main() {
   fmt.Println("Hello, World!")
}
```

## help

```

H:\project>go --help
Go is a tool for managing Go source code.

Usage:

        go <command> [arguments]

The commands are:

        bug         start a bug report
        build       compile packages and dependencies
        clean       remove object files and cached files
        doc         show documentation for package or symbol
        env         print Go environment information
        fix         update packages to use new APIs
        fmt         gofmt (reformat) package sources
        generate    generate Go files by processing source
        get         add dependencies to current module and install them
        install     compile and install packages and dependencies
        list        list packages or modules
        mod         module maintenance
        run         compile and run Go program
        test        test packages
        tool        run specified go tool
        version     print Go version
        vet         report likely mistakes in packages

Use "go help <command>" for more information about a command.

Additional help topics:

        buildconstraint build constraints
        buildmode       build modes
        c               calling between Go and C
        cache           build and test caching
        environment     environment variables
        filetype        file types
        go.mod          the go.mod file
        gopath          GOPATH environment variable
        gopath-get      legacy GOPATH go get
        goproxy         module proxy protocol
        importpath      import path syntax
        modules         modules, module versions, and more
        module-get      module-aware go get
        module-auth     module authentication using go.sum
        module-private  module configuration for non-public modules
        packages        package lists and patterns
        testflag        testing flags
        testfunc        testing functions

Use "go help <topic>" for more information about that topic.
```
