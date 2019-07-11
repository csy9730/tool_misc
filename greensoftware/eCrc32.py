import hashlib
import zlib

def getMd5(filename):
	mdfive = hashlib.md5()
	with open(filename,'rb') as f:
		mdfive.update(f.read())
	return mdfive.hexdigest()
def getCrc32(filename):
    with open(filename,'rb') as f:
        return zlib.crc32(f.read())
def getSha256(filename):
	mdfive = hashlib.sha256()
	with open(filename,'rb') as f:
		mdfive.update(f.read())
	return mdfive.hexdigest()

	
def main(pth):
	mdfVal=getMd5(pth)
	#mdfVal=getCrc32(pth)
	print(mdfVal)
	#print("{:8}{:x}".format("crc32",mdfVal))	
	
if __name__ == '__main__':
	pth = r"E:\Code\mProject\dataStructArith\work\crc\demos\__zalTestFileCrc32Cal2_tmp__.txt"
	pth = r"E:\SVN\dataStructArith_build\work\crc\demos\__zalTestFileCrc32Cal2_tmp__.txt"
	import sys	
	if len(sys.argv)>1:
		pth = sys.argv[1]
	main(pth)