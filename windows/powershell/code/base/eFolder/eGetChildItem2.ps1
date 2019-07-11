dir  \\192.168.0.8\\软件

get-help Get-Children -examples
 -----------
"在默认显示中，将列出文件的模式（属性）、上次写入时间、文件大小（长度）和名称。模式的有效值为 d（目录）、a（存档）、r（只读）、h（隐藏）和 s（系统)"

get-childitem \\192.168.0.8\\软件  -include *.txt -recurse -force

get-childitem \\192.168.23.12\\常用软件  -include *.txt -recurse -force >a.txt
 -----------
    此命令检索当前目录及其子目录中的所有 .txt 文件。Path 参数值中的点 (.)表示当前目录，而 Include 参数指定文件扩展名。Recurs
    e 参数指示 Windows PowerShell 递归检索对象，并指示该命令的执行对象为指定的目录及其内容。force 参数将隐藏文件添加到显示中。

 C:\PS>get-childitem c:\windows\logs\* -include *.txt -exclude A*	
    说明
    -----------
    此命令列出 Logs 子目录中的 .txt 文件，但名称以字母 A 开头的文件除外。它使用通配符 (*) 以指示 Logs 子目录的内容，而不是目录容
    器。因为此命令未包括 Recurse 参数，所以 Get-ChildItem 不会自动包括目录的内容；您需要指定该内容。

get-childitem \\192.168.0.208\\download   -recurse -force >a.txt

get-childitem \\192.168.0.208\\download  -include *.txt -recurse -force >a.txt
get-childitem \\192.168.0.208\\download  -include *.pdf -recurse -force >>a.txt
get-childitem \\192.168.0.208\\download  -include *.caj -recurse -force >>a.txt

