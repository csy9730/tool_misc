# matlab quad


### trapz
trapz 和 cumtrapz 函数都是基于梯形积分



cumtrapz函数和trapz函数使用方法类似，但是返回的结果不一样。前面的cum是cumulation的意思，也就是累积，相当于是不断地从第一个值累积到当前的结果。
### quad
quad MATLAB提供的quad()函数是基于自适应辛普森法设计的，

### quadl
quadl()，也称为 高精度Lobatto积分法 。其调用格式与quad()函数完全一致，使用的算法是自适应Lobatto算法，其精度和速度均远高于quad()函数，所以在追求高精度数值解时建议使用该函数。
#### quadgk
自适应Gauss-Kronrod数值积分。`z = quadgk(Fun,a,b)`
#### quadv
积分法矢量化自适应simpson数值积分。`z = quadv(Fun,a,b)`。这个函数的优点在于同时计算多个积分。
### 数值二重积分
定义: I=dblquad(f,a,b,c,d,tol,trace

### int
int 被称为符号积分法，结果都是准确值