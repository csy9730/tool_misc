# [C++文件流fstream相关操作](https://www.cnblogs.com/depend-wind/articles/12405099.html)

# 一、理解Open函数

 　利用fstream，使用open/close打开或创建，完成后关闭，对文件读入读出使用插入器(<<) 或析取器(>>)完成。参考[C++文件写入、读出函数](https://blog.csdn.net/luo809976897/article/details/51442070)。

## 1. 函数void open（...）参数选项

　　在fstream类中，有一个成员函数open()，就是用来打开文件的，其原型是：void **open**(const char* filename, int **mode**, int **access**);

**打开文件的方式\**mode\****在类ios(是所有流式I/O类的基类)中定义，可以用“或”把以上属性连接起来，如 ios::out | ios::binary 常用的值如下： 
**ios::app：　　  以追加的方式打开文件** 
**ios::ate：　　　 文件打开后定位到文件尾，ios:app就包含有此属性** 
**ios::binary：　 以二进制方式打开文件，缺省的方式是文本方式。两种方式的区别见前文** 
**ios::in：　　　  文件以输入方式打开（文件数据输入到内存）** 
**ios::out：　　  文件以输出方式打开（内存数据输出到文件）** 
**ios::nocreate：  不建立文件，所以文件不存在时打开失败** 
**ios::noreplace： 不覆盖文件，所以打开文件时如果文件存在失败** 
**ios::trunc：　　 如果文件存在，把文件长度设为0** 

**打开文件的属性\**access\****取值如下，可以用“或”或者“+”把以上属性连接起来，如3 或 1|2就是以只读和隐含属性打开文件。
**0：普通文件，打开访问** 
**1：只读文件** 
**2：隐含文件** 
**4：系统文件** 

## 2. 功能及应用场景

　　如果open函数只有文件名一个参数，则是以读/写普通文件打开， 即：**file1.open("c:\\config.sys"); <=> file1.open("c:\\config.sys", ios::in | ios::out, 0); 只读模式（fstream::out）可以创建新文件**

### 　  1）文件新建并写入

 如果该文件不存在则新建并写入，如果该文件存在则清除所有内容并从头开始写入；选择使用的参数：**ios::trunc | ios::out | ios::in。**



``` cpp
1  fstream _file;
2  _file.open(FILENAME, ios::in);
3  if(!_file) //或者_file.fail == true  or  _file.is_open == true
4       cout<<FILENAME<<"没有被创建!"<<endl;
5  else
6       cout<<FILENAME<<"已经存在!"<<endl;　
```



```
  ofstream my_samplefile ("my_saple.txt",ios::trunc|ios::out|ios::in );
```

### 2）写入CSV文件

　　CSV文件有其特殊性，由于逗号分隔符的存在，写入文件时只需要注意不遗漏必要的逗号，即可生成格式化的CSV文件。需要注意的是在open打开或创建的文件，务必以“.csv”后缀结束。



``` cpp
 1 #include <iostream>
 2 #include <fstream>
 3 #include <string>
 4 #include <vector>
 5 #include <algorithm>
 6 #include <random>
 7 using namespace std;
 8 
 9 int main(){
10     std::random_device rd; //obtain a seed
11     std::mt19937 gen(rd()); //mersenne_twister_engine 
12     std::uniform_real_distribution<> dist(-1.0, 1.0);
13     
14     ofstream outFile;
15     outFile.open("test5000.csv", ios::out); 
16     // 5000*128
17     for(int i=1;i<=5000;i++){
18         for(int j=1;j<=127;j++){
19             outFile << dist(gen) << ',';
20         }
21         outFile <<dist(gen) <<endl;
22     }
23     outFile.close();
24 }
```



### 　3）其它应用

　　贴一个简单的日志处理程序：



```
 1 #include <iostream>
 2 #include <fstream>
 3 
 4 //2018LP:增加日志
 5 void TestComLog(std::string strTxt)
 6 {
 7     std::ofstream wObj;
 8     wObj.open(".\\log\\NetTest20180827.txt", std::ios::app);
 9     wObj << strTxt << std::endl;
10     wObj.close();
11 } ///< ssl 上下文
```



#  二、文件读写 & 文件格式化

　　ofstream是从内存到硬盘，ifstream是从硬盘到内存。文件读写的步骤：1、包含的头文件：#include <fstream>。2、创建流。3、打开文件(文件和流关联)。4、**读写 (写操作：<<,put( ), write( ) 读操作： >> , get( ),getline( ), read( ))。**5、关闭文件：把缓冲区数据完整地写入文件， 添加文件结束标志， 切断流对象和外部文件的连接。

**1. 操纵符** 功能 输入/输出  

**dec  格式化为十进制数值数据 输入和输出 
endl 输出一个换行符并刷新此流 输出（关闭文件输出流） 
ends  输出一个空字符 输出 
hex  格式化为十六进制数值数据 输入和输出 
oct  格式化为八进制数值数据 输入和输出 
setpxecision(int p) 设置浮点数的精度位数 输出** 

##  2. 二进制文件的读写

　　**①put()** put()函数向流写入一个字符

　　其原型是**ofstream &put(char ch)**，使用也比较简单，如file1.put('c');就是向流写一个字符'c'。

　　**②get()** get()函数比较灵活，有3种常用的重载形式：

　　**一种**就是和put()对应的形式：**ifstream &get(char &ch);**功能是从流中读取一个字符，结果保存在引用ch中，如果到文件尾，返回空字符。如file2.get(x);表示从文件中读取一个字符，并把读取的字符保存在x中。

　　**另一种**重载形式的原型是： **int get()**;这种形式是从流中返回一个字符，如果到达文件尾，返回EOF，如x=file2.get();和上例功能是一样的。

　　**还有一种**形式的原型是：**ifstream &get(char \*buf,int num,char delim='\n');**这种形式把字符读入由 buf 指向的数组，直到读入了 num 个字符或遇到了由 delim 指定的字符，如果没使用 delim 这个参数，将使用缺省值换行符'\n'。例如：　　file2.get(str1,127,'A'); //从文件中读取字符到字符串str1，当遇到字符'A'或读取了127个字符时终止。

　　针对文本文件操作时，get函数和>>的区别：

　　区别：在读取数据时，get函数包括空白字符（遇空白字符不停止读取）

​      　　　　　　　　 >>在默认情况下拒绝接受空白字符（遇到空白符停止读取）

　　**③读写数据块** 

　　要读写二进制数据块，使用成员函数read()和write()成员函数，它们原型如下：

　　istream& read(unsigned char *buf,int num);
　　ostream& write(const unsigned char *buf,int num);

　　read()从文件中读取 num 个字符到 buf 指向的缓存中，如果在还未读入 num 个字符时就到了文件尾，可以用成员函数 int gcount();来取得实际读取的字符数;而 write() 从buf 指向的缓存写 num 个字符到文件中，值得注意的是缓存的类型是 unsigned char *，有时可能需要类型转换。

　　成员函数eof()用来检测是否到达文件尾，如果到达文件尾返回非0值，否则返回0。原型是int eof();

## 3. 文件定位

　　和C的文件操作方式不同的是，C++ I/O系统管理两个与一个文件相联系的指针。一个是读指针，它说明输入操作在文件中的位置;另一个是写指针，它下次写操作的位置。每次执行输入或输出时，相应的指针自动变化。所以，C++的文件定位分为读位置和写位置的定位，对应的成员函数是seekg()和seekp()。seekg()是设置读位置， seekp是设置写位置。它们最通用的形式如下：

```
1 istream &seekg(streamoff offset,seek_dir origin); //设置读位置
2 ostream &seekp(streamoff offset,seek_dir origin); //设置写位置
```

　　streamoff定义于 iostream.h 中，定义有偏移量 offset 所能取得的最大值，seek_dir 表示移动的基准位置，是一个有以下值的枚举.

　　**基准位置:**

　　**ios::beg：　　文件开头
　　ios::cur：　　文件当前位置
　　ios::end：　　文件结尾**

　这两个函数一般用于二进制文件，因为文本文件会因为系统对字符的解释而可能与预想的值不同。



``` cpp
1 //指针移到文件的最前面
2 seekg(0) ;
3 //把当前的指针当作0
4 seekg(0,ios::cur);
5 //将指针移到文件尾，若再配合file.tellg()则可以求出文件的大小为多少bytes。
6 seekg(0,ios::end);
```



　　考虑一个本地数据记录的文件写入格式，或一个类似log4cpp的日志写入功能如何实现。

## 4. 使用运算符<<(写)和getline()进行读写

　　<<：以行为单位输入文件，getline()：以行为单位 读入内存，能一次读入一行

​    函数原型：istream &getline( char *buffer, streamsize num );

​    功能：getline( )函数用于从文件读取num-1个字符到buffer(内存)中，直到下列情况发生时，读取结束:

​    1)：num - 1个字符已经读入

​    2)：碰到一个换行标志

​    3)：碰到一个EOF

# 三、文件指定行数删除或更新

文件的删除和重命名比较简单，但是以下两个操作都必须在文件关闭后才可以使用

```
1 //把这个文件删除
2 remove("文件名”）；
3 rename("旧文件名","新文件名");
```

##  1. 全部读出到自定义缓存区，修改缓存区某一行后再覆盖写入

　　主要思路可选getline函数读取行数据，并计数。修改可以分为两种，一种是定长修改，一种是长度发生变化的修改。两种修改都有一种通用的修改方法，不过这个方法非常没有效率，那就是建立一个tmp文件，把修改过后的内容放到里面，然后删掉原文件把tmp文件改成原文件的名字。这个方法可用但显然不是很科学，而且如果文件内容很大，那么执行效率低下时间可能会挺长的，除了文件长度较小的场景外并不推荐使用。

## 2. 修改文件打开属性，定长修改指定数据

　　不定长修改某行后，其文件指针会移动，因此会影响到这行后面的部分，所以修改的时候不能该表指定行的长度。如果使用ios::app来打开文件，虽然不会清空文件内容，但是每次写操作都追加到文件末尾（app模式为追加写入），指针偏移操作无效，即使你seekp无效，参考[C++ 修改/覆盖指定位置的文件内容或者从某个位置开始截断文件](https://blog.csdn.net/qq_31175231/article/details/81985263?depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-5&utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-5)（里面部分细节表述不准确，但是总体思路是对的）。以下内容转载自[关于fstream修改文件内容的操作](https://blog.csdn.net/cecesjtu/article/details/19028477?depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-19&utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-19)，操作的方法和注意事项比较扼要。

　　（1）在进行文件写的时候（非二进制），文件指针很成问题。举个例子：比如文件的内容是"100100100"，写入了三个int类型的变量，值为100。接下来我如果想改变第二个100，使其变成200，文件指针需要移动3位，因为前面有三个字符。这时候指针是一个字符一个字符的移动的。



``` cpp
 1 #include <iostream>
 2 #include <fstream>
 3 using namespace std;
 4  
 5 int main()
 6 {
 7     ofstream ofs("cece.txt", ios::out);
 8     int x = 100;
 9     ofs << x << x << x;
10     ofs.close();
11     ofs.open("cece.txt", ios::out | ios::in);
12     x = 200;
13     ofs.seekp(3);
14     ofs << x;
15 }
```



　　（2）而如果把文件换成二进制的写，那么情况就会有些变化，如果还是想改写第二个100的内容，那么文件指针就需要指向sizeof(int)。指针是一个byte一个byte地移动。 int存入的方式就是以int类型，将其原封写入文件，所以二进制的读写比较简单。



``` cpp
 1 #include <iostream>
 2 #include <fstream>
 3 using namespace std;
 4  
 5 int main()
 6 {
 7     ofstream ofs("cece.txt", ios::out | ios::binary);
 8     int x = 100;
 9     ofs.write((char *)&x, sizeof(x));
10     ofs.write((char *)&x, sizeof(x));
11     ofs.write((char *)&x, sizeof(x));
12     ofs.close();
13  
14     ofs.open("cece.txt", ios::out | ios::in | ios::binary);
15     x = 200;
16     ofs.seekp(sizeof(int));
17     ofs.write((char *)&x, sizeof(x));
18 }
```



　 （3）经实验表明，ios::app Mode下是不能移动文件指针的，而且这个时候tellp()是0。此模式下只能在后面追加着写。

　 （4）.如果想要获得指向末尾的位置指针，需要

``` cpp
ofs.seekp(0, ios::end);
pointer = ofs.tellp();
```

　　这个时候如果文件内没有内容，那么pointer的值会是-1。等长修改就是这样，不等长修改的话，如果长度小于原来，可以写进去，然后添0，或者别的，大于原来的，目前只会tmp覆盖原文件的方法。

没有坚守就没有事业，没有执着就没有未来！

分类: [C++ OOP](https://www.cnblogs.com/depend-wind/category/1241065.html)