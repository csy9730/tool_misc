# nmake


```
H:\Project>"C:\Program Files (x86)\Microsoft
Visual Studio 14.0\VC\bin\amd64\vcvars64.bat"

H:\Project>where nmake
C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64\nmake.exe
```
### help
```
nmake /?
Microsoft (R) 程序维护实用工具 14.00.24210.0 版
版权所有 (C) Microsoft Corporation。  保留所有权利。
用法:     NMAKE @commandfile
	NMAKE [选项] [/f makefile] [/x stderrfile] [macrodefs] [targets]

选项: 

/A 生成所有已计算的目标
/B 如果时间戳相等则生成
/C 取消输出消息
/D 显示生成消息
/E 覆盖 env-var 宏
/ERRORREPORT:{NONE|PROMPT|QUEUE|SEND} 向 Microsoft 报告错误
/G 显示 !include 文件名
/HELP 显示简短的用法消息
/I 忽略命令中的退出代码
/K 遇到错误时继续生成不相关的目标
/N 显示命令但不执行
/NOLOGO 取消显示版权信息
/P 显示 NMAKE 信息
/Q 检查时间戳但不生成
/R 忽略预定义的规则/宏
/S 取消显示已执行的命令
/T 更改时间戳但不生成
/U 转储内联文件
/Y 禁用批处理模式
/? 显示简短用法消息
```