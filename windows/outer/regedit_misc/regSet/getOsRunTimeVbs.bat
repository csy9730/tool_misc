@echo for each os in getobject _ >rt.vbs 
@echo ("winmgmts:\\.\root\cimv2:win32_perfrawdata_perfos_system").instances_ >>rt.vbs 
@echo s=os.timestamp_sys100ns:l=len(s):s=left(s,l-7):for i=1 to l-7 >>rt.vbs 
@echo t=t^&mid(s,i,1):d=t\86400:r=r^&d:t=t mod 86400:next >>rt.vbs 
@echo wscript.echo cint(r)^&"d "^&t\3600^&"h "^&t\60 mod 60^&"m "^&t mod 60^&"s":next >>rt.vbs
cscript //nologo rt.vbs & del rt.vbs 
