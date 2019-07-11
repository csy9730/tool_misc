#!/usr/bin/python 
# -*- coding: UTF-8 -*- 
#writer:xmnathan 
#py文件去注释  # -*- coding: GBK -*- 
import re 
import os,sys


#读取并处理文件
def fileFindWord(FileName, wordBak):
	import chardet
	import codecs
	content = codecs.open(FileName, 'rb').read()
	ec = chardet.detect(content)['encoding']
	NewStr=''
	with open(FileName,'r',encoding=ec) as fobj:
		rc=wordBak 
		zz=re.compile(rc)
		AllLines=fobj.readlines()
		for eachline in AllLines:
			eachlin2=re.findall(zz,eachline)
			if len(eachlin2)>0:
				for el in eachlin2:
					NewStr+="%s"%(el)	
				NewStr+="\n"
				#NewStr+="%s"%(eachlin2[0])	
		with open(FileName,'w',encoding=ec)  as fNew:
			fNew.write(NewStr)
	return NewStr
# files * keywords* lines
def main(FileName='fileFindWord.txt'):
	wordBak='abc.*|1.*'
	TestStr='qabc\n1111233\n2\n3113\nab\nc\nAbcWEabcbauiiopa bcZXCV\nabccAabc\n'
	with open(FileName,'w')  as fNew:
		fNew.write(TestStr) 
	fileFindWord(FileName, wordBak)


if __name__=='__main__': 
	if  len(sys.argv)>=3:
		print(sys.argv[2])
		fileFindWord(sys.argv[1], sys.argv[2])
	else:
		main()
	print (">>>End<<<")
