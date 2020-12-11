# [NSIS：安装、卸载时检查程序是否正在运行](https://www.cnblogs.com/z5337/p/4766415.html)

原文链接 <http://www.flighty.cn/html/bushu/20110402_115.html>

 

如果我们要安装或升级的程序正在运行，文件肯定会替换失败，以下代码可以提示用户结束正在运行的程序。

需要使用插件FindProcDLL.dll，下载路径：http://nsis.sourceforge.net/FindProcDLL_plug-in
 

<http://files.cnblogs.com/files/z5337/FindProc.zip>

<http://files.cnblogs.com/files/z5337/KillProcDll%26FindProcDll.zip>

 

开始安装时检查flighty.exe是否正在运行：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
Function .onInit
  ;关闭进程
  Push $R0
  CheckProc:
    Push "flighty.exe"
    ProcessWork::existsprocess
    Pop $R0
    IntCmp $R0 0 Done
    MessageBox MB_OKCANCEL|MB_ICONSTOP "安装程序检测到 ${PRODUCT_NAME} 正在运行。$\r$\n$\r$\n点击 “确定” 强制关闭${PRODUCT_NAME}，继续安装。$\r$\n点击 “取消” 退出安装程序。" IDCANCEL Exit
    Push "flighty.exe"
    Processwork::KillProcess
    Sleep 1000
    Goto CheckProc
    Exit:
    Abort
    Done:
    Pop $R0
FunctionEnd
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

开始卸载时检查flighty.exe是否正在运行：

 

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
  ;检测程序是否运行
  FindProcDLL::FindProc "flighty.exe"
   Pop $R0
   IntCmp $R0 1 0 no_run
   MessageBox MB_ICONSTOP "卸载程序检测到 ${PRODUCT_NAME} 正在运行，请关闭之后再卸载！"
   Quit
   no_run:
FunctionEnd
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

顺便提一句：如果你的程序被360误杀过，可以用这个提示用户关闭360才可以进行安装。

 