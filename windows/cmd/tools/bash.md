# bash 

bash是linux环境的壳程序，对应脚本叫做bash脚本。

windows下有多种方法可以模拟bash环境，常见的方法有

* msys2 和minw32
* cygwin

此外还可以通过虚拟机运行linux系统

可以通过，virtualBox，vmware，hyper-V

安装了msys环境后，可以通过cmd调用bash（此时是系统编码GBK），也可以直接调用bash（此时是utf-8编码）
linux默认的编码方式为utf-8。windows默认的编码方式为GBK，在windows下编辑的中文，在linux中会显示为乱码，修改linux的默认编码方式为GBK,就可以解决乱码问题。
方法：
`vim /etc/profile`
在文件末尾写入
```
export LC_ALL="zh_CN.GBK"
export LANG="zh_CN.GBK"
```
wq后执行source /etc/profile 使配置文件生效

