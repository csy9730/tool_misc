
installDir "D:\Program Files\example" ;ָ����װĿ¼
Page directory ;���Ŀ¼ѡ��ҳ
Page instfiles ;��Ӱ�װ״̬ҳ 
Section "unzip" ;����"unzip"��ʼ
    writeUninstaller $INSTDIR/uninstaller.exe ;����ж�س���
    SetOutPath "$INSTDIR\"
        File data.7z
        File "tools\*.exe"
        File "tools\*.dll"
    nsexec::exec "7z.exe"
    nsExec::Exec '"7z.exe" x "data.7z" -o"$INSTDIR"'
    Delete "7z.exe"
    Delete "7z.dll"
    Delete "data.7z"
SectionEnd ;����"unzip"����

OutFile setupExample.exe
section "Uninstall" ;����"Uninstall"��ʼ
rmDir /r "$INSTDIR" ;ɾ����װĿ¼
sectionEnd ;����"Uninstall"����