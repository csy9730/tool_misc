installDir "D:\Program Files\example" ;指定安装目录
;!define EXEDIR "D:\projects\my_lib\tool_misc\MISC\nsis\scripts\exampleNew" ;宏定义EXEDIR的路径
Page directory ;添加目录选择页
Page instfiles ;添加安装状态页
 
Section "unzip" ;过程"unzip"开始
    writeUninstaller $INSTDIR/uninstaller.exe ;生成卸载程序
    SetOutPath "$INSTDIR\"
        File data.7z
        File "tools\*.exe"
        File "tools\*.dll"
    nsexec::exec "7z.exe"
    nsExec::Exec '"7z.exe" x "data.7z" -o"$INSTDIR"'
    Delete "7z.exe"
    Delete "7z.dll"
    Delete "data.7z"
SectionEnd ;过程"unzip"结束
 
OutFile setupExample.exe ;生成文件
 
section "Uninstall" ;过程"Uninstall"开始
rmDir /r "$INSTDIR" ;删除安装目录
sectionEnd ;过程"Uninstall"结束