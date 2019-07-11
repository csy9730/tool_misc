#!/usr/bin/python 
# -*- coding: UTF-8 -*- 
#writer:xmnathan 
#py文件去注释  # -*- coding: GBK -*- 
import re 
import os,sys


#ec='gb2312'  #ec='GBK' #ec='utf-8'#

  #读取并处理文件
def fileReplaceWord(FileName, wordBak, wordNext):
	#global ec
	import codecs
	import chardet
	content = codecs.open(FileName, 'rb').read()
	ec = chardet.detect(content)['encoding']
	print( wordBak, wordNext ,ec)
	NewStr=''
	with open(FileName,'r',encoding=ec) as fobj:
		rc=wordBak 
		zz=re.compile(rc)
		AllLines=fobj.readlines()
		for eachline in AllLines:
			eachlin2=(re.sub(zz,wordNext,eachline))
			NewStr=NewStr+eachlin2
	#with open(FileName,'w',encoding=ec)  as fNew:
	with open(FileName,'w',encoding=ec)  as fNew:
		fNew.write(NewStr)
	return NewStr
# files * keywords* lines
def main(FileName='fileReplaceWord.txt'):
	wordBak='\\babc\\b'
	wordNext='QWE'
	TestStr='qabc\nAbcWEabcbau  abc iiopa bcZXCV'
	with open(FileName,'w')  as fNew:
		fNew.write(TestStr) 
	fileReplaceWord(FileName, wordBak, wordNext)


if __name__=='__main__': 
	if  len(sys.argv)>3:
		#print( sys.argv[1], sys.argv[2], sys.argv[3])
		fileReplaceWord(sys.argv[1], sys.argv[2], sys.argv[3])
	else:
		main()
	print (">>>End<<<")
