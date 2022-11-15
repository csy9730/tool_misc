# [MATLAB函数nargin, nargout, inputname](https://www.cnblogs.com/emituofo/archive/2011/11/15/2249499.html)

## **1. nargin, nargout**

　　函数功能: 返回函数参数数量

　　在函数内部使用时,nargin 和 nargout分别表明有输入和输出参数数量。若在函数外部使用, nargin 和nargout对给定的函数，表明输入和输出参数数量。如果一个函数有可变数量的参数，参数数量为负值。 

nargin：返回函数输入参数的数量。 
nargin(fun)：返回函数 fun输入参数数量。如果函数参数数量可变，nargin 返回一个负值。fun 可以是函数名或映射函数的函数句柄。 
nargout：返回函数输出参数的数量。 
nargout(fun)：返回函数fun的输出参数数量。fun可以使函数名或映射函数的函数句柄。

例子1，函数内部使用：



``` matlab
function [x0, y0] = myplot(x, y, npts, angle, subdiv)
% MYPLOT  Plot a function.
% MYPLOT(x, y, npts, angle, subdiv)
%     The first two input arguments are
%     required; the other three have default values.
 ...
if nargin < 5, subdiv = 20; end
if nargin < 4, angle = 10; end
if nargin < 3, npts = 25; end
 ...
if nargout == 0
     plot(x, y)
else
     x0 = x;
     y0 = y;
end
```



例子2，函数内部使用：

``` matlab
nargin('sqrt') % return 1
nargout('sqrt') % return 1
nargin('ones') % return -1
nargout('ones') % return 1
```


## **2. inputname**

　　函数功能: 返回函数指定输入参数的名称字符串

　　这个命令只能在函数内部使用。 

　　inputname(argnum) ：返回第argnum个输入参数的名称字符串。如果输入参数没有名称（例如它是一个表达式，而不是一个变量），这时会返回空字符串('')。

例子，先定义一个函数myfun.m：

``` matlab
function c = myfun(a,b)
fprintf('First calling variable is "%s"\n.', inputname(1))
```

调用函数：

``` matlab
x = 5;  y = 3;  myfun(x,y)
```

输出：

```
First calling variable is "x".
```

但是这样调用函数：

``` matlab
myfun(pi+1, pi-1)
```

则输出：

```
First calling variable is "". 
```



标签: [matlab](https://www.cnblogs.com/emituofo/tag/matlab/)