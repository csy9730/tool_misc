[STL之list容器详解](https://www.cnblogs.com/scandy-yuan/archive/2013/01/08/2851324.html)

List 容器

list是C++标准模版库(STL,Standard Template Library)中的部分内容。实际上,list容器就是一个双向链表,可以高效地进行插入删除元素。

使用list容器之前必须加上<vector>头文件：#include<list>;

list属于std命名域的内容，因此需要通过命名限定：using std::list;也可以直接使用全局的命名空间方式：using namespace std;

构造函数

 　  list<int> c0; //空链表

　　list<int> c1(3); //建一个含三个默认值是0的元素的链表

　　list<int> c2(5,2); //建一个含五个元素的链表，值都是2

　　list<int> c4(c2); //建一个c2的copy链表

　　list<int> c5(c1.begin(),c1.end()); ////c5含c1一个区域的元素[_First, _Last)。

成员函数

c.begin()      返回指向链表第一个元素的迭代器。

c.end()      返回指向链表最后一个元素之后的迭代器。

```
1     list<int> a1{1,2,3,4,5};
2     list<int>::iterator it;
3     for(it = a1.begin();it!=a1.end();it++){
4         cout << *it << "\t";
5     }
6     cout << endl;
```

c.rbegin()      返回逆向链表的第一个元素,即c链表的最后一个数据。

c.rend()      返回逆向链表的最后一个元素的下一个位置,即c链表的第一个数据再往前的位置。

```
1     list<int> a1{1,2,3,4,5};
2     list<int>::reverse_iterator it;
3     for(it = a1.rbegin();it!=a1.rend();it++){
4         cout << *it << "\t";
5     }
6     cout << endl;
```

operator=      重载赋值运算符。

```
1     list<int> a1 {1,2,3,4,5},a2;
2     a2 = a1;
3     list<int>::iterator it;
4     for(it = a2.begin();it!=a2.end();it++){
5         cout << *it << endl;
6     }
```

c.assign(n,num)      将n个num拷贝赋值给链表c。

c.assign(beg,end)      将[beg,end)区间的元素拷贝赋值给链表c。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     int a[5] = {1,2,3,4,5};
 2     list<int> a1;
 3     list<int>::iterator it;
 4     a1.assign(2,10);
 5     for(it = a1.begin();it!=a1.end();it++){
 6         cout << *it << " ";
 7     }
 8     cout << endl;
 9     a1.assign(a,a+5);
10     for(it = a1.begin();it!=a1.end();it++){
11         cout << *it << " ";
12     }
13     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c.front()      返回链表c的第一个元素。

c.back()      返回链表c的最后一个元素。

```
1     list<int> a1{1,2,3,4,5};
2     if(!a1.empty()){
3         cout << "the first number is:" << a1.front() << endl;
4         cout << "the last number is:" << a1.back() << endl;
5     }
```

c.empty()  判断链表是否为空。

```
1     list<int> a1{1,2,3,4,5};
2     if(!a1.empty())
3         cout << "a1 is not empty" << endl;
4     else
5         cout << " a1 is empty" << endl;
```

c.size()      返回链表c中实际元素的个数。

```
1     list<int> a1{1,2,3,4,5};
2     cout << a1.size() << endl;
```

c.max_size()      返回链表c可能容纳的最大元素数量。

```
1     list<int> a1{1,2,3,4,5};
2     cout << a1.max_size() << endl;
```

c.clear()      清除链表c中的所有元素。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     list<int> a1{1,2,3,4,5};
 2     list<int>::iterator it;
 3     cout << "clear before:";
 4     for(it = a1.begin();it!=a1.end();it++){
 5         cout << *it << "\t";
 6     }
 7     cout << endl;
 8     a1.clear();
 9     cout << "clear after:";
10     for(it = a1.begin();it!=a1.end();it++){
11         cout << *it << "\t";
12     }
13     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c.insert(pos,num)      在pos位置插入元素num。

c.insert(pos,n,num)      在pos位置插入n个元素num。

c.insert(pos,beg,end)      在pos位置插入区间为[beg,end)的元素。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     list<int> a1{1,2,3,4,5};
 2     list<int>::iterator it;
 3     cout << "insert before:";
 4     for(it = a1.begin();it!=a1.end();it++){
 5         cout << *it << " ";
 6     }
 7     cout << endl;
 8     
 9     a1.insert(a1.begin(),0);
10     cout << "insert(pos,num) after:";
11     for(it = a1.begin();it!=a1.end();it++){
12         cout << *it << " ";
13     }
14     cout << endl;
15     
16     a1.insert(a1.begin(),2,88);
17     cout << "insert(pos,n,num) after:";
18     for(it = a1.begin();it!=a1.end();it++){
19         cout << *it << " ";
20     }
21     cout << endl;
22 
23     int arr[5] = {11,22,33,44,55};
24     a1.insert(a1.begin(),arr,arr+3);
25     cout << "insert(pos,beg,end) after:";
26     for(it = a1.begin();it!=a1.end();it++){
27         cout << *it << " ";
28     }
29     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c.erase(pos)　　　　删除pos位置的元素。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     list<int> a1{1,2,3,4,5};
 2     list<int>::iterator it;
 3     cout << "erase before:";
 4     for(it = a1.begin();it!=a1.end();it++){
 5         cout << *it << " ";
 6     }
 7     cout << endl;
 8     a1.erase(a1.begin());
 9     cout << "erase after:";
10     for(it = a1.begin();it!=a1.end();it++){
11         cout << *it << " ";
12     }
13     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c.push_back(num)      在末尾增加一个元素。

c.pop_back()      删除末尾的元素。

c.push_front(num)      在开始位置增加一个元素。

c.pop_front()      删除第一个元素。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     list<int> a1{1,2,3,4,5};
 2     a1.push_back(10);
 3     list<int>::iterator it;
 4     cout << "push_back:";
 5     for(it = a1.begin();it!=a1.end();it++){
 6         cout << *it << " ";
 7     }
 8     cout << endl;
 9     
10     a1.pop_back();
11     cout << "pop_back:";
12     for(it = a1.begin();it!=a1.end();it++){
13         cout << *it << " ";
14     }
15     cout << endl;
16     
17     a1.push_front(20);
18     cout << "push_front:";
19     for(it = a1.begin();it!=a1.end();it++){
20         cout << *it << " ";
21     }
22     cout << endl;
23     
24     a1.pop_front();
25     cout << "pop_front:";
26     for(it = a1.begin();it!=a1.end();it++){
27         cout << *it << " ";
28     }
29     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

resize(n)      从新定义链表的长度,超出原始长度部分用0代替,小于原始部分删除。

resize(n,num)            从新定义链表的长度,超出原始长度部分用num代替。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     list<int> a1{1,2,3,4,5};
 2     a1.resize(8);
 3     list<int>::iterator it;
 4     cout << "resize(n):";
 5     for(it = a1.begin();it!=a1.end();it++){
 6         cout << *it << " ";
 7     }
 8     cout << endl;
 9     
10     a1.resize(10, 10);
11     cout << "resize(n,num):";
12     for(it = a1.begin();it!=a1.end();it++){
13         cout << *it << " ";
14     }
15     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c1.swap(c2);      将c1和c2交换。

swap(c1,c2);      同上。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     list<int> a1{1,2,3,4,5},a2,a3;
 2     a2.swap(a1);
 3     list<int>::iterator it;
 4     cout << "a2.swap(a1):";
 5     for(it = a2.begin();it!=a2.end();it++){
 6         cout << *it << " ";
 7     }
 8     cout << endl;
 9     
10     swap(a3,a2);
11     cout << "swap(a3,a2):";
12     for(it = a3.begin();it!=a3.end();it++){
13         cout << *it << " ";
14     }
15     return 0;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c1.merge(c2)      合并2个有序的链表并使之有序,从新放到c1里,释放c2。

c1.merge(c2,comp)      合并2个有序的链表并使之按照自定义规则排序之后从新放到c1中,释放c2。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     list<int> a1{1,2,3},a2{4,5,6};
 2     a1.merge(a2);
 3     list<int>::iterator it;
 4     cout << "a1.merge(a2):";
 5     for(it = a1.begin();it!=a1.end();it++){
 6         cout << *it << " ";
 7     }
 8     cout << endl;
 9     
10     a2.merge(a1,[](int n1,int n2){return n1>n2;});
11     cout << "a2.merge(a1,comp):";
12     for(it = a2.begin();it!=a2.end();it++){
13         cout << *it << " ";
14     }
15     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c1.splice(c1.beg,c2)      将c2连接在c1的beg位置,释放c2

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1     list<int> a1{1,2,3},a2{4,5,6};
2     a1.splice(a1.begin(), a2);
3     list<int>::iterator it;
4     cout << "a1.merge(a2):";
5     for(it = a1.begin();it!=a1.end();it++){
6         cout << *it << " ";
7     }
8     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c1.splice(c1.beg,c2,c2.beg)      将c2的beg位置的元素连接到c1的beg位置，并且在c2中施放掉beg位置的元素

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1     list<int> a1{1,2,3},a2{4,5,6};
2     a1.splice(a1.begin(), a2,++a2.begin());
3     list<int>::iterator it;
4     cout << "a1.merge(a2):";
5     for(it = a1.begin();it!=a1.end();it++){
6         cout << *it << " ";
7     }
8     cout << endl;
9     return 0;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c1.splice(c1.beg,c2,c2.beg,c2.end)      将c2的[beg,end)位置的元素连接到c1的beg位置并且释放c2的[beg,end)位置的元素

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1     list<int> a1{1,2,3},a2{4,5,6};
2     a1.splice(a1.begin(),a2,a2.begin(),a2.end());
3     list<int>::iterator it;
4     cout << "a1.merge(a2):";
5     for(it = a1.begin();it!=a1.end();it++){
6         cout << *it << " ";
7     }
8     cout << endl;
9     return 0;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

remove(num)             删除链表中匹配num的元素。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1     list<int> a1{1,2,3,4,5};
2     a1.remove(3);
3     list<int>::iterator it;
4     cout << "remove():";
5     for(it = a1.begin();it!=a1.end();it++){
6         cout << *it << " ";
7     }
8     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

remove_if(comp)       删除条件满足的元素,参数为自定义的回调函数。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1     list<int> a1{1,2,3,4,5};
2     a1.remove_if([](int n){return n<3;});
3     list<int>::iterator it;
4     cout << "remove_if():";
5     for(it = a1.begin();it!=a1.end();it++){
6         cout << *it << " ";
7     }
8     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

reverse()       反转链表

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1     list<int> a1{1,2,3,4,5};
2     a1.reverse();
3     list<int>::iterator it;
4     cout << "reverse:";
5     for(it = a1.begin();it!=a1.end();it++){
6         cout << *it << " ";
7     }
8     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

unique()       删除相邻的元素

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1     list<int> a1{1,1,3,3,5};
2     a1.unique();
3     list<int>::iterator it;
4     cout << "unique:";
5     for(it = a1.begin();it!=a1.end();it++){
6         cout << *it << " ";
7     }
8     cout << endl;
9     return 0;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

c.sort()       将链表排序，默认升序

c.sort(comp)       自定义回调函数实现自定义排序

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     list<int> a1{1,3,2,5,4};
 2     a1.sort();
 3     list<int>::iterator it;
 4     cout << "sort():";
 5     for(it = a1.begin();it!=a1.end();it++){
 6         cout << *it << " ";
 7     }
 8     cout << endl;
 9     
10     a1.sort([](int n1,int n2){return n1>n2;});
11     cout << "sort(function point):";
12     for(it = a1.begin();it!=a1.end();it++){
13         cout << *it << " ";
14     }
15     cout << endl;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

重载运算符

operator==

operator!=

operator<

operator<=

operator>

operator>=



分类: [STL 容器](https://www.cnblogs.com/scandy-yuan/category/443998.html)

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)

![img](https://pic.cnblogs.com/face/sample_face.gif)

[Sam大叔](https://home.cnblogs.com/u/scandy-yuan/)
[关注 - 0](https://home.cnblogs.com/u/scandy-yuan/followees/)
[粉丝 - 33](https://home.cnblogs.com/u/scandy-yuan/followers/)





[+加关注](javascript:void(0);)

11

0







[« ](https://www.cnblogs.com/scandy-yuan/archive/2013/01/07/2849735.html)上一篇： [STL之vector容器详解](https://www.cnblogs.com/scandy-yuan/archive/2013/01/07/2849735.html)