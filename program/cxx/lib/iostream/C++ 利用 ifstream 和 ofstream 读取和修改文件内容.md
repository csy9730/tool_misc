# C++ 利用 ifstream 和 ofstream 读取和修改文件内容

发布于2019-03-15 10:39:40阅读 24K0



C 语言读取文件的时候很麻烦，C++ 相对来说有很方便的库可以用，方便的多，所以平常开发中推荐使用 C++ 中的库去读写文件。本文介绍如何利用 C++ 进行最简单的读写文件操作。

## fstream 库

用到的关键库是 fstream.

在教科书上最常见的输出输入库是 iostream 但是它针对的是标准的输入输出设备读写，而 fstream 是针对文件的。

它有 3 个很重要的类。

- ifstream
- ofstream
- fstream

ifstream 是针对文件读取的流  ofstream 是针对文件写入的流  fstream 针对文件读取和写入的流

## 打开和关闭文件

打开文件

```cpp
void open(const std::string& __s, ios_base::openmode __mode );
```

open 有 2 个参数，第一个参数代表要打开的文件的地址。  第二个参数代表操作文件的模式。

- in 读取
- out 写入
- app 追加
- ate 打开文件后定位到末尾
- trunc 打开文件后，截断之前的内容，从头开始写

ifstream 和 ofstream 打开文件都是调用的 open 方法，但是这两个类默认的模型不一样。

```cpp
ifstream ifs;

ifs.open("hello.txt");
```

我们还有一种更加简单的方法，那就是直接创建对象，创建对象的过程自动调用了 open 方法。

```cpp
ifstream ifs("hello.txt");
ofstream ofs("world.txt");
```

关闭文件，调用流对象的 close 方法就好了。

```cpp
fis.close();
```

## 读写数据

和 iostream 中的读写操作一样方便

```cpp
>>  用来读取
A >> B  将 B 的内容读取到 A

<< 用来写入
C << A  将 A 的内容写入到 C
```

### getline

当面对文本类型数据时，比如读取配置文件，我们需要一行一行读取，这个时候需要用到 getLine() 函数。

有 2 种用法。

**用法1：直接调用 getline() 函数**

```cpp
ifstream getline(ifstream is,string s)
```

从 ifstream 的一个实例中读取一行到字符串 s.

**用法2：调用 ifstream 流对象的 getline() 方法**

```cpp
ifstream getline(char* s,size_t n);
```

从 ifstream 中读取数据，最多读取 n ，然后返回流本身。

## 示例

假设有 names.data 这样一个文本文件，内容如下：

```javascript
frank
joy
jordan
kevin
tom
kerry
```

现在需要一行一样读取出来，并在终端打印出来，然后写到 testout.txt 这个文本当中。

代码如下：

```cpp
#include <iostream>
#include <fstream>
#include <stdlib.h>

using namespace std;


int main(int argc,char** argv)
{
    string path = "names.data";
    string out = "testout.txt";

    ifstream in(path.c_str());
    ofstream ou(out.c_str());



    if (!in.is_open())
    {
        cerr << "open file failed!" << endl;
        exit(-1);
    }

    if (!ou.is_open())
    {
        cerr << "create file failed!" << endl;
        exit(-1);
    }

    string s = "";
    while ( getline(in,s))
    {
        cout << s << endl;
        ou << s << endl;
    }


    in.close();
    ou.close();

    return 0;
}
```

假设源码文件为 test.cpp,编译后运行

```bash
g++ test.cpp

./a.out
```

可以发现屏幕上打印了 names.data 中的内容，所在目录也生成了 testout.txt 文档，里面的内容是一样的。

自此，用 C++ 操作文本文件最基础的知识就讲解完了，大家可以动手试一试。