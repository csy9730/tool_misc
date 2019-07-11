Set objShell = CreateObject("Wscript.Shell")

	WScript.Sleep 3000
	objShell.SendKeys "123"
	objShell.SendKeys "{F5}"
	WScript.Sleep 3000
	objShell.SendKeys "{F5}"
	
do
loop