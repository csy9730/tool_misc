# std::nothrow

 [https://en.cppreference.com/w/cpp/memory/new/nothrow](https://en.cppreference.com/w/cpp/memory/new/nothrow)

[C++](https://en.cppreference.com/w/cpp)

 

[Utilities library](https://en.cppreference.com/w/cpp/utility)

 

[Dynamic memory management](https://en.cppreference.com/w/cpp/memory)

 

[Low level memory management](https://en.cppreference.com/w/cpp/memory/new)

 

| Defined in header `<new>`                                    |      |      |
| ------------------------------------------------------------ | ---- | ---- |
| extern const [std::nothrow_t](http://en.cppreference.com/w/cpp/memory/new/nothrow_t) nothrow; |      |      |
|                                                              |      |      |

`std::nothrow` is a constant of type [std::nothrow_t](https://en.cppreference.com/w/cpp/memory/new/nothrow_t) used to disambiguate the overloads of throwing and non-throwing [allocation functions](https://en.cppreference.com/w/cpp/memory/new/operator_new).

### Example

Run this code

```cpp
#include <iostream>
#include <new>
 
int main()
{
    try {
        while (true) {
            new int[100000000ul];   // throwing overload
        }
    } catch (const std::bad_alloc& e) {
        std::cout << e.what() << '\n';
    }
 
    while (true) {
        int* p = new(std::nothrow) int[100000000ul]; // non-throwing overload
        if (p == nullptr) {
            std::cout << "Allocation returned nullptr\n";
            break;
        }
    }
}
```

Output:

```
std::bad_alloc
Allocation returned nullptr
```