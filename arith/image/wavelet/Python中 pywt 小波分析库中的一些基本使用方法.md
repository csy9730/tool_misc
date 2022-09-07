# Python中 pywt 小波分析库中的一些基本使用方法

![img](https://cdn2.jianshu.io/assets/default_avatar/12-aeeea4bedf10f2a12c0d50d626951489.jpg)

[古德蜡克](https://www.jianshu.com/u/1f4257df6352)关注

0.1692019.04.09 15:45:16字数 223阅读 7,464

尺度函数 ： scaling function （在一些文档中又称为父函数 father wavelet ）
小波函数 ： wavelet function（在一些文档中又称为母函数 mother wavelet）
连续的小波变换 ：CWT
离散的小波变换 ：DWT
小波变换的基本知识：
不同的小波基函数，是由同一个基本小波函数经缩放和平移生成的。
小波变换是将原始图像与小波基函数以及尺度函数进行内积运算,所以一个尺度函数和一个小波基函数就可以确定一个小波变换
小波变换后低频分量
基本的小波变换函数

二维离散小波变换：

（官网上的例子）

```python
import numpy as np
import pandas as pd 
import matplotlib.pyplot as plt 
 
def test_pywt():
    import numpy as np
    import matplotlib.pyplot as plt
    import pywt
    import pywt.data
    
    # Load image
    original = pywt.data.camera()
    
    # Wavelet transform of image, and plot approximation and details
    titles = ['Approximation', ' Horizontal detail',
              'Vertical detail', 'Diagonal detail']
    coeffs2 = pywt.dwt2(original, 'bior1.3')
    LL, (LH, HL, HH) = coeffs2
    plt.imshow(original)
    plt.colorbar(shrink=0.8)
    fig = plt.figure(figsize=(12, 3))
    for i, a in enumerate([LL, LH, HL, HH]):
        ax = fig.add_subplot(1, 4, i + 1)
        ax.imshow(a, interpolation="nearest", cmap=plt.cm.gray)
        ax.set_title(titles[i], fontsize=10)
        ax.set_xticks([])
        ax.set_yticks([])
    
    fig.tight_layout()
    plt.show()
# test_pywt()



#coding=gbk
'''
Created on 2018年10月9日
这个模块是为了测试 pywt 库 的相关用法
@author: Administrator
'''
 
import pywt 
print(pywt.families())  #打印出小波族
# ['haar', 'db', 'sym', 'coif', 'bior', 'rbio', 'dmey', 'gaus', 'mexh', 'morl', 'cgau', 'shan', 'fbsp', 'cmor']
 
for family in pywt.families():  #打印出每个小波族的每个小波函数
    print('%s family: '%(family) + ','.join(pywt.wavelist(family)))
# haar family: haar
# db family: db1,db2,db3,db4,db5,db6,db7,db8,db9,db10,db11,db12,db13,db14,db15,db16,db17,db18,db19,db20,db21,db22,db23,db24,db25,db26,db27,db28,db29,db30,db31,db32,db33,db34,db35,db36,db37,db38
# sym family: sym2,sym3,sym4,sym5,sym6,sym7,sym8,sym9,sym10,sym11,sym12,sym13,sym14,sym15,sym16,sym17,sym18,sym19,sym20
# coif family: coif1,coif2,coif3,coif4,coif5,coif6,coif7,coif8,coif9,coif10,coif11,coif12,coif13,coif14,coif15,coif16,coif17
# bior family: bior1.1,bior1.3,bior1.5,bior2.2,bior2.4,bior2.6,bior2.8,bior3.1,bior3.3,bior3.5,bior3.7,bior3.9,bior4.4,bior5.5,bior6.8
# rbio family: rbio1.1,rbio1.3,rbio1.5,rbio2.2,rbio2.4,rbio2.6,rbio2.8,rbio3.1,rbio3.3,rbio3.5,rbio3.7,rbio3.9,rbio4.4,rbio5.5,rbio6.8
# dmey family: dmey
# gaus family: gaus1,gaus2,gaus3,gaus4,gaus5,gaus6,gaus7,gaus8
# mexh family: mexh
# morl family: morl
# cgau family: cgau1,cgau2,cgau3,cgau4,cgau5,cgau6,cgau7,cgau8
# shan family: shan
# fbsp family: fbsp
# cmor family: cmor
 
db3 = pywt.Wavelet('db3')   #创建一个小波对象
print(db3)
# Filters length: 6        #滤波器长度
# Orthogonal:     True    #正交
# Biorthogonal:   True    #双正交
# Symmetry:       asymmetric    #对称性，不对称
# DWT:            True    #离散小波变换
# CWT:            False    #连续小波变换
 
def print_array(arr):
    print('[%s]'%','.join(['%.14f'%x for x in arr]))
    
#离散小波变换的小波滤波系数
# dec_lo Decomposition filter values 分解滤波值， rec 重构滤波值
#db3.filter_bank 返回4 个属性
print(db3.filter_bank == (db3.dec_lo, db3.dec_hi, db3.rec_lo, db3.rec_hi))  #True
print(db3.dec_len) 
print(db3.rec_len)  #6 
 
# DWT 与 IDWT 
#使用db2 小波函数做dwt
x = [3, 7, 1, 1, -2, 5, 4, 6]
cA, cD = pywt.dwt(x, 'db2') #得到近似值和细节系数
print(cA)   # [5.65685425 7.39923721 0.22414387 3.33677403 7.77817459]
print(cD)   # [-2.44948974 -1.60368225 -4.44140056 -0.41361256  1.22474487]
 
#IDWT 
print(pywt.idwt(cA, cD, 'db2')) # [ 3.  7.  1.  1. -2.  5.  4.  6.]
 
#传入小波对象，设置模式
w = pywt.Wavelet('sym3')
cA, cD = pywt.dwt(x, wavelet=w, mode='constant')
print(cA)   # [ 4.38354585  3.80302657  7.31813271 -0.58565539  4.09727044  7.81994027]
print(cD)   # [-1.33068221 -2.78795192 -3.16825651 -0.67715519 -0.09722957 -0.07045258]
 
print(pywt.Modes.modes)
# ['zero', 'constant', 'symmetric', 'periodic', 'smooth', 'periodization', 'reflect', 'antisymmetric', 'antireflect']
 
print(pywt.idwt([1,2,0,1], None, 'db3', 'symmetric'))
print(pywt.idwt([1,2,0,1], [0,0,0,0], 'db3', 'symmetric'))
# [ 0.83431373 -0.23479575  0.16178801  0.87734409]
# [ 0.83431373 -0.23479575  0.16178801  0.87734409]
 
#小波包 wavelet packets 
X  = [1, 2, 3, 4, 5, 6, 7, 8]
wp = pywt.WaveletPacket(data=X, wavelet='db3', mode='symmetric', maxlevel=3)
print(wp)
print(wp.data)  #[1 2 3 4 5 6 7 8 9]
print(repr(wp.path))
print(wp.level) # 0    #分解级别为0 
print(wp['ad'].maxlevel)    # 3 
 
#访问小波包的子节点
#第一层：
print(wp['a'].data)
# [ 4.52111203  1.54666942  2.57019338  5.3986205   8.19182134 11.27067814
#  12.65348525]        # 当设置分解的 maxlevel 时，分解得到的data
 
#[ 4.52111203  1.54666942  2.57019338  5.3986205   8.20681003 11.18125264] 设置为2 时
print(wp['a'].path) # a
#第2 层
print(wp['aa'].data)
# [ 3.63890166  6.00349136  2.89780988  6.80941869 15.41549196]
print(wp['ad'].data)
# [ 1.25531439 -0.60300027  0.36403471  0.59368086 -0.53821027]
print(wp['aa'].path)    # aa
print(wp['ad'].path)    # ad
 
#第3 层时：
print(wp['aaa'].data)
# [ 6.7736584   5.78857317  5.69392399 10.98672847 19.92241106]
 
# print(wp['aaaa'].data)  #超过最大层时，会报错
#获取特定层数的所有节点
print([node.path for node in wp.get_level(3, 'natural')])   #第3层有8个
# ['aaa', 'aad', 'ada', 'add', 'daa', 'dad', 'dda', 'ddd']
 
#依据频带频率进行划分
print([node.path for node in wp.get_level(3, 'freq')])
# ['aaa', 'aad', 'add', 'ada', 'dda', 'ddd', 'dad', 'daa']
 
#从小波包中 重建数据
X  = [1, 2, 3, 4, 5, 6, 7, 8]
wp = pywt.WaveletPacket(data=X, wavelet='db1', mode='symmetric', maxlevel=3)
print(wp['ad'].data)    # [-2,-2]
new_wp = pywt.WaveletPacket(data=None, wavelet='db1', mode='symmetric')
new_wp['a'] = wp['a']
new_wp['aa'] = wp['aa'].data
new_wp['ad'] = [-2,-2]  # wp['ad'].data
new_wp['d'] = wp['d']
print(new_wp.reconstruct(update=False))
# new_wp['a'] = wp['a']  直接使用高低频也可进行重构
# new_wp['d'] = wp['d']
print(new_wp)   #: None
print(new_wp.reconstruct(update=True))  #更新设置为True时。
print(new_wp)
# : [1. 2. 3. 4. 5. 6. 7. 8.]
 
#获取叶子结点
print([node.path for node in new_wp.get_leaf_nodes(decompose=False)])
# ['aa', 'ad', 'd']
print([node.path for node in new_wp.get_leaf_nodes(decompose=True)])
# ['aaa', 'aad', 'ada', 'add', 'daa', 'dad', 'dda', 'ddd']
 
#从小波包树中移除结点
dummy = wp.get_level(2)
for i in wp.get_leaf_nodes(False):
    print(i.path, i.data)
# aa [ 5. 13.]
# ad [-2. -2.]
# da [-1. -1.]
# dd [-1.11022302e-16  0.00000000e+00]
node = wp['ad']
print(node) #ad: [-2. -2.]
del wp['ad'] #删除结点
for i in wp.get_leaf_nodes(False):
    print(i.path, i.data)
# aa [ 5. 13.]
# da [-1. -1.]
# dd [-1.11022302e-16  0.00000000e+00]    
 
print(wp.reconstruct()) #进行重建
# [2. 3. 2. 3. 6. 7. 6. 7.]
 
wp['ad'].data = node.data   #还原已删除的结点
print(wp.reconstruct())
# [1. 2. 3. 4. 5. 6. 7. 8.]
 
print(wp['a'])
print(wp.a)
 
    
 
filename = r'D:\ml_datasets\PHM\c6\c_6_001.csv'
data = pd.read_csv(filename)
data = data.iloc[100000:110000, 3]
cA1, cD1 = pywt.dwt(data, 'db3') #得到近似值和细节系数
 
wap = pywt.WaveletPacket(data=data, wavelet='db3')
dataa = wap['a'].data
print(wap['a'].data)
print(len(wap['a'].data))
plt.figure(num='ca')
plt.plot(dataa)
plt.figure(num='data')
plt.plot(dataa)
plt.show()
 
 
 
# plt.figure(num='ca')
# plt.plot(cA1)
# plt.figure(num='cd')
# plt.plot(cD1)
# plt.figure(num='data')
# plt.plot(data)
# plt.show()
```

pywt 库中 upcoef 函数的使用

pywt.upcoef(part='a'or'd', coeffs=cA, cD, wavelet, level, take)

``` python
data = np.array([8,9,10,11,1,2,3,4,5,6,7]).reshape(-1,)
print('origin data:',data)
(cA, cD) = pywt.dwt(data, 'haar')
print('cA para:',cA)
# cA para: [12.02081528 14.8492424   2.12132034  4.94974747  7.77817459  9.89949494]
print('cD para:',cD)
print('take length:len(cA)',len(cA))
# take length:len(cA) 6
print('take length:len(cD)',len(cD))
 
print(pywt.upcoef('a', cA, 'haar',take=len(cA)) + pywt.upcoef('d', cD, 'haar',take=len(cD)))
#截取原始 数据中间的take 个数值
print('take length:len(data)',len(data))
print(pywt.upcoef('a', cA, 'haar',take=len(data)) + pywt.upcoef('d', cD, 'haar',take=len(data)))
print(pywt.upcoef('a', cA, 'haar',take=1) + pywt.upcoef('d', cD, 'haar',take=1))
print(pywt.upcoef('a', cA, 'haar',take=2) + pywt.upcoef('d', cD, 'haar',take=2))
print(pywt.upcoef('a', cA, 'haar',take=3))
# [1.5 1.5 3.5]
print(pywt.upcoef('d', cD, 'haar',take=3))
# [-0.5  0.5 -0.5]
print(pywt.upcoef('a', cA, 'haar',take=3) + pywt.upcoef('d', cD, 'haar',take=3))
# [1. 2. 3.]
# 从最中间的位置截取指定长度的数据；如果为1，就是最中间的2；如果为2，就是最中间的两个数，就是2与3；以此类推；
```

------

转自：[https://blog.csdn.net/qq_40587575/article/details/83154042](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fqq_40587575%2Farticle%2Fdetails%2F83154042)