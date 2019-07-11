import matplotlib.pyplot as plt #导入Matplotlib库
import numpy as np  #导入NumPy库
from numpy import * #导入NumPy库
import math

NN = 2048
def fSnapRead(filename):	
	Datas = np.memmap( filename, 'float32', 'r', 0 )
	das=np.array(Datas)
	das2=das#.transpose().reshape(16,-1).transpose()
	return das2	

def search_all_files_return_by_time_reversed(path, reverse=True):
    import os, glob, time
    return sorted(glob.glob(os.path.join(path, 'INV0x1Params_*.bin')), key=lambda x: time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(os.path.getctime(x))), reverse=reverse)

def fMain(filename="E:\\Code\\GS\\GPFCVIENNASOURCE_V1\\mGS\\mGS\\snapshot_pfc_bus_over2.bin"):
	dat=fSnapRead(filename)
	#print(dat)
	print("param read end")
	print(dat.shape)
	if (dat.shape[0] >89):
		dat2 = dat[59:89]	
	else:
		dat2 = dat[0:30]	
	dat3 = dat2.reshape(-1,3)
	print(dat3)
	filename2 = filename.split('.')[0]+'.txt'
	np.savetxt(filename2,dat3)
	
if __name__ == '__main__':
	import sys
	if len(sys.argv)>1:
		filename = sys.argv[1]		
	else:
		filePath ="D:\\PWR\\PCMonitor\\build-PCMonitor-Desktop_Qt_5_4_0_MinGW_32bit-Release\\release\\" # 'PFC_1_RunParams.bin'
		fileList = search_all_files_return_by_time_reversed(filePath)
		print(fileList)
		filename =fileList[0]
	dat = fMain(filename)
