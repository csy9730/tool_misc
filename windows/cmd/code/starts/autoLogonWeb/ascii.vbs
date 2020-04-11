
set fso = CreateObject("Scripting.FileSystemObject")
'Files属性获取文件集合时，与CMD下的for遍历文件有相同的Bug：
'如果文件名有变动，可能会重复或多次遍历
'看来是某个API的Bug
'所以先获取文件列表再使用保险一点
FileList = ""
for each oFile in fso.GetFolder(".").Files
    if LCase(fso.GetExtensionName(oFile.Path)) = LCase("htm") then
        FileList = FileList & oFile.Path & vbCrLf
    end if
next
Files = Split(FileList, vbCrLf)
for i=0 to UBound(Files)-1 '最后一个元素是空的
    'U8ToU8Bom Files(i) '如果要生成一个有BOM的文件，启用此行
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