Option Explicit 

Dim WshShell 
Dim oExcel, oBook, oModule 
Dim strRegKey, strCode, x, y 
Set oExcel = CreateObject("Excel.Application") '创建 Excel 对象 

set WshShell = CreateObject("wscript.Shell") 

strRegKey = "HKEY_CURRENT_USER\Software\Microsoft\Office\$\Excel\Security\AccessVBOM" 
strRegKey = Replace(strRegKey, "$", oExcel.Version) 

WshShell.RegWrite strRegKey, 1, "REG_DWORD" 

Set oBook = oExcel.Workbooks.Add '添加工作簿 
Set oModule = obook.VBProject.VBComponents.Add(1) '添加模块 
strCode = _ 
"'Author: Demon" & vbCrLf & _ 
"'Website: http://demon.tw" & vbCrLf & _ 
"'Date: 2011/5/10" & vbCrLf & _ 

"Private Type POINTAPI : X As Long : Y As Long : End Type" & vbCrLf & _ 
"Private Declare Function SetCursorPos Lib ""user32"" (ByVal x As Long, ByVal y As Long) As Long" & vbCrLf & _ 

"Private Declare Function GetCursorPos Lib ""user32"" (lpPoint As POINTAPI) As Long" & vbCrLf & _ 
"Private Declare Sub mouse_event Lib ""user32"" Alias ""mouse_event"" (ByVal dwFlags As Long, ByVal dx As Long, ByVal dy As Long, ByVal cButtons As Long, ByVal dwExtraInfo As Long)" & vbCrLf & _ 

"Public Function GetXCursorPos() As Long" & vbCrLf & _ 
"Dim pt As POINTAPI : GetCursorPos pt : GetXCursorPos = pt.X" & vbCrLf & _ 
"End Function" & vbCrLf & _ 

"Public Function GetYCursorPos() As Long" & vbCrLf & _ 
"Dim pt As POINTAPI: GetCursorPos pt : GetYCursorPos = pt.Y" & vbCrLf & _ 
"End Function" 

oModule.CodeModule.AddFromString strCode '在模块中添加 VBA 代码 
'Author: Demon 
'Website: http://demon.tw 
'Date: 2011/5/10 
x = oExcel.Run("GetXCursorPos") '获取鼠标 X 坐标 
y = oExcel.Run("GetYCursorPos") '获取鼠标 Y 坐标 

WScript.Echo x, y 
oExcel.Run "SetCursorPos", 30, 30 '设置鼠标 X Y 坐标 
Const MOUSEEVENTF_MOVE = &H1 
Const MOUSEEVENTF_LEFTDOWN = &H2 

Const MOUSEEVENTF_LEFTUP = &H4 
Const MOUSEEVENTF_RIGHTDOWN = &H8 
Const MOUSEEVENTF_RIGHTUP = &H10 
Const MOUSEEVENTF_MIDDLEDOWN = &H20 
Const MOUSEEVENTF_MIDDLEUP = &H40 

Const MOUSEEVENTF_ABSOLUTE = &H8000 
'模拟鼠标左键单击 
oExcel.Run "mouse_event", MOUSEEVENTF_LEFTDOWN + MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 

'模拟鼠标左键双击（即快速的两次单击） 
oExcel.Run "mouse_event", MOUSEEVENTF_LEFTDOWN + MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 
oExcel.Run "mouse_event", MOUSEEVENTF_LEFTDOWN + MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 

'模拟鼠标右键单击 
oExcel.Run "mouse_event", MOUSEEVENTF_RIGHTDOWN + MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0 
'模拟鼠标中键单击 
oExcel.Run "mouse_event", MOUSEEVENTF_MIDDLEDOWN + MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0 

'关闭 Excel 
oExcel.DisplayAlerts = False 
oBook.Close 
oExcel.Quit 