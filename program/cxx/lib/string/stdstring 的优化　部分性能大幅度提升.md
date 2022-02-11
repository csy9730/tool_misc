# std::string 的优化　部分性能大幅度提升

[![郭忠明](https://pic1.zhimg.com/da8e974dc_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/guo-zhong-ming-26)

[郭忠明](https://www.zhihu.com/people/guo-zhong-ming-26)

C++库开发 内存分配库 www.haisql.cn

123 人赞同了该文章

std::string 是C++领域最常用的一个组件, 很多软件公司内部都有实现一个优化版本的string, 典型的就是facebook folly中的fbstring, 各种介绍很多了.

facebook find使用了略复杂一点点的boyer_moore算法(1977年发明,后续还有不少类似的改进算法horspool, sunday(1999年发布)，two way)等字符串搜索算法，facebook宣传是比std库的string::　find字符串搜索性能提升超过30倍，各种算法论文和代码到处都是，几乎各家公司的自研string库都有一个非常夸张的比std库的 string::find 字符串搜索性能提升超过XXX倍的宣传，极端场景下都是N倍的性能提升，极大的提高了算法工程师的面子．

std::string基础数据结构不合理, 一些场景下会有不可思议的BUG：不应该是char为基础的容器，内部早就应该改为unsigned char(byte)了，一个是可以直接进行二进制比较，一个是在一些特殊场景下很容容易出bug, 例如vector1.at( string1[0] ), 如果第一个字符是'\x81', 本来期望是读取容器第129个内容，但这里会是一个负数转为整数后溢出．

```text
    std::vector<unsigned int>  vector1;
    vector1.resize( 256,  8 );
    std::string  string1;
    string1.resize( 100, '\x81' );
    std::cout << vector1.at( string1[0] ) << std::endl;

terminate called after throwing an instance of 'std::out_of_range'
  what():  vector::_M_range_check: __n (which is 18446744073709551489) >= this->size() (which is 256)
已放弃 (核心已转储)
```

自研版本的string是unsigned char为基础的容器, 可以进行二进制比较性能高，不容易出BUG．

没有使用SSO优化：公司内部实现的 haisql::string 与其他公司的差异比较大, 主要是公司目前有不少代码是服务于嵌入式环境的, 因此, 需要根据嵌入式的要求进行定制化开发, 主要是要降低内存占用, 因此, 我们没有使用SSO短字符优化．

没有使用COW优化：由于公司有高性能的共享指针shared_ptr和单线程版本的local-ptr,　比现有的std库的版本快很多，开销很小，很多场合下大量使用shared-ptr<string>和local-ptr<string>, 可以完全避免字符串拷贝，所以在string中没有必要使用COW实现长字符避免拷贝优化，只需要使用最简单的earger-copy就以了，因此，实现这样一个覆盖std::string全部功能点的earger-copy　string, 开发难度并不大．

主要的优化场景是：

１）自身内存占用空间的优化：没有SSO, 并且数据结构中capacity和size是unsigned int, 在64bit下是16字节(对比std::string的32字节，大约节约了一半大小)．另外，字符串的空间扩展是1.5倍扩展，最差的场景下最多浪费５０％空间，依次是8,12,16,24,32,48,64,96,128...

２）增加函数resize-no-fill(), 意思是扩展大小时不进行填充，在一些场合下代替resize(), 减少不必要的memset的次数．典型的就是直接用string1.resize-no-fill(4096), 然后将string1作为TCP/IP的接收缓冲区，直接接收数据，实现zero-copy赋值.

３）append的优化：用realloc代替malloc, 使用realloc的方式申请内存扩展空间，而不是使用常规的malloc的方式申请内存，这样在很多情况扩展时都不用拷贝数据，大幅度提升了性能．这块的实际性能提升倍数取决于能够连续多少次在原地址处申请扩展内存成功，只要在原地址处能够成功扩展空间，就不需要移动数据了，大大节约了开销．测试用例大约提升了一倍性能．

Linux 下memcpy, memchr, memmem , memmove, memcpy是性能良好的内嵌汇编的实现，性能和算法都很棒。测试开发机ubuntu1604，linux4.4版本，glibc2.23版本。

４) copy字符串的优化：用memcpy, 在intel旧款CPU上测试性能有不小的提升，在Intel九代以后CPU上测试已经没有性能提升了．

５）find单字符的优化：用memchr，测试用例性能提升了大约10%．

rfind单字符的优化：用memrchr，测试用例性能提升了大约9倍．

６）compare 字符串比较的优化，用memcmp，在Intel九代以后CPU上测试已经没有性能提升了．

７）find字符串的优化：用memmem , two way算法针对长字符串( 457字节中找23字节的查找 ), 测试用例性能提升了大约60%．

rfind字符串的优化：用memrchr + memcmp, 测试用例性能大约提升了４倍．



感谢 @tearshark 指出，由于编译器 gcc 的自动优化，haisql::find(内部对应memchr函数)等函数比std::find函数会有更多的编译器优化，一些代码会被编译器彻底优化掉，导致测试出非常快的结果，但是这种结果只是编译器优化的结果，不能够代表算法的实际性能．

这点上 tearshark 的说法是正确的，在这里给 tearshark 道歉，我前面没有仔细读他文字中实际的意思，武断的认为他用windows测试不能说明问题，错误的直接怼．

这里特地致谢．感谢他指出测试代码的问题．下面的测试结果中，第２组的测试代码 是根据 tearshark 的意见修改测试代码后，得到的更准确的测试结论．

下面是测试代码：

```text
int main( int argc, char* argv[] )
{
    haisql::string  str1 = "sabjhfajwlsekghfuawertfgaeihlsd8950676688888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666-kjfhvasdklfjawsdlfjasdlkdfjsdkjlfahsreitfuewq09yrfweqiofhasdflh;cdslakjfhasldfkfgasdljfhkasdweiuorewqiu78965579000000000000000000000000000086347756859037309890337656789565963475jfasdlhjkfhasdkjfasdfhasdkjljfhaslkjfhasdfhskjfasdkfhqwerfewioruwepodkfs;lfczsdklfgdjsjdf";
    haisql::string  str2 = "sabjhfajwlsekghfuawertfgaeihlsd8950676688888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666-kjfhvas";
    std::string  str1_std( str1.data(), str1.size() );
    std::string  str2_std( str2.data(), str2.size() );

    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            uint_return = str1.compare( str2 );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "haisql compare 1 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }
    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            uint_return = str1_std.compare( str2_std );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "std compare 1 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }

    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            str1[0] = i;
            uint_return = str1.compare( str2 );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "haisql compare 2 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }
    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            str1_std[0] = i;
            uint_return = str1_std.compare( str2_std );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "std compare 2 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }

    {
        char   chars_tmp[1004096];
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            uint_return = str1.copy( &chars_tmp[i], 1000, 0 );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "haisql copy use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }
    {
        char   chars_tmp[1004096];
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            uint_return = str1_std.copy( &chars_tmp[i], 1000, 0 );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "std copy use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }

    {
        haisql::string  str_tmp_haisql;
        std::string  str_tmp_std;
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            for( unsigned int i=0; i<1000000; ++i )
            {
                str_tmp_haisql.append( str2.data(), str2.size() );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "haisql append use=" << ulong2 - ulong1 << ", str_tmp_haisql.size()=" << str_tmp_haisql.size() << std::endl;
        }
        {
            std::string  str_tmp;
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            for( unsigned int i=0; i<1000000; ++i )
            {
                str_tmp_std.append( str2.data(), str2.size() );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "std append use=" << ulong2 - ulong1 << ", str_tmp_std.size()=" << str_tmp_std.size() << std::endl;
        }
        if( str_tmp_haisql != str_tmp_std )
        {
            std::cerr << "Error: append find str_tmp_haisql != str_tmp_std" << std::endl;
        }
    }

    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0, n=1000000; i<n; ++i )
        {
            uint_return = str1.find( 'z', 0 );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "haisql find 1 single char use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }
    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0,n=1000000; i<n; ++i )
        {
            uint_return = str1_std.find( 'z', 0 );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "std find 1 single char use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }

    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0, n=1000000; i<n; ++i )
        {
            str1[0] = i;
            uint_return = str1.find( 'z', 0 );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "haisql find 2 single char use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }
    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0,n=1000000; i<n; ++i )
        {
            str1_std[0] = i;
            uint_return = str1_std.find( 'z', 0 );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "std find 2 single char use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }

    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            uint_return = str1.rfind( '7', haisql::string::npos );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "haisql rfind 1 single char use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }
    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            uint_return = str1_std.rfind( '7', std::string::npos );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "std rfind 1 single char use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }

    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            str1[0] = i;
            uint_return = str1.rfind( '7', haisql::string::npos );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "haisql rfind 2 single char use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }
    {
        unsigned long long ulong1 = haisql::now_steady_nanoseconds();
        unsigned int  uint_return;
        for( unsigned int i=0; i<1000000; ++i )
        {
            str1_std[0] = i;
            uint_return = str1_std.rfind( '7', std::string::npos );
        }
        unsigned long long ulong2 = haisql::now_steady_nanoseconds();
        std::cout << "std rfind 2 single char use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
    }

    {
        const char  chars_find_cmp[] = "uwepodkfs;lfczsdklfgdjs";
        const unsigned int  uint_chars_find_cmp_len = strlen( chars_find_cmp );
        std::cout << "chars_find_cmp=" << chars_find_cmp << ", size=" << strlen( chars_find_cmp ) << std::endl;
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0, n=1000000; i<n; ++i )
            {
                uint_return = str1.find( chars_find_cmp, 0, uint_chars_find_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "haisql find chars 1 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0, n=1000000; i<n; ++i )
            {
                uint_return = str1_std.find( chars_find_cmp, 0, uint_chars_find_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "std find chars 1 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
    }

    {
        const char  chars_find_cmp[] = "uwepodkfs;lfczsdklfgdjs";
        const unsigned int  uint_chars_find_cmp_len = strlen( chars_find_cmp );
        std::cout << "chars_find_cmp=" << chars_find_cmp << ", size=" << strlen( chars_find_cmp ) << std::endl;
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0, n=1000000; i<n; ++i )
            {
                str1[0] = i;
                uint_return = str1.find( chars_find_cmp, 0, uint_chars_find_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "haisql find chars 2 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0, n=1000000; i<n; ++i )
            {
                str1_std[0] = i;
                uint_return = str1_std.find( chars_find_cmp, 0, uint_chars_find_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "std find chars 2 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
    }

    {
        const char  chars_rfind_cmp[] = "ihlsd8950676688";
        const unsigned int  uint_chars_rfind_cmp_len = strlen( chars_rfind_cmp );
        std::cout << "chars_rfind_cmp=" << chars_rfind_cmp << ", size=" << strlen( chars_rfind_cmp ) << std::endl;
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0; i<1000000; ++i )
            {
                uint_return = str1.rfind( chars_rfind_cmp, haisql::string::npos, uint_chars_rfind_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "haisql rfind chars 1 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0; i<1000000; ++i )
            {
                uint_return = str1_std.rfind( chars_rfind_cmp, std::string::npos, uint_chars_rfind_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "std rfind chars 1 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
    }

    {
        const char  chars_rfind_cmp[] = "ihlsd8950676688";
        const unsigned int  uint_chars_rfind_cmp_len = strlen( chars_rfind_cmp );
        std::cout << "chars_rfind_cmp=" << chars_rfind_cmp << ", size=" << strlen( chars_rfind_cmp ) << std::endl;
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0; i<1000000; ++i )
            {
                str1[0] = i;
                uint_return = str1.rfind( chars_rfind_cmp, haisql::string::npos, uint_chars_rfind_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "haisql rfind chars 2 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0; i<1000000; ++i )
            {
                str1_std[0] = i;
                uint_return = str1_std.rfind( chars_rfind_cmp, std::string::npos, uint_chars_rfind_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "std rfind chars 2 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
    }

    {
        const char  chars_find_cmp[] = "uwepodkfs;lfczsdklfgdjsyyyyyyyyyyyyy";
        const unsigned int  uint_chars_find_cmp_len = strlen( chars_find_cmp );
        std::cout << "chars_find_cmp=" << chars_find_cmp << ", size=" << strlen( chars_find_cmp ) << std::endl;
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0; i<1000000; ++i )
            {
                uint_return = str1.find( chars_find_cmp, 0, uint_chars_find_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "haisql not find chars 1 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0; i<1000000; ++i )
            {
                uint_return = str1_std.find( chars_find_cmp, 0, uint_chars_find_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "std not find chars 1 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
    }

    {
        const char  chars_find_cmp[] = "uwepodkfs;lfczsdklfgdjsyyyyyyyyyyyyy";
        const unsigned int  uint_chars_find_cmp_len = strlen( chars_find_cmp );
        std::cout << "chars_find_cmp=" << chars_find_cmp << ", size=" << strlen( chars_find_cmp ) << std::endl;
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0; i<1000000; ++i )
            {
                str1[0] = i;
                uint_return = str1.find( chars_find_cmp, 0, uint_chars_find_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "haisql not find chars 2 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
        {
            unsigned long long ulong1 = haisql::now_steady_nanoseconds();
            unsigned int  uint_return;
            for( unsigned int i=0; i<1000000; ++i )
            {
                str1_std[0] = i;
                uint_return = str1_std.find( chars_find_cmp, 0, uint_chars_find_cmp_len );
            }
            unsigned long long ulong2 = haisql::now_steady_nanoseconds();
            std::cout << "std not find chars 2 use=" << ulong2 - ulong1 << ", uint_return=" << uint_return << std::endl;
        }
    }
    return 0;
}
```



下面是测试结果：（测试是在Intel 九代CPU 9400F CPU下测试）

```text
haisql compare 1 use=717, uint_return=259
std compare 1 use=273316, uint_return=259
haisql compare 2 use=6507342, uint_return=4294967244
std compare 2 use=6507263, uint_return=4294967244
haisql copy use=9935573, uint_return=716
std copy use=10175557, uint_return=716
haisql append use=118106454, str_tmp_haisql.size()=457000000
std append use=294247075, str_tmp_std.size()=457000000
haisql find 1 single char use=254285, uint_return=703
std find 1 single char use=16360362, uint_return=703
haisql find 2 single char use=16373296, uint_return=703
std find 2 single char use=18108375, uint_return=703
haisql rfind 1 single char use=2674, uint_return=625
std rfind 1 single char use=36067572, uint_return=625
haisql rfind 2 single char use=3934429, uint_return=625
std rfind 2 single char use=36521490, uint_return=625
chars_find_cmp=uwepodkfs;lfczsdklfgdjs, size=23
haisql find chars 1 use=252870, uint_return=690
std find chars 1 use=358697371, uint_return=690
chars_find_cmp=uwepodkfs;lfczsdklfgdjs, size=23
haisql find chars 2 use=224280645, uint_return=690
std find chars 2 use=358364787, uint_return=690
chars_rfind_cmp=ihlsd8950676688, size=15
haisql rfind chars 1 use=694768404, uint_return=26
std rfind chars 1 use=2589883891, uint_return=26
chars_rfind_cmp=ihlsd8950676688, size=15
haisql rfind chars 2 use=690769204, uint_return=26
std rfind chars 2 use=2589882886, uint_return=26
chars_find_cmp=uwepodkfs;lfczsdklfgdjsyyyyyyyyyyyyy, size=36
haisql not find chars 1 use=251545, uint_return=4294967295
std not find chars 1 use=341024446, uint_return=4294967295
chars_find_cmp=uwepodkfs;lfczsdklfgdjsyyyyyyyyyyyyy, size=36
haisql not find chars 2 use=180322285, uint_return=4294967295
std not find chars 2 use=339153618, uint_return=4294967295
```



编辑于 2019-09-02

C++

字符串

C++ 标准库

赞同 123