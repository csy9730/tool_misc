
import numpy as np
"""
    汉诺塔：
    有A,B，C三个塔，有n个大小不一的盘子，大盘子不能放在小盘子上面，每次可以移动一个盘子从一个柱子到另一个柱子。
    计算，把盘子从A柱移动到C柱需要多少步？

    汉诺塔（斐波那契数列)改：
    有A,B，C三个塔，有n个大小不一的盘子，大盘子不能放在小盘子上面。每次只能把一个盘子从A移到B，或B移到C，或从C移到A，算作一步。
    计算，把盘子从A柱移动到C柱需要多少步？

    可以得到递推公式：
        ff(n) = 2* ff(n-1) + 2* ff(n-2)+ 3
"""
a = (3**0.5+1)
b = (1-3**0.5)

xx3 = [(5*3**0.5+3)/6 * (1+3**0.5), (3-5*3**0.5)/6 * (1-3**0.5)]
from math import sqrt
def ff3(x):
    a1 = sqrt(3) +5 
    a2 = 5- sqrt(3)
    x1 = 1+sqrt(3)
    x2 = 1 - sqrt(3)
    return  ( a1* x1**(x-1) - a2 * x2**(x-1) ) /2/sqrt(3)

print("ssss", ff3(1),ff3(2),ff3(3))

print(xx3)
# fx = [k2* a**n + k1* b**n + k0] 

AA = np.matrix([[a**1,b**1,1],[a**2,b**2,1],[a**3,b**3,1]])
bb = [[2],[7],[21]]

xx = np.linalg.solve(AA, bb)
print(xx) 

AA2 = np.matrix([[a**2,b**2,1],[a**3,b**3,1],[a**4,b**4,1],])
bb2 = [[7],[21],[59]]
xx2 = np.linalg.solve(AA2, bb2)
print(xx2)

# print(np.linalg.inv(a))  # 对应于MATLAB中 inv() 函数


from functools import lru_cache

@lru_cache()
def ff(n):
    if n<=0: return 0
    if n==1: return 2
    # if n==2: return 7
    return ff(n-1) *2 +2 + (1+ 2*ff(n-2))

import time
tm = time.time()

for i in range(30):
    print(ff(i))
toc = time.time()-tm
# print(toc)
