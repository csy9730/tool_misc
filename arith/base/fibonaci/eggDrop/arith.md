# 算法


算法的考虑点：
输入
输出
是否需要额外分配空间，需要多少O(n)空间？
需要多少时间复杂度？
计算时间复杂度，需要分情况讨论：最优（平庸退化情况）/最劣（平庸退化情况）/最常见/分摊的时间复杂度计算
是否原址运算，
考虑算法问题的拓展，考虑条件限定情况，考虑拓展情况，

**Q**: 假设有 100 层的高楼，给你两个完全一样的鸡蛋。请你设计一种方法，能够试出来从第几层楼开始往下扔鸡蛋，鸡蛋会碎。 请问最坏情况下，至少需要试验多少次才能知道从第几层楼开始往下扔鸡蛋，鸡蛋会碎。
**A**: 根据已知条件知道，越高的楼越容易碎，一定有一个高度会把掉下来的鸡蛋区分为破碎和不碎，假设破碎为-1，不碎为1，所以这个问题可以转化成函数的过零点检测，输入为楼层高度（限定为0-100）。
对于这种离散型输入的函数搜索，一般使用二分法搜索。

考虑到鸡蛋个数有限，可以多次使用的情况，

原问题 有N层楼，K个鸡蛋，需要测试M次可以找到F（鸡蛋从第F楼掉下会破碎，F-1楼掉下不会破碎），求M的最小值
把问题改成有K个鸡蛋，允许测试M次（M>=K), 可以测试N层楼，找到F的值，求N的最大值？
设f(K,M) = N ，有f(K,K) = 


**Q**:给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
**A**: 最标准问题是统计一个整型数组，得到所有频数，对于这个问题，找到指定出现次数的值即可。
对于限定了“某个元素只出现一次以外，其余每个元素均出现两次”的条件，可以考虑使用折叠函数压缩频数数组的空间，使用异或可以同时记录value和次数，关键在于：异或运算满足f(y,x,x)=f(y)，可以消去出现偶数次的value。

拓展： 如何处理“某个元素只出现一次以外，其余每个元素均出现三次”的情况，
    考虑构造运算，使f(y,x,x,x)=f(y) , 且f(x) 运算可逆，满足以下的规律：
    0+0=0,0+1=1,0+2=2,1+0=1,1+1=2,1+2=0,2+0=0,2+1=0,2+2=1,
    这样就可以消去出现三次的元素，留下只出现一次的元素。

拓展： 如何处理“有两个元素只出现一次以外，其余每个元素均出现两次”的情况
    要获得两个元素，至少需要两个空间保存元素。
    考虑考虑构造运算，使f(y,x,x)=f(y) ,g(y,x,x)=g(y) ，且f()和g() 运算可逆,
    这样最终就会消去出现两次的元素，最终得到
    f(x,y) = v1
    g(x,y) = v2 ，
    g(x,y)这里可以设置为，先对y使用crc变换，再通过异或运算叠加到x
    两个两元整数方程，可以通过试探法求解，或者一开始就构造一个好映射表，求解表，快速求解。



简单猜数字：每次输入一个目标数，返回大于或小于或等于。使用二分法可以快速得到结果

**Q**: 猜数字游戏，有四个0·9的数字，可以猜测4个有序数字，会返回A（正确位置的数字的个数），和B(正确数字的个数）。
**A**: 
构造决策树，是左右分支尽量平衡，这样树的深度最浅，这样可以最快得到正确结果。





O(1)<O(log(n))<O(n)<O(nlogn)< O(n^2)