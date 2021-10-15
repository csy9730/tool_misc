# Sandboxie

-  /elevate 可以提升成管理员admin权限
-  /box 可以指定box
-  /env 可以传递环境变量



``` bash
"E:\Program Files\Sandboxie-Plus\Start.exe" C:\Windows\System32\calc.exe

"E:\Program Files\Sandboxie-Plus\Start.exe" /box:DefaultBox calc.exe

"E:\Program Files\Sandboxie-Plus\Start.exe" start_menu
"E:\Program Files\Sandboxie-Plus\Start.exe" run_dialog

 "C:\Program Files\Sandboxie\Start.exe"  /env:VariableName="Variable Value With Spaces" 

# The parameter _/hidewindow can be used to signal that the starting program should not display its window:
"C:\Program Files\Sandboxie\Start.exe"  /hide_window cmd.exe /c automated_script.bat   
```

> The parameter /silent can be used to eliminate some pop-up error messages. For example:
```
  "C:\Program Files\Sandboxie\Start.exe"  /silent  no_such_program.exe
```

> List the system process ID numbers for all programs running in a particular sandbox.
```
  "C:\Program Files\Sandboxie\Start.exe"  /listpids
  ```

> Terminate all programs running in a particular sandbox. Note that the request is transmitted to the Sandboxie service SbieSvc, which actually carries out the termination.
```
 "C:\Program Files\Sandboxie\Start.exe"  /box:TestBox  /terminate
```

## example
经过测试，sandboxie支持微信，企业微信，wps，百度网盘，不支持qq。

```
"E:\Program Files\Sandboxie-Plus\Start.exe" /box:ClosedBox "E:\Program Files\Sandboxie-Plus\sandbox_data\DefaultBox\drive\E\Program Files\WPS Office\10.1.0.7520\office6\wps.exe"

"E:\Program Files\Sandboxie-Plus\Start.exe" /box:ClosedBox E:\Program Files (x86)\pscs5_grjj\Photoshop.exe

"E:\Program Files\Sandboxie-Plus\Start.exe" /box:Box2 E:\Program Files\Sandboxie-Plus\sandbox_data\Box2\drive\C\Program Files (x86)\WXWork\WXWork.exe

"E:\Program Files\Sandboxie-Plus\Start.exe" C:\Users\admin\AppData\Roaming\baidu\BaiduNetdisk\baidunetdisk.exe
```

## misc
[https://sandboxie-plus.com/sandboxie/startcommandline/](https://sandboxie-plus.com/sandboxie/startcommandline/)

### Start 启动calc失败
UWP 程序就别用 sandboxie 了

本身 uwp 限制就很多，可以不用沙盒限制。
### 请问如何在沙盒运行QQ
[请问如何在沙盒运行QQ](http://jump2.bdimg.com/p/7195787942)


