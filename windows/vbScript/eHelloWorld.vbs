Function fMsgBox
	Dim name,msg
	msg="input name"
	name=Inputbox(msg)
	Msgbox name
end function

Function fRunNotepad
	Set objShell = CreateObject("Wscript.Shell")
	objShell.Run "notepad"
end function

Function fSendKeys
	Set objShell = CreateObject("Wscript.Shell")
	WScript.Sleep 3000
	objShell.SendKeys "123"
	objShell.SendKeys "{F5}"
	WScript.Sleep 3000
	objShell.SendKeys "{F5}"	
end function

Function fTmp
	Set objShell = CreateObject("Scripting.FileSystemObject")
	Set objShell = CreateObject("Scripting.Dictionary")
	Set objShell = CreateObject("Wscript.NetWork")
end function

Function fWinDir
	set WshShell = WScript.CreateObject("WScript.Shell")
	strWinDir= WshShell.ExpandEnvironmentStrings("%WinDir%")
	REM msgbox  CreateObject("WScript.Shell").ExpandEnvironmentStrings("%ProgramFiles%")
	REM msgbox  CreateObject("WScript.Shell").ExpandEnvironmentStrings("%CommonProgramFiles%")	
	Msgbox strWinDir
	REM 1、VBS获取系统安装路径
end function

Function fAddShortcut
	REM 4、给桌面添加网址快捷方式
	set gangzi = WScript.CreateObject("WScript.Shell")
	strDesktop= gangzi.SpecialFolders("Desktop")
	set oShellLink = gangzi.CreateShortcut(strDesktop & "/InternetExplorer.lnk")
	oShellLink.TargetPath= "http://www.baidu.com"
	oShellLink.Description= "Internet Explorer"
	oShellLink.IconLocation= "%ProgramFiles%/Internet Explorer/iexplore.exe, 0"
	oShellLink.Save
end function

Function fAddUrl
	REM 5、给收藏夹添加网址
	Const ADMINISTRATIVE_TOOLS = 6
	Set objShell = CreateObject("Shell.Application")
	Set objFolder = objShell.Namespace(ADMINISTRATIVE_TOOLS)
	Set objFolderItem = objFolder.Self   
	Set objShell = WScript.CreateObject("WScript.Shell")
	strDesktopFld= objFolderItem.Path
	Set objURLShortcut = objShell.CreateShortcut(strDesktopFld & "/奋斗Blog.url")
	objURLShortcut.TargetPath= "http://www.baidu.com/"
	objURLShortcut.Save
end function

Function fOpenUrl
	createObject("wscript.shell").run"iexplore http://www.fendou.info/",0
	REM 兼容所有浏览器，使用IE的绝对路径+参数打开，无法用函数得到IE安装路径，只用函数得到了Program Files路径，应该比上面的方法好，但是两种方法都不是绝对的。
	REM Set objws=WScript.CreateObject("wscript.shell")
	REM objws.Run"""C:/Program Files/Internet Explorer/iexplore.exe""www.baidu.com",vbhide
end function
Function fCopyStr0
	strCopy = "68032%7C71179%7C73866%7C37261%7C544%7C64652%7C73299%7C70997%7C73834%7C73393%7C66782%7C71861"  
	Set objIE = CreateObject("InternetExplorer.Application")  
	objIE.Navigate("about:blank")  
	objIE.document.parentwindow.clipboardData.SetData "text", strCopy  
	objIE.Quit
end function
Function fCopyStr
	Dim str
	str="我是csy/qq"
	REM set str="这里是你要复制到剪贴板的字符串"
	Set ws = wscript.createobject("wscript.shell")
	ws.run "mshta vbscript:clipboardData.SetData("+""""+"text"+""""+","+""""&str&""""+")(close)",0,true
	Set objShell = CreateObject("Wscript.Shell")
	objShell.Run "notepad"
	WScript.Sleep 3000
	objShell.SendKeys "^v"
	objShell.SendKeys "%s"
end function

Function fCopyStr2
	set fso=createobject("scripting.filesystemobject")  
	set file=fso.opentextfile("Test.txt")  
	strCopy = file.readall  
	file.close  
	Dim Word  
	Set Word = CreateObject("Word.Application")  
	Word.Documents.Add  
	Word.Selection.Text = strCopy  
	Word.Selection.Copy  
	Word.Quit False 
end function


Function fSendStr
REM 24、QQ自动发消息
On Error Resume Next
	str="我是csy/qq"
	Set WshShell=WScript.CreateObject("WScript.Shell")
	WshShell.run "mshta vbscript:clipboardData.SetData("+""""+"text"+""""+","+""""&str&""""+")(close)",0
	WshShell.run"tencent://message/?Menu=yes&uin=20016964&Site=&Service=200&sigT=2a39fb276d15586e1114e71f7af38e195148b0369a16a40fdad564ce185f72e8de86db22c67ec3c1",0,true
	WScript.Sleep 3000
	WshShell.SendKeys "^v"
	WshShell.SendKeys "%s"
end function


Function fReadSelfName
	REM 28、VBS获取自身文件名
	Set fso = CreateObject("Scripting.FileSystemObject")
	msgbox WScript.ScriptName
end function


Function fReadFile
	REM 29、VBS读取Unicode编码的文件
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objFile = objFSO.OpenTextFile("Test.txt",1,False,-1)
	strText= objFile.ReadAll
	objFile.Close
	Wscript.Echo strText
end function


Function fOpenFile
	REM 30、VBS读取指定编码的文件（默认为uft-8）gangzi变量是要读取文件的路径
	set stm2 =CreateObject("ADODB.Stream")
	stm2.Charset= "utf-8"
	stm2.Open
	stm2.LoadFromFile gangzi
	readfile= stm2.ReadText
	MsgBox readfile
end function
Function fOpenFile2
	REM 38、VBS创建txt文件
	Dimfso,TestFile
	Setfso=CreateObject("Scripting.FileSystemObject")
	SetTestFile=fso.CreateTextFile("C:/hello.txt",Ture)
	TestFile.WriteLine("Hello,World!")
	TestFile.Close
	REM 39、VBS创建文件夹
	Dimfso,fld
	Setfso=CreateObject("Scripting.FileSystemObject")
	Setfld=fso.CreateFolder("C:/newFolder")
	REM 40、VBS判断文件夹是否存在
	Dimfso,fld
	Setfso=CreateObject("Scripting.FileSystemObject")
	If(fso.FolderExists("C:/newFolder")) Then
	msgbox("Folderexists.")
	else
	setfld=fso.CreateFolder("C:/newFolder")
	End If
	REM 41、VBS使用变量判断文件夹
	Dimfso,fld
	drvName="C:/"
	fldName="newFolder"
	Setfso=CreateObject("Scripting.FileSystemObject")
	If(fso.FolderExists(drvName&fldName)) Then
	msgbox("Folderexists.")
	else
	setfld=fso.CreateFolder(drvName&fldName)
	End If
end function

function fConnect
	Dim Wsh
	Set Wsh = WScript.CreateObject("WScript.Shell")
	Wsh.run"Rasdial WideBandConnection S505 20170114",false,1
end function

function fTime
REM 61、VBS时间判断代码
	Digital=time
    hours=Hour(Digital)
    minutes=Minute(Digital)
    seconds=Second(Digital)
    if (hours<6) then
        dn="凌辰了，还没睡啊?"
    end if
    if (hours>=6) then
        dn="早上好！"
    end if
    if (hours>12) then
        dn="下午好！"
    end if
    if (hours>18) then
        dn="晚上好！"
    end if
    if (hours>22) then
        dn="不早了，夜深了，该睡觉了!"
    end if
    if (minutes<=9) then
        minutes="0" & minutes
    end if
    if (seconds<=9) then
        seconds="0" & seconds
    end if
	ctime=hours& ":" & minutes & ":" & seconds &" " & dn
	Msgbox ctime
end function
REM call fRunNotepad
REM call fSendKeys
REM call fWinDir
REM call fAddShortcut
REM call fAddUrl
REM call fOpenUrl
REM call fCopyStr2
call fTime
call fReadSelfName