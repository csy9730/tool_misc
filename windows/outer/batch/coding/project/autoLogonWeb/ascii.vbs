
set fso = CreateObject("Scripting.FileSystemObject")
'Files���Ի�ȡ�ļ�����ʱ����CMD�µ�for�����ļ�����ͬ��Bug��
'����ļ����б䶯�����ܻ��ظ����α���
'������ĳ��API��Bug
'�����Ȼ�ȡ�ļ��б���ʹ�ñ���һ��
FileList = ""
for each oFile in fso.GetFolder(".").Files
    if LCase(fso.GetExtensionName(oFile.Path)) = LCase("htm") then
        FileList = FileList & oFile.Path & vbCrLf
    end if
next
Files = Split(FileList, vbCrLf)
for i=0 to UBound(Files)-1 '���һ��Ԫ���ǿյ�
    'U8ToU8Bom Files(i) '���Ҫ����һ����BOM���ļ������ô���
    U8ToAnsi Files(i)
next
function U8ToU8Bom(strFile)
    dim ADOStrm
    Set ADOStrm = CreateObject("ADODB.Stream")
    ADOStrm.Type = 2
    ADOStrm.Mode = 3
    ADOStrm.CharSet = "utf-8"
    ADOStrm.Open
    ADOStrm.LoadFromFile strFile
    ADOStrm.SaveToFile strFile & ".u8.txt", 2
    ADOStrm.Close
    Set ADOStrm = Nothing
end function
function U8ToAnsi(strFile)
    dim ADOStrm
    dim s
    Set ADOStrm = CreateObject("ADODB.Stream")
    ADOStrm.Type = 2
    ADOStrm.Mode = 3
    ADOStrm.CharSet = "utf-8"
    ADOStrm.Open
    ADOStrm.LoadFromFile strFile
    s = ADOStrm.ReadText
    ADOStrm.Position = 0
    ADOStrm.CharSet = "gbk"
    ADOStrm.WriteText s
    ADOStrm.SetEOS
    ADOStrm.SaveToFile strFile & ".ansi.htm", 2
    ADOStrm.Close
    Set ADOStrm = Nothing
end function