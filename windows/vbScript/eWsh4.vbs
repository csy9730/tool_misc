'***********************************************************************


' 代码开始

'***********************************************************************

Set mouse=New SetMouse

mouse.getpos x,y ''获得鼠标当前位置坐标

MsgBox x & " " & y


mouse.move 60,14 '把鼠标移动到坐标
WScript.Sleep 200
mouse.clik "dbclick" 
'左击' "right" 右击， "middle" 中间键点击

 

'*****************将以下代码加入到vbs文件末就能如以上方法调用*******************************************************************************************

 

'****************************************************************************************************************************************************

Class SetMouse
private S
private xls, wbk, module1
private reg_key, xls_code, x, y


Private Sub Class_Initialize()
Set xls = CreateObject("Excel.Application") 
Set S = CreateObject("wscript.Shell")
'vbs 完全控制excel
reg_key = "HKEY_CURRENT_USER\Software\Microsoft\Office\$\Excel\Security\AccessVBOM"
reg_key = Replace(reg_key, "$", xls.Version)
S.RegWrite reg_key, 1, "REG_DWORD"
'model 代码
xls_code = _
"Private Type POINTAPI : X As Long : Y As Long : End Type" & vbCrLf & _
"Private Declare Function SetCursorPos Lib ""user32"" (ByVal x As Long, ByVal y As Long) As Long" & vbCrLf & _
"Private Declare Function GetCursorPos Lib ""user32"" (lpPoint As POINTAPI) As Long" & vbCrLf & _
"Private Declare Sub mouse_event Lib ""user32"" Alias ""mouse_event"" " _
& "(ByVal dwFlags As Long, ByVal dx As Long, ByVal dy As Long, ByVal cButtons As Long, ByVal dwExtraInfo As Long)" & vbCrLf & _
"Public Function getx() As Long" & vbCrLf & _
"Dim pt As POINTAPI : GetCursorPos pt : getx = pt.X" & vbCrLf & _
"End Function" & vbCrLf & _
"Public Function gety() As Long" & vbCrLf & _
"Dim pt As POINTAPI: GetCursorPos pt : gety = pt.Y" & vbCrLf & _
"End Function"
Set wbk = xls.Workbooks.Add 
Set module1 = wbk.VBProject.VBComponents.Add(1)
module1.CodeModule.AddFromString xls_code 
End Sub


'关闭
Private Sub Class_Terminate
xls.DisplayAlerts = False
wbk.Close
xls.Quit
End Sub

'可调用过程


Public Sub getpos( x, y) 
x = xls.Run("getx") 
y = xls.Run("gety") 
End Sub


Public Sub move(x,y)
xls.Run "SetCursorPos", x, y
End Sub

 

Public Sub clik(keydown)
Select Case UCase(keydown)
Case "LEFT"
xls.Run "mouse_event", &H2 + &H4, 0, 0, 0, 0
Case "RIGHT"
xls.Run "mouse_event", &H8 + &H10, 0, 0, 0, 0
Case "MIDDLE"
xls.Run "mouse_event", &H20 + &H40, 0, 0, 0, 0
Case "DBCLICK"
xls.Run "mouse_event", &H2 + &H4, 0, 0, 0, 0
xls.Run "mouse_event", &H2 + &H4, 0, 0, 0, 0
End Select
End Sub


End Class

 


'***********************************************************************


'代码结束

'***********************************************************************



'****************************************************************************************************************************************************