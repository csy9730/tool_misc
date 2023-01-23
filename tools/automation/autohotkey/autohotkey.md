# auto hot key

autohotkey 可以为快捷按钮绑定一个脚本功能。

例如快速打开浏览器的指定网页。


https://www.autohotkey.com/


## hot key

;Notes: #==win !==Alt ^==Ctrl  +==shift ::分隔 run AHK命令


## function

## script

;代表注释

## demo
```
;AutoHotkey永久更新:常用技巧分享
;Notes: #==win !==Alt ^==Ctrl  +==shift ::分隔 run AHK命令
;=========================================================================
^+r:: ;reload
reload
sleep 1000
msgbox, 4,, The script could not be reloaded. Would you like to open it for editing?
ifmsgbox, yes, edit
return

^Esc::Pause ; 按一次 ^+Esc 会暂停脚本. 再按一次则取消暂停.

#=:: ;窗口透明化增加或者减弱
    WinGet, ow, id, A
    WinTransplus(ow)
    return

#-:: ;窗口透明化增加或者减弱
    WinGet, ow, id, A
    WinTransMinus(ow)
    return
WinTransplus(w){
 
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent < 255
        transparent := transparent+10
    else
        transparent =
    if transparent
        WinSet, Transparent, %transparent%, ahk_id %w%
    else
        WinSet, Transparent, off, ahk_id %w%
    return
}
WinTransMinus(w){
 
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent
        transparent := transparent-10
    else
        transparent := 240
    WinSet, Transparent, %transparent%, ahk_id %w%
    return
}

$CapsLock::Enter ;将少用的caps Lock键映射为Enter键（这样可以用左手回车）replace CapsLock to LeftEnter; CapsLock = Alt CapsLock
LAlt & Capslock::SetCapsLockState, % GetKeyState("CapsLock", "T") ? "Off" : "On"
;=========================================================================
#enter:: ;最大化窗口
WinGet,S,MinMax,A
if S=0
    WinMaximize,A
else if S=1
    WinRestore,A
else if S=-1
    WinRestore,A
return

!enter:: ;最爱代码之窗口置顶
    WinGet ow, id, A
    WinTopToggle(ow)
    return
WinTopToggle(w) {
 
    WinGetTitle, oTitle, ahk_id %w%
    Winset, AlwaysOnTop, Toggle, ahk_id %w%
    WinGet, ExStyle, ExStyle, ahk_id %w%
    if (ExStyle & 0x8)  ; 0x8 为 WS_EX_TOPMOST.在WinGet的帮助中
        oTop = 置顶
    else
        oTop = 取消置顶
    tooltip %oTitle% %oTop%
    SetTimer, RemoveToolTip, 5000
    return
 
    RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return
}

!x:: ;关闭窗口
send ^w
return

#c:: ;cosea版以管理员身份打开cmd命令行
Run *RunAs cmd ,,max
return

#m:: ;窗口最小化
WinMinimize, A
return

#space::
run https://www.google.com/ncr
tooltip, 以前向往更加辽阔的天空，走了一小圈，发现`n`n无论是平平淡淡，还是轰轰烈烈，都隐藏不住自己内心的那份虚无缥缈！！！
sleep 2000
tooltip,
return

!space:: ;cosea典藏级原创代码之谷歌搜索终极版
run https://www.google.com/search?q=%clipboard% ;用google搜索剪切板的内容
clipboard1=%clipboard%&tbs=qdr:1,sbd:1
run https://www.google.com/search?q=%clipboard1% ;按时间排序
run https://www.google.com/search?q=%clipboard%&tbs=qdr:m ;只显示最近一个月信息
run https://www.google.com/search?q=%clipboard%&tbs=qdr:y ;只显示最近一年信息
run https://www.google.com/search?q=%clipboard%&as_filetype=pdf ;指定PDF文件
run https://www.google.com/search?q=%clipboard%&tbs=li:1 ;精确匹配
run https://www.google.com/search?&as_epq=%clipboard% ;完全匹配
run https://www.google.com/search?q=%clipboard% inurl:gov ;url包括gov的网站信息
run https://www.google.com/search?q=intitle:%clipboard% ;文章标题中包含关键词的结果
run https://www.google.com/search?q=%clipboard%&source=lnt&lr=lang_zh-CN|lang_zh-TW ;&source=lnt&lr=lang_zh-CN|lang_zh-TW，指定中文网页
run https://www.google.com/search?q=%clipboard%&tbm=isch&tbs=imgo:1 ;&tbm=isch指定搜索谷歌图片
run https://www.google.com/search?q=%clipboard%&tbm=isch&tbs=isz:l ;将URL更改为大尺寸图片&tbs=isz:l
run https://image.baidu.com/search/index?z=3&tn=baiduimage&word=%clipboard% ;z=3是大尺寸，z=9是特大尺寸
run https://www.behance.net/search?content=projects&sort=appreciations&time=week&featured_on_behance=true&search=%clipboard%
run https://www.zcool.com.cn/search/content?&word=%clipboard%
clipboard2=%clipboard%&tbm=isch&tbs=qdr:m,isz:l,imgo:1
run https://www.google.com/search?q=%clipboard2% ;为URL添加&tbs=qdr:m，只显示新近一个月内的图片，&tbs=imgo:1，显示图片大小
tooltip, 那晚，风也美，人也美。。。
sleep 1500
tooltip,
return

+space::
run http://fanyi.youdao.com/
tooltip,世界是你们的，也是我们的，但归根结底是你们的！！！
sleep, 3000
tooltip,
return

#n:: ;cosea强行修改版，最常用功能之打开记事本
IfWinNotExist ahk_class Notepad
{
    run notepad,,max
    WinActivate
}
Else IfWinNotActive ahk_class Notepad
{
    WinActivate
    sleep,500
    WinMaximize,A
}
Else
{
    WinMinimize
}
Return

#i::  ;首先显示当前剪切板内容，然后在获取光标坐标并发送到剪切板
msgbox 当前剪切板的内容为：%clipboard%
MouseGetPos, xpos, ypos
clipboard = %xpos%,%ypos%
msgbox, 小海已为你发送光标位置 (X,Y)=%xpos%,%ypos% 到剪切板
return

+k::run,control

+r::run C:\Windows\system32\Taskmgr.exe

^delete::FileRecycleEmpty ;ctrl+del，清空回收站

F1:: ;窗口切换 ALT+TAB
send,!{tab}
return

F6::
IfWinNotExist ahk_class Calculator
{
  Run calc
  WinActivate
}
Else IfWinNotActive ahk_class Calculator
{
  WinActivate
}
Else
{
  WinMinimize
}
return

F7::
Shutdown, 1 ;关机
;Shutdown, 2 ;重启
return

;cosea原创神级代码之清除所有标点符号================================
F2:: ;清除所有标点符号，并换行
run notepad,,max
Loop
{
StringReplace, clipboard, clipboard, `, , `r`n, UseErrorLevel ;清除英文逗号
StringReplace, clipboard, clipboard, ， , `r`n, UseErrorLevel ;清除中文逗号
StringReplace, clipboard, clipboard, `; , `r`n, UseErrorLevel ;清除英文分号
StringReplace, clipboard, clipboard, ； , `r`n, UseErrorLevel ;清除英文分号
StringReplace, clipboard, clipboard, . , `r`n, UseErrorLevel ;清除英文句号
StringReplace, clipboard, clipboard, 。 , `r`n, UseErrorLevel ;清除中文句号
StringReplace, clipboard, clipboard, : , `r`n, UseErrorLevel ;清除英文冒号
StringReplace, clipboard, clipboard, ： , `r`n, UseErrorLevel ;清除中文冒号
StringReplace, clipboard, clipboard, ‘’ , `r`n, UseErrorLevel ;清除中文双引号1
StringReplace, clipboard, clipboard, “ , `r`n, UseErrorLevel ;清除中文双引号2
StringReplace, clipboard, clipboard, ” , `r`n, UseErrorLevel ;清除中文双引号3
StringReplace, clipboard, clipboard, ' , `r`n, UseErrorLevel ;清除英文双引号
StringReplace, clipboard, clipboard, 、 , `r`n, UseErrorLevel ;清除中文顿号
StringReplace, clipboard, clipboard, / , `r`n, UseErrorLevel ;清除右斜杠
StringReplace, clipboard, clipboard, \ , `r`n, UseErrorLevel ;清除左斜杠
StringReplace, clipboard, clipboard, - , `r`n, UseErrorLevel ;清除短横线
StringReplace, clipboard, clipboard, —— , `r`n, UseErrorLevel ;清除长横线
StringReplace, clipboard, clipboard, = , `r`n, UseErrorLevel ;清除等号
StringReplace, clipboard, clipboard, + , `r`n, UseErrorLevel ;清除加号
StringReplace, clipboard, clipboard, （ , `r`n, UseErrorLevel ;清除中文左括号
StringReplace, clipboard, clipboard, ） , `r`n, UseErrorLevel ;清除中文右括号
StringReplace, clipboard, clipboard, ( , `r`n, UseErrorLevel ;清除英文左括号
StringReplace, clipboard, clipboard, ) , `r`n, UseErrorLevel ;清除英文右括号
StringReplace, clipboard, clipboard, 【 , `r`n, UseErrorLevel ;清除中文【
StringReplace, clipboard, clipboard, 】 , `r`n, UseErrorLevel ;清除中文】
StringReplace, clipboard, clipboard, [ , `r`n, UseErrorLevel ;清除[
StringReplace, clipboard, clipboard, ] , `r`n, UseErrorLevel ;清除]
StringReplace, clipboard, clipboard, ! , `r`n, UseErrorLevel ;清除英文感叹号
StringReplace, clipboard, clipboard, ！ , `r`n, UseErrorLevel ;清除中文感叹号
StringReplace, clipboard, clipboard, ？ , `r`n, UseErrorLevel ;清除中文问号
StringReplace, clipboard, clipboard, ? , `r`n, UseErrorLevel ;清除英文问号
StringReplace, clipboard, clipboard, < , `r`n, UseErrorLevel ;清除英文<
StringReplace, clipboard, clipboard, > , `r`n, UseErrorLevel ;清除英文>
StringReplace, clipboard, clipboard, 《 , `r`n, UseErrorLevel ;清除中文《
StringReplace, clipboard, clipboard, 》 , `r`n, UseErrorLevel ;清除英文》
StringReplace, clipboard, clipboard, @ , `r`n, UseErrorLevel ;清除@
StringReplace, clipboard, clipboard, # , `r`n, UseErrorLevel ;清除#
StringReplace, clipboard, clipboard, $ , `r`n, UseErrorLevel ;清除$
StringReplace, clipboard, clipboard, `% , `r`n, UseErrorLevel ;清除%
StringReplace, clipboard, clipboard, ^ , `r`n, UseErrorLevel ;清除^
StringReplace, clipboard, clipboard, & , `r`n, UseErrorLevel ;清除&
StringReplace, clipboard, clipboard, * , `r`n, UseErrorLevel ;清除*
StringReplace, clipboard, clipboard, `` , `r`n, UseErrorLevel ;清除`
StringReplace, clipboard, clipboard, `:: , `r`n, UseErrorLevel ;清除::
StringReplace, clipboard, clipboard, " , `r`n, UseErrorLevel ;清除"
StringReplace, clipboard, clipboard, { , `r`n, UseErrorLevel ;清除{
StringReplace, clipboard, clipboard, }, `r`n, UseErrorLevel ;清除}
StringReplace, clipboard, clipboard, |, `r`n, UseErrorLevel ;清除|
StringReplace, clipboard, clipboard, ·, `r`n, UseErrorLevel ;清除中文···
StringReplace, clipboard, clipboard, ~, `r`n, UseErrorLevel ;清除~
StringReplace, clipboard, clipboard, _ , `r`n, UseErrorLevel ;清除_
    if ErrorLevel = 0  ; 不需要再进行替换.
        break
}
sleep,200
send,^v
return

F8:: ;cosea原创代码之清除Windows中文件名不能包含下列任何字符： \ / : * ? " < > | 
Loop
{
StringReplace, clipboard, clipboard, ? , , UseErrorLevel ;清除英文问号
StringReplace, clipboard, clipboard, * , , UseErrorLevel ;清除*
StringReplace, clipboard, clipboard, : , , UseErrorLevel ;清除英文冒号
StringReplace, clipboard, clipboard, " , , UseErrorLevel ;清除"
StringReplace, clipboard, clipboard, < , , UseErrorLevel ;清除英文<
StringReplace, clipboard, clipboard, > , , UseErrorLevel ;清除英文>
StringReplace, clipboard, clipboard, / , , UseErrorLevel ;清除右斜杠
StringReplace, clipboard, clipboard, \ , , UseErrorLevel ;清除左斜杠
StringReplace, clipboard, clipboard, |, , UseErrorLevel ;清除|
    if ErrorLevel = 0  ; 不需要再进行替换.
        break
}
return

;神级代码之锁定中英文=============================================
;功能：输入法状态提示 ;f3强制中文 f4强制英文小写
;环境：win10+搜狗输入法，输入法状态切换用默认的shift键。
;作者：kazhafeizhale 知乎@oahgnat11
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance force

XButton1::^c
XButton2::^v

F3::
	SetCapsLockState,off
	switchime(0)
	switchime()
return

F4::
	SetCapsLockState,off
	switchime(0)
return

switchime(ime := "A")
{
    if (ime = 1){
        DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,"00000804", UInt, 1))
    }else if (ime = 0)
    {
        DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
    }else if (ime = "A")
    {
        ;ime_status:=DllCall("GetKeyboardLayout","int",0,UInt)
        Send, #{Space}
    }
}
;最钟爱代码之音量随心所欲
;=========================================================
~lbutton & enter:: ;鼠标放在任务栏，滚动滚轮实现音量的加减
exitapp  
~WheelUp::  
if (existclass("ahk_class Shell_TrayWnd")=1)  
Send,{Volume_Up}  
Return  
~WheelDown::  
if (existclass("ahk_class Shell_TrayWnd")=1)  
Send,{Volume_Down}  
Return  
~MButton::  
if (existclass("ahk_class Shell_TrayWnd")=1)  
Send,{Volume_Mute}  
Return  

Existclass(class)  
{  
MouseGetPos,,,win  
WinGet,winid,id,%class%  
if win = %winid%  
Return,1  
Else  
Return,0  
}
;=========================================================
#h:: ;cosea原创代码之隐藏windows系统的桌面图标
send,{AppsKey}
send,v
send,d
return
;=========================================================
#+r:: ;获取RGB色
MouseGetPos, mouseX, mouseY
PixelGetColor, color, %mouseX%, %mouseY%, RGB
StringRight color,color,6
clipboard = %color%
msgbox 当前坐标RGB颜色值的十六进制值为#%color%.
return
;=========================================================
#+c:: ;用快捷键得到当前选中文件的路径
send ^c
sleep,200
clipboard=%clipboard% ;windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了
tooltip,%clipboard% ;提示文本
sleep,500
tooltip,
return
;=========================================================
#+t:: ;小海御用计时器
InputBox, time, 小海御用计时器, 请输入一个时间（单位是秒）
time := time*1000
Sleep,%time%
msgbox 时间到，啊啊啊！！！红红火火！！！恍恍惚惚！！！
return
;=========================================================
#PrintScreen:: ;关闭显示器
Sleep 1000  ; 让用户有机会释放按键 (以防释放它们时再次唤醒显视器).
SendMessage, 0x112, 0xF170, 2,, Program Manager  ; 0x112 为 WM_SYSCOMMAND, 0xF170 为 SC_MONITORPOWER.
return
;=========================================================
;~LButton:: ;左键拖选文字: 复制
cos_mousedrag_treshold := 20 ; pixels
MouseGetPos, cos_mousedrag_x, cos_mousedrag_y
win1 := WinActive("A")
KeyWait LButton
MouseGetPos, cos_mousedrag_x2, cos_mousedrag_y2
win2 := WinActive("A")
WinGetClass cos_class, A
if(((abs(cos_mousedrag_x2 - cos_mousedrag_x) > cos_mousedrag_treshold
  or abs(cos_mousedrag_y2 - cos_mousedrag_y) > cos_mousedrag_treshold)) and win1 = win2 
  and cos_class != "ConsoleWindowClass")
{
	SendInput ^c
}
return

;自动快捷输入高频常用词，小海御用(规则：高频要快不加.）注：优化已完成
;=========================================================
:*:ffmpeg::
clipboard = ffmpeg -i input.mkv output.mp4
send,^v
return

:*:iffmp::
clipboard = ffmpeg -i input.flv output.mp4
send,^v
return

:*:iiffmp::
clipboard = ffmpeg -i input.mp4 -c:v libx264 -crf 24 -preset slower output.mp4
send,^v
return

:*:sffmp::
clipboard = ffmpeg -i input.mp4 -c:v libx264 -crf 24 -s 1280:720 -preset slower output.mp4
send,^v
return

:*:affmp::
clipboard = ffmpeg -i input.mp4 -vn -acodec copy output.aac
send,^v
return

:*:iaffmp::
clipboard = ffmpeg -i input.m4a -vn -acodec copy output.aac
send,^v
return

:*:ggg::
clipboard = Dan Ebberts ;可任意更改剪切板内容
send,^v
return

:*:iid::  ; 此热字串通过后面命令将热字串替换成当前日期和时间.
FormatTime, CurrentDateTime,, MM月dd ; 形式：小海01月17短片
SendInput 小海%CurrentDateTime%短片
return

;小海自动化进阶版，注：待优化
;=========================================================
:*:+110:: ;将多次复制的内容叠加到剪切板
msgbox,请在此条提术语之前确定你已经结束了上一次复制
clipboard = %clipboard%
var = %clipboard% ;新的叠加赋值
clipboard =  ; 让剪贴板初始为空, 这样可以使用 ClipWait 检测文本什么时候被复制到剪贴板中.
send ^c
ClipWait  ; 等待剪贴板中出现新的文本
clipboard = %clipboard%
myvar = %var%`r%clipboard%
clipboard := myvar
return

^i:: ;复制并清除把任何复制的文件, HTML 或其他格式的文本转换为纯文本
clipboard =   ; 清空剪贴板
send,^c
clipboard = %clipboard%   ; 把任何复制的文件, HTML 或其他格式的文本转换为纯文本
return

:*:111:: ;无损删除当前行
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
return

:*:222:: ;无损删除当前向下2行
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
return

:*:333:: ;无损删除当前向下3行
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
return

:*:444:: ;无损删除当前向下4行
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
return

:*:555:: ;无损删除当前向下5行
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
send,{end}{shiftdown}{home}{shiftup}{delete}{delete}
return

:*:777:: ;打开小海脚本
edit ;进入小海脚本并进行编辑
sleep,500
WinMaximize,A ;调用最大化窗口命令
sleep,500
send,^f
return

:*:888:: ;复制当前行到剪切板
send,{home}{shiftdown}{end}{shiftup}
send,^c
clipboard = %clipboard%   ; 把任何复制的文件, HTML 或其他格式的文本转换为纯文本
send, {end}
return

:*:999:: ;粘贴剪切板内容到当前行
clipboard = %clipboard%   ; 把任何复制的文件, HTML 或其他格式的文本转换为纯文本
send,{home}{shiftdown}{end}{shiftup}
send,^v
send, {end}
return

;=========================================================
+!d:: ;同时按下Shift+Alt+d键，自动删除temp tencent wechat cloudmusic等缓存文件
send,#e
sleep,500
WinMaximize,A
sleep,500
FileRemoveDir, C:\Users\hocto\AppData\Local\Temp , 1
FileRemoveDir, C:\Users\hocto\AppData\Local\Netease\CloudMusic\Cache , 1
FileRemoveDir, C:\Users\hocto\AppData\Roaming\Tencent , 1
tooltip,接下来，小海将为你删除temp tencent wechat cloudmusic等缓存文件，请注意查看容量变化
sleep, 1000
tooltip,
return

^+1::
send,+{home} ;选中并复制当前光标位置到行首
send,^c
clipboard = %clipboard%   ; 把任何复制的文件, HTML 或其他格式的文本转换为纯文本
send, {end}
return

^+2::
send,+{end} ;选中并复制当前光标位置到行末
send,^c
clipboard = %clipboard%   ; 把任何复制的文件, HTML 或其他格式的文本转换为纯文本
send, {end}
return

^+3::
clipboard = %clipboard%   ; 把任何复制的文件, HTML 或其他格式的文本转换为纯文本
send,+{home} ;选中并粘贴当前光标位置到行首
send,^v
return

^+4::
clipboard = %clipboard%   ; 把任何复制的文件, HTML 或其他格式的文本转换为纯文本
send,+{end} ;选中并粘贴当前光标位置到行末
send,^v
send, {end}
return

^+5:: ;删除光标到行首的内容
send,+{home}{delete}
return

^+6:: ;删除光标到行末的内容
send,+{end}{delete}
return

!r:: ;直接打开剪切板的网址链接，无需粘贴到chrome浏览器进入
run %clipboard%
tooltip,小海已为你打开剪切板的网址链接！
sleep, 3000
tooltip,
return

;google搜索
;=========================================================
#9:: ;用google搜索剪切板的内容
run https://www.google.com/search?q=%clipboard%
tooltip, 那晚，风也美，人也美。。。
sleep 2000
tooltip,
return

#2:: ;YouTube自动搜索
run https://www.youtube.com/results?search_query=%clipboard%
tooltip, 那晚，风也美，人也美。。。
sleep 1500
tooltip,
return

:*:kkk:: ;谷歌搜索进阶版
clipboard =   ; 清空剪贴板
send,{home}{shiftdown}{end}{shiftup} ;复制当前行到剪切板
send,^c
send, {end}
run https://www.google.com/search?q=%clipboard% ;用google搜索剪切板的内容
tooltip, 那晚，风也美，人也美。。。
sleep 1500
tooltip,
return

:*:kll:: ;谷歌搜索进阶版
send,^a
send,^x
run https://www.google.com/search?q=%clipboard% ;用google搜索剪切板的内容
tooltip, 那晚，风也美，人也美。。。
sleep 1500
tooltip,
return

;小海专用ctrl+shift集
;=========================================================
^+[:: ;复制当前鼠标所在文件文件名，ctrl+shift子集
;请将你的鼠标放在目标文件位置，即将为你复制其文件名
mouseclick, right
send,m
send,^c
send, {enter}
tooltip,已将鼠标所在文件名复制到剪切板
sleep, 1500
tooltip,
return

^+m:: ;将鼠标所在文件重命名为剪切板内容，ctrl+shift搭配子集
clipboard = %clipboard%   ; 把任何复制的文件, HTML 或其他格式的文本转换为纯文本
send,{F8}
sleep,100
mouseclick, right
send,m
send,^v
send, {enter}
tooltip,已为你将鼠标所在文件重命名为剪切板内容
sleep, 1500
tooltip,
return

!m:: ;cosea鼠标累加数字算法，我一般用来批量重命名，看需求更改吧
FormatTime, CurrentDateTime,yyyyMMddHHms,yyyyMMddHHms
clipboard := CurrentDateTime
var += 1
EnvAdd, clipboard, var
sleep,300 ;会有滞后现象
send,{AppsKey}
send,m
send,^v
send, {enter}
sleep,300
send,{down}
Exit

~Alt:: ;比如你可以用上面的方法，用AutoHotkey驱动蜂鸣器发出声音
if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)
/*
检测按键或按钮的双击
*/
loop,1500
{
var += 1
SoundBeep, var, 500
}
return

^+,:: ;将当前复制的内容存储到小海临时剪切板的库存中，等待下一条命令的临时调用，ctrl+shift子集
send,^c
clipsaved := clipboardall   ; 把剪贴板的所有内容保存到您选择的变量中
; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本
lstime := clipsaved
return

^+.:: ;将小海临时剪切板的库存中的内容全部粘贴到当前文档，ctrl+shift子集
clipboard := lstime   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll)
send,^v
return

;创意添加区域
;=========================================================
:*:+++:: ;为辅助小海脚本编辑，此命令将自动为剪切板内容添加run和空格并换行，等待下一句
clipboard = run %clipboard%
send, ^v
return

:*:.sbts:: ;为小海脚本添加鼠标提示语命令
(
tooltip,小海已为你打开
sleep, 1500
tooltip,
return
)
return

:*:.fzml:: ;为小海脚本添加分支命令
(
msgbox,4,,是，继续，否，停止
ifmsgbox, no
    return
)
return

:*:.max:: ;为小海脚本添加窗口最大化命令
clipboard = sleep,500`nWinMaximize,A
send,^v
return

;快捷打开PC应用软件，台式电脑唯一不变区域
;=========================================================
!c::
IfWinNotExist ahk_class Chrome_WidgetWin_1
{
    Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    WinActivate
}
Else IfWinNotActive ahk_class Chrome_WidgetWin_1
{
    WinActivate
}
Else
{
    WinMinimize
}
Return
;=========================================================
;**结束语：**`从`此，`让`我`们`将`生`活`过`得`五`彩`斑`斓。
;=========================================================
```
## misc
SciTE4AutoHotKey