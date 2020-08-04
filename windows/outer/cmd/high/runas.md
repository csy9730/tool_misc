# runas




cmd 提权  runas


第一种方法 (最爽,但是被运行的命令会被当成新进程运行,运行完成后就自动关闭了.)
把以下代码复制到记事本中保存为sudo.vbs 然后移动到PATH任意目录中,如windows system32 等.或自定义目录也可以.
使用的时候 就想linux 中一样. sudo dir

在cmd里面提权可以用runas
在powershell里面可以用Start-Process,参数用 -Credential $PSCredential或-Verb RunAs

bypass 