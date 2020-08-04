# nsis

下面来说明一下代码。

首先，在NSIS中，以;和#开头的，为注释，相当于//和/**/。

第二，NSIS支持宏定义。

第三，每一个脚本中必须包含一个Section和SectionEnd。Section表示开始起点，SectionEnd表示过程运行结束。

第四，每一个脚本中必须包含一个OutFile。OutFile用于输出打包好的安装程序。

第五，要把所有需要打包的文件放到一个目录里面