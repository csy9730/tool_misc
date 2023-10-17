# [C++ std::string写时复制与深浅拷贝](https://www.cnblogs.com/anhongyu/p/14108117.html)

很久以前就了解过std::string的写时复制(copy on write)优化，但和深浅拷贝放到一起的时候，就不是那么直截了当了。

 

std::string到底是深拷贝还是浅拷贝呢？网上两种说法都有，我的理解是：深拷贝。



``` cpp
// copy on write
static void TestStringCopyCase1() {
    std::string a = "Hello World";
    std::string b = a;
    printf("pointer of a: %p\n", a.c_str());
    printf("pointer of b: %p\n", b.c_str());
}

// copy on write
static void TestStringCopyCase2() {
    std::string a = "Hello World";
    std::string b = a;
    printf("pointer of a: %p\n", a.c_str());
    printf("pointer of b: %p\n", b.c_str());
    b[0] = 'h';
    // b += "!";
    printf("pointer of a: %p\n", a.c_str());
    printf("pointer of b: %p\n", b.c_str());
    std::cout << a << std::endl;
    std::cout << b << std::endl;
}

// output:
pointer of a: 0x1144028
pointer of b: 0x1144028
pointer of a: 0x1144028
pointer of b: 0x1144028
pointer of a: 0x1144028
pointer of b: 0x1144058
Hello World
hello World
```



这两个case很明确地证明std::string是深拷贝的，对副本的修改不会影响到原件。只不过，在修改副本之前，它们的c_str()指针是指向同一地址的，只有在尝试写入的时候，才会区分开来。

具体的实现方法，是对数据块进行了引用计数，尝试修改的时候，引用计数不为1，就要复制再修改。

那么这里就隐藏了一个空子，如果绕过引用计数，直接修改原始数据，会怎样？



```
// misuse: modify b, but a is effected.
static void TestStringCopyCase3() {
    std::string a = "Hello World";
    std::string b = a;
    char* char_array = (char *)b.c_str();
    char_array[0] = 'h';
    printf("pointer of a: %p\n", a.c_str());
    printf("pointer of b: %p\n", b.c_str());
    std::cout << a << std::endl;
    std::cout << b << std::endl;
}

// output:
pointer of a: 0x1144028
pointer of b: 0x1144028
hello World
hello World
```



修改副本，导致原件也被修改。是一个容易引起错误的地方。

如何避免呢？



```
// deep copy to avoid misuse
static void TestStringCopyCase4() {
    std::string a = "Hello World";
    std::string b = a.c_str(); // deep copy
    char* char_array = (char *)b.c_str();
    char_array[0] = 'h';
    printf("pointer of a: %p\n", a.c_str());
    printf("pointer of b: %p\n", b.c_str());
    std::cout << a << std::endl;
    std::cout << b << std::endl;
}

// output:
pointer of a: 0x1144028
pointer of b: 0x1144058
Hello World
hello World
```



复制的时候，直接复制源数据，绕开写时复制。这就给人一种**错觉**，好像std::string的拷贝函数是浅拷贝，需要刻意深拷贝。

**结论：**

**如果使用std::string本身的成员函数或者操作符来操作std::string，它本身就是深拷贝的；**

**如果使用指针直接操作std::string源数据，会绕过“写时复制”机制，需要主动deep copy，以避免数据误写。**

标签: [C/C++](https://www.cnblogs.com/anhongyu/tag/C%2FC%2B%2B/)