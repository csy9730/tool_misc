# C++ std::vector优化部分性能大幅提升

[![郭忠明](https://pic2.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/guo-zhong-ming-26)

[郭忠明](https://www.zhihu.com/people/guo-zhong-ming-26)

内存库 https://gitee.com/wlmqgzm



210 人赞同了该文章

std::vector 是C++中最简单最常用的容器，一般多数人认为这个库太简单了，可能没有多少可以优化的地方。这两天回答了一个关于vector优化的问题，刚好可以谈一下.

对于多数T对象的优化解决方案。自研版本的vector在多数T对象下比std::vector更快，更少的空间占用，主要的优化内容是：

std:: vector中增加和删除动作，因为有内存的申请释放和T对象的移动，相对开销都比较大，针对多数T对象有优化余地。优化的关键就是设法减少T对象移动的开销．

检测能否优化标志是一个static bool值， 主要是判断对象T内部是否存在指向自身或者依赖自身地址的指针。如果不存在这样的指针，并且T()对象为全零值(可以memset)，那么就可以进行完全优化。在第一次创建vector<T>时就得到分析结果，设置bool值，后面再创建同样的对象时不会执行检测代码，所以这种检测开销极小。

（一）在检测到允许进行优化处理时，进行下列性能的优化：

１）避免T对象移动的优化：

自研库使用realloc的方式申请内存扩展空间，而不是使用常规的malloc的方式申请内存，这样在很多情况扩展时都不用拷贝数据，大幅度提升了性能．这块的实际性能提升倍数取决于能够连续多少次在原地址处申请扩展内存成功，只要在原地址处能够成功扩展空间，就不需要移动T对象了，大大节约了开销．

２）减少T对象创建和析构的开销：

erase（） / insert（） 等函数内部实现有很多处需要移动T&&对象，可以采用memmove / memcpy /memset 方式优化，可大幅度提升性能（减少了对象创建和析构的开销）

（二）占用内存的优化：

在允许进行优化处理时，由于优化方案中T对象的移动速度很快，因此，可以增加T对象移动的次数，来减少空间的浪费，由于cache更友好，性能几乎不变，总体还是比std::vector快一倍．

１）在检测到允许进行优化处理时，将vector的扩展倍数，从gcc默认的２倍增长修改为1.5倍增长（即8,12,16,24,32,48,64...)，可以平均减少一半的浪费空间。否则还是默认的２倍增长，以便提供与std库同样的性能．

2) 修改起始空间数量，减少小空间下内存扩展的开销: gcc版本std::vector默认有数据开始空间大小就是１，自研版本默认有数据开始空间大小是８，这样适当浪费一点小空间，来减少常规场景下的内存扩展次数，提高性能．

(三) 自身占用空间的优化，std::vector目前64位版本占用空间为24Byte， 拆分为haisql:: vector_big 和haisql::vector 两个版本，haisql::vector限制size大小不超过20亿，占用空间为16Byte，比std库版本节约33%的自身内存占用。主要原因是我们考虑一般不会有20亿条记录的vector场景存在，限制size和capacity都是4字节的unsigned int，可以节约出8字节的空间。这块优化的思路是不为常规场景以外付出额外的代价。

下面是测试代码：

```text
#include <iostream>
#include  <vector>

#include  "haisql_now.hpp"
#include  "haisql_vector.hpp"

void   test1( void )
{
    unsigned int  n = 10000000;
    std::cout << "n=" << n << std::endl;
    {
        unsigned long long ulong_begin = haisql::now_steady_microseconds();
        haisql::vector<unsigned int>   vt_uint;
        for( unsigned int i=0; i<n; ++i )
        {
            vt_uint.push_back( i );
            continue;
        }
        unsigned long long ulong_end = haisql::now_steady_microseconds();
        std::cout << "haisql::vector<unsigned int>  push_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;

        ulong_begin = haisql::now_steady_microseconds();
        for( unsigned int i=0; i<n; ++i )
        {
            vt_uint.pop_back();
            continue;
        }
        ulong_end = haisql::now_steady_microseconds();
        std::cout << "haisql::vector<unsigned int>  pop_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;
    }

    {
        unsigned long long ulong_begin = haisql::now_steady_microseconds();
        std::vector<unsigned int>   vt_uint;
        for( unsigned int i=0; i<n; ++i )
        {
            vt_uint.push_back( i );
            continue;
        }
        unsigned long long ulong_end = haisql::now_steady_microseconds();
        std::cout << "std::vector<unsigned int>  push_back()  use_microseconds=" << ulong_end-ulong_begin << std::endl;

        ulong_begin = haisql::now_steady_microseconds();
        for( unsigned int i=0; i<n; ++i )
        {
            vt_uint.pop_back();
            continue;
        }
        ulong_end = haisql::now_steady_microseconds();
        std::cout << "std::vector<unsigned int>  pop_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;
    }
    return;
}


void   test2( void )
{
    std::string   str_tmp = "aaaaabbbbbcccccdddddeeeeeefffffggggghhhhhjjjjjjjjjjjjohgksdfkl;hkjhl;jgsdlf;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;gk";
    unsigned int  n = 10000000;
    std::cout << "n=" << n << std::endl;
    {
        unsigned long long ulong_begin = haisql::now_steady_microseconds();
        haisql::vector<std::string>   vt_str;
        for( unsigned int i=0; i<n; ++i )
        {
            vt_str.push_back( str_tmp );
            continue;
        }
        unsigned long long ulong_end = haisql::now_steady_microseconds();
        std::cout << "haisql::vector<std::string>  push_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;

        ulong_begin = haisql::now_steady_microseconds();
        for( unsigned int i=0; i<n; ++i )
        {
            vt_str.pop_back();
            continue;
        }
        ulong_end = haisql::now_steady_microseconds();
        std::cout << "haisql::vector<std::string>  pop_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;
    }

    {
        unsigned long long ulong_begin = haisql::now_steady_microseconds();
        std::vector<std::string>   vt_str;
        for( unsigned int i=0; i<n; ++i )
        {
            vt_str.push_back( str_tmp );
            continue;
        }
        unsigned long long ulong_end = haisql::now_steady_microseconds();
        std::cout << "std::vector<std::string>  push_back()  use_microseconds=" << ulong_end-ulong_begin << std::endl;

        ulong_begin = haisql::now_steady_microseconds();
        for( unsigned int i=0; i<n; ++i )
        {
            vt_str.pop_back();
            continue;
        }
        ulong_end = haisql::now_steady_microseconds();
        std::cout << "std::vector<std::string>  pop_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;
    }
    return;
}


void   test3( void )
{
    unsigned int  n = 10000000;
    std::cout << "n=" << n << std::endl;
    {
        unsigned long long ulong_begin = haisql::now_steady_microseconds();
        haisql::vector<haisql::vector<unsigned int> >   vt_vt_uint;
        vt_vt_uint.resize( 10 );
        for( unsigned int i=0; i<10; ++i )
        {
            haisql::vector<unsigned int> &vt_uint = vt_vt_uint[i];
            for( unsigned int j=0; j<n; ++j )
            {
                vt_uint.push_back( i );
                continue;
            }
            continue;
        }
        unsigned long long ulong_end = haisql::now_steady_microseconds();
        std::cout << "haisql::vector<haisql::vector<unsigned int> >  push_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;

        ulong_begin = haisql::now_steady_microseconds();
        for( unsigned int i=0; i<10; ++i )
        {
            haisql::vector<unsigned int> &vt_uint = vt_vt_uint[i];
            for( unsigned int j=0; j<n; ++j )
            {
                vt_uint.pop_back();
                continue;
            }
            continue;
        }
        ulong_end = haisql::now_steady_microseconds();
        std::cout << "haisql::vector<haisql::vector<unsigned int> > pop_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;
    }

   {
        unsigned long long ulong_begin = haisql::now_steady_microseconds();
        std::vector<std::vector<unsigned int> >   vt_vt_uint;
        vt_vt_uint.resize( 10 );
        for( unsigned int i=0; i<10; ++i )
        {
            std::vector<unsigned int> &vt_uint = vt_vt_uint[i];
            for( unsigned int j=0; j<n; ++j )
            {
                vt_uint.push_back( i );
                continue;
            }
            continue;
        }
        unsigned long long ulong_end = haisql::now_steady_microseconds();
        std::cout << "std::vector<std::vector<unsigned int> >  push_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;

        ulong_begin = haisql::now_steady_microseconds();
        for( unsigned int i=0; i<10; ++i )
        {
            std::vector<unsigned int> &vt_uint = vt_vt_uint[i];
            for( unsigned int j=0; j<n; ++j )
            {
                vt_uint.pop_back();
                continue;
            }
            continue;
        }
        ulong_end = haisql::now_steady_microseconds();
        std::cout << "std::vector<std::vector<unsigned int> > pop_back() use_microseconds=" << ulong_end-ulong_begin << std::endl;
    }
    return;
}


int main()
{
    test1();
    test2();
    test3();
    return 0;
}

 
guo@guo-desktop2:/mnt/guo/cpp/test_vector/bin/Release$ ./test_vector
n=10000000
haisql::vector<unsigned int>  push_back() use_microseconds=34025
haisql::vector<unsigned int>  pop_back() use_microseconds=0
std::vector<unsigned int>  push_back()  use_microseconds=73604
std::vector<unsigned int>  pop_back() use_microseconds=0
n=10000000
haisql::vector<std::string>  push_back() use_microseconds=1380017
haisql::vector<std::string>  pop_back() use_microseconds=483618
std::vector<std::string>  push_back()  use_microseconds=1386374
std::vector<std::string>  pop_back() use_microseconds=472615
n=10000000
haisql::vector<haisql::vector<unsigned int> >  push_back() use_microseconds=369909
haisql::vector<haisql::vector<unsigned int> > pop_back() use_microseconds=0
std::vector<std::vector<unsigned int> >  push_back() use_microseconds=668320
std::vector<std::vector<unsigned int> > pop_back() use_microseconds=0
guo@guo-desktop2:/mnt/guo/cpp/test_vector/bin/Release$ 
 
```

可以看到在一些场景下(对于多数T对象均可)启用优化功能后，性能比std库大约提升到了一倍以上，在有些时候同样的代码测试可以提升到3倍(主要是看连续多少次在原地直接扩展内存成功)，浪费空间平均减少一半，自身占用空间减少33%。

华丽的分隔线==================================================================================================================================================================

文章发表后,有很多人对于static bool="判断对象T内部是否存在指向自身或者依赖自身地址的指针", 有比较多的疑问, 公司库代码非开源, 不能给大家,

但是 关于这个bool变量判断的思路的验证代码显示结果, 见下面.

看看代码执行结果, 显然 对于std::string 和 std::list 即使是一个空对象, 也存在指向自身或者依赖自身地址的指针, ptr_size_t_tmp是否在this自身的地址范围内的判断, 是一个非常简单的问题.

并且对于标准库的对象, static bool 默认的判断代码就可以满足要求;

```text
    {
        std::list<unsigned int>  list1;
        const size_t *ptr_size_t_tmp = reinterpret_cast<size_t*>( &list1 );
        for( unsigned int i=0, n=sizeof(list1)/sizeof(size_t); i<n; ++i )
        {
            std::cout << "list1  ptr_size_t_tmp[" << i << "]=" << ptr_size_t_tmp[i] << ", this=" << (size_t)( &list1 ) << std::endl;
            continue;
        }
        std::cout << std::endl;
    }

    {
        std::string  string1;
        const size_t *ptr_size_t_tmp = reinterpret_cast<size_t*>( &string1 );
        for( unsigned int i=0, n=sizeof(string1)/sizeof(size_t); i<n; ++i )
        {
            std::cout << "string1  ptr_size_t_tmp[" << i << "]=" << ptr_size_t_tmp[i] << ", this=" << (size_t)( &string1 ) << std::endl;
            continue;
        }
        std::cout << std::endl;
    }


list1  ptr_size_t_tmp[0]=140723878045216, this=140723878045216
list1  ptr_size_t_tmp[1]=140723878045216, this=140723878045216
list1  ptr_size_t_tmp[2]=0, this=140723878045216

string1  ptr_size_t_tmp[0]=140723878045264, this=140723878045248
string1  ptr_size_t_tmp[1]=0, this=140723878045248
string1  ptr_size_t_tmp[2]=0, this=140723878045248
string1  ptr_size_t_tmp[3]=4208509, this=140723878045248
```



对于非std标准的一些用户库, 如果一定要设计成无法在空对象中识别的T对象, 确实也是有这种可能性的, 一种办法是使用模板特化定义, 直接定义类型 USER_CLASS1 的特化版本, 也可以关闭掉优化, 来适应各种情况

template<>

bool vector<USER_CLASS1>::d_bool_use_memmove = false;

编辑于 2019-06-30 16:40

C++

C++ 标准库

STL

赞同 210

39 条评论

分享