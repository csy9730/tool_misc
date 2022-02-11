# c字符串

``` c++
// const_header.h
#ifndef CONST_HEADER_H_ 
#define CONST_HEADER_H_ 

const char* CONST_STRING = "wangqi";        // 错误！指针 CONST_STRING 并非 const 常量，所以该头文件
                                            //      被多个文件包含时，会有变量重复定义的编译错误。

const char* const CONST_STRING = "wangqi";  // 正确，CONST_STRING 是指向常量的常量指针。
const char CONST_STRING[] = "wangqi";       // 正确，CONST_STRING 是 const char [7] 类型。 
char* const CONST_STRING = "wangqi";        // 正确，CONST_STRING 是常量指针。
#define CONST_STRING "wangqi";              // 正确，传统用法。

static char CONST_STRING[] = "wangqi";      // 正确
static char* CONST_STRING = "wangqi"; 
static const char* CONST_STRING = "wangqi"; // 正确

namespace // 正确
{
    char CONST_STRING[] = "wangqi"; 
}

namespace // 正确
{
    char* CONST_STRING = "wangqi"; 
}

namespace // 正确
{
    const char* CONST_STRING = "wangqi"; 
}

#endif // CONST_HEADER_H_ 


```