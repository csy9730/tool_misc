import random
arr = [11,32,3,3,32,5,5,6,6,8,8,16,16]
def xorArray(arr):
    x=0
    for a in arr:
        x^=a
    return x
x = xorArray(arr)
print(x)




"""

0+1 = 1
1+0 = 0
0+0 = 0
1+1 = 1

0+1 = 1
1+1 = 2


f(x,x)=f(0)
def fx(x):
    pass
f(x,x,x)=f(0)
xor(x0,x1)
xor(f(x0),f(x1))
"""