# wine


```
sudo apt-get update
sudo apt-get install wine-devel
```

```
foo@foo-MS-7C67:/tmp$ sudo apt-get install wine-devel
正在读取软件包列表... 完成
正在分析软件包的依赖关系树       
正在读取状态信息... 完成       
有一些软件包无法被安装。如果您用的是 unstable 发行版，这也许是
因为系统无法达到您要求的状态造成的。该版本中可能会有一些您需要的软件
包尚未被创建或是它们已被从新到(Incoming)目录移出。
下列信息可能会对解决问题有所帮助：

下列软件包有未满足的依赖关系：
 wine-devel : 依赖: wine-devel-i386 (= 6.19~bionic-1)
              依赖: wine-devel-amd64 (= 6.19~bionic-1) 但是它将不会被安装
E: 无法修正错误，因为您要求某些软件包保持现状，就是它们破坏了软件包间的依赖关系。
foo@foo-MS-7C67:/tmp$ ^C
```

## crossover

