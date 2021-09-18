# c++ try catch语句_try{}catch{}finally{},和return的执行顺序

[weixin_39835991](https://blog.csdn.net/weixin_39835991) 2020-11-26 15:29:47 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 269 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 2

文章标签： [c++ try catch语句](https://so.csdn.net/so/search/s.do?q=c++ try catch语句&t=blog&o=vip&s=&l=&f=&viparticle=) [catch后面的代码会执行吗](https://www.csdn.net/tags/MtjaEg0sNjc2OTgtYmxvZwO0O0OO0O0O.html) [catch后面的语句还会执行吗](https://www.csdn.net/tags/OtTakgxsNjQ2MDYtYmxvZwO0O0OO0O0O.html) [return finally执行顺序](https://so.csdn.net/so/search/s.do?q=return finally执行顺序&t=blog&o=vip&s=&l=&f=&viparticle=) [return返回两个值](https://www.csdn.net/tags/MtTacgxsNzAxNjEtYmxvZwO0O0OO0O0O.html) [try catch finally执行顺序](https://so.csdn.net/so/search/s.do?q=try catch finally执行顺序&t=blog&o=vip&s=&l=&f=&viparticle=)



1、不管有没有出现异常，finally块中代码都会执行；

2、当try和catch中有return时，finally仍然会执行；

3、finally是在return后面的表达式运算后执行的(此时并没有返回运算后的值，而是先把要返回的值保存起来，不管finally中的代码怎么样，返回的值都不会改变，任然是之前保存的值)，所以函数返回值是在finally执行前确定的；

4、finally中最好不要包含return，否则程序会提前退出，返回值不是try或catch中保存的返回值。

举例：

情况1：try{} catch(){}finally{} return;

​            显然程序按顺序执行。

情况2:try{ return; }catch(){} finally{} return;

​          程序执行try块中return之前(包括return语句中的表达式运算)代码；

​         再执行finally块，最后执行try中return;

​         finally块之后的语句return，因为程序在try中已经return所以不再执行。

情况3:try{ } catch(){return;} finally{} return;

​         程序先执行try，如果遇到异常执行catch块，

​         有异常：则执行catch中return之前(包括return语句中的表达式运算)代码，再执行finally语句中全部代码，

​                     最后执行catch块中return. finally之后也就是4处的代码不再执行。

​         无异常：执行完try再finally再return.

情况4:try{ return; }catch(){} finally{return;}

​          程序执行try块中return之前(包括return语句中的表达式运算)代码；

​          再执行finally块，因为finally块中有return所以提前退出。

情况5:try{} catch(){return;}finally{return;}

​          程序执行catch块中return之前(包括return语句中的表达式运算)代码；

​          再执行finally块，因为finally块中有return所以提前退出。

情况6:try{ return;}catch(){return;} finally{return;}

​          程序执行try块中return之前(包括return语句中的表达式运算)代码；

​          有异常：执行catch块中return之前(包括return语句中的表达式运算)代码；

​                       则再执行finally块，因为finally块中有return所以提前退出。

​          无异常：则再执行finally块，因为finally块中有return所以提前退出。

最终结论：任何执行try 或者catch中的return语句之前，都会先执行finally语句，如果finally存在的话。

​                  如果finally中有return语句，那么程序就return了，所以finally中的return是一定会被return的，

​                  编译器把finally中的return实现为一个warning。

![101d0fb9e97353e7da2085275feec25d.png](https://img-blog.csdnimg.cn/img_convert/101d0fb9e97353e7da2085275feec25d.png)



相关资源：[*C++*异常处理try,*catch*,throw,*finally*的用法_try*catch*用法*c++*-其它...](https://download.csdn.net/download/weixin_38531630/12764137?spm=1001.2101.3001.5697)