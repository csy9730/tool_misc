# new

new 的行为和malloc类似。

- new包含内存分配和对象构造两部分，malloc只含有内存分配
- new是c++关键字，malloc是c库。new的实现内置在编译器里，优先级更高。
- new支持placement new
- new支持 operator new
- new支持new[]，operator new[]
- new 和delete配对， malloc()和free()配对

### new[]
### operator new
### placement new
placement new

使用placement new-expression时，必须`#include<new>`
``` cpp
#include<new>
typedef struct Foo{
    int a;
    int b;
}Foo;
Foo foo;
int *ptr = new(&foo) Foo;
```

行为大概类似：
``` cpp
Foo foo;
int *ptr = &foo;
fooInit(ptr);
```