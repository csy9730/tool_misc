import logging
import time, os

def showFileProperties2(pth):
	pth2 = pth.replace('/','_').replace('\\','_').replace(':','_')
	print(pth2)
	with open(pth2+'.log','w') as fp:
		fp.write('filename,size,readdate,writedate,createdate\n')
		for root,dirs,files in os.walk(pth):
			#print( "dir:" + root)
			for filename in files:
				state = os.stat(os.path.join(root,filename))
				info = root+'\\'+filename + ","
				info += ("%d " % state[-4]) + ","
				t= time.strftime("%Y-%m-%d %X",time.localtime(state[-3]))
				info += t + ","
				t= time.strftime("%Y-%m-%d %X",time.localtime(state[-2]))
				info += t + ","
				t= time.strftime("%Y-%m-%d %X",time.localtime(state[-1]))
				info += t
				print (info)
				fp.write(info+'\n')
if __name__== "__main__":
    import sys
    if len(sys.argv)>1:
        pth = sys.argv[1]
    else:
        pth = r"D:\Jmgo\Code\pyCode\base"
    print(pth)
    showFileProperties2(pth)
