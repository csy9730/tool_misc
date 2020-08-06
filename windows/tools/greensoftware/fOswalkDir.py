import logging
import time, os,sys
import json
import argparse

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

def showFileProperties2(path,output=None,depth=0,**kwargs):
	output = output or "a.jsonline"
	path = path or  "."
	with open(output,'w',encoding="utf-8") as fp:
		for root,dirs,files in os.walk(path):
			print( root,dirs,files)
			continue 
			for filename in files:
				state = os.stat(os.path.join(root,filename))
				dct = { "path":os.path.join(root,filename),"isfolder":False ,
					"size": state.st_size,
					"atime": time.strftime("%Y-%m-%d %X",time.localtime(state[-3]))	,			
					"mtime":time.strftime("%Y-%m-%d %X",time.localtime(state[-2])),				
					"ctime": time.strftime("%Y-%m-%d %X",time.localtime(state[-1]))
				 }					
				fp.write(json.dumps(dct,ensure_ascii=False) +'\n')
			for d in dirs:
				dct = { "path":os.path.join(root,d),"isfolder":True,
					"atime": time.strftime("%Y-%m-%d %X",time.localtime(state[-3]))	,			
					"mtime":time.strftime("%Y-%m-%d %X",time.localtime(state[-2]))	,			
					"ctime": time.strftime("%Y-%m-%d %X",time.localtime(state[-1]))
				 }				
				fp.write(json.dumps(dct,ensure_ascii=False) +'\n')

if __name__== "__main__":
	ap = argparse.ArgumentParser(prog="oswalk")
	ap.add_argument( dest = "path",help='a path ')
	ap.add_argument("--output","-o",help="output filenames")
	ap.add_argument("--depth","-d",type = int,help="depth level")
	args = ap.parse_args()
	showFileProperties2(**vars(args))
