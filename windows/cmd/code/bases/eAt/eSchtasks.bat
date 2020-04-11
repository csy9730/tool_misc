if not "%times%"=="" for %%i in (%times%) do ( 
    at %%i /every:M,T,W,Th,F,S,Su shutdown -s 
) 

at  9876 /every:M,T,W,Th,F,S,Su dir 
schtasks 9876 /every:M,T,W,Th,F,S,Su dir 

schtasks /run  /tn dir 

schtasks /showsid

schtasks /query /v >temp.txt