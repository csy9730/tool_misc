@echo for each ps in getobject _ >ps.vbs 
@echo ("winmgmts:\\.\root\cimv2:win32_operatingsystem").instances_ >>ps.vbs 
@echo wscript.echo ps.caption^&" "^&ps.version:next >>ps.vbs 
cscript //nologo ps.vbs & del ps.vbs 
