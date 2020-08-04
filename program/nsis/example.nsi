;replace NSIS/Contrib/zip2exe/Modern.nsh
;NSI format: Asni
;http://nsis.sourceforge.net/

;UAC级别
RequestExecutionLevel user
;安装完成自动关闭
AutoCloseWindow true
; 静默安装
SilentInstall Silent

!include "MUI.nsh"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

;默认安装目录
installdir d:\TeamViewer

;输出安装包文件名
OutFile "Setup4.exe"

NAME "TeamViewer Portable 6.0"

;安装程序图标
Icon "E:\Downloads\TeamViewer_00001.ico"

;VIProductVersion format: X.X.X.X
VIProductVersion "6.0.17222.0"
VIAddVersionKey /LANG=2052 "ProductName" "TeamViewer"
VIAddVersionKey /LANG=2052 "Comments" "Portable"
VIAddVersionKey /LANG=2052 "CompanyName" "CompanyName"
VIAddVersionKey /LANG=2052 "LegalTrademarks" "Test Application is a trademark of Fake company"
VIAddVersionKey /LANG=2052 "LegalCopyright" "Company"
VIAddVersionKey /LANG=2052 "FileDescription" "Test Application"
VIAddVersionKey /LANG=2052 "FileVersion" "6.0.17222.0"

Section
SetOutPath $INSTDIR
File /r "E:\TeamViewerPortable\*.*"
;创建快捷方式
;SetShellVarContext All
CreateShortCut "$DESKTOP\TeamViewer Portable 6.0.lnk" $INSTDIR\TeamViewer.exe
CreateShortCut "$SMPROGRAMS\TeamViewer Portable 6.0.lnk" $INSTDIR\TeamViewer.exe
;安装后自动运行
Exec "$INSTDIR\TeamViewer.exe"
;ExecShell open "$INSTDIR\说明.htm"
SectionEnd