# explicit specifier

 

[C++](https://en.cppreference.com/w/cpp)

 

[C++ language](https://en.cppreference.com/w/cpp/language)

 

[Classes](https://en.cppreference.com/w/cpp/language/classes)

 

|                                       |      |               |
| ------------------------------------- | ---- | ------------- |
| `**explicit**`                        | (1)  |               |
|                                       |      |               |
| `**explicit (**` *expression* `**)**` | (2)  | (since C++20) |
|                                       |      |               |

| *expression* | -    | [contextually converted constant expression of type bool](https://en.cppreference.com/w/cpp/language/constant_expression#Converted_constant_expression) |
| ------------ | ---- | ------------------------------------------------------------ |
|              |      |                                                              |

1) Specifies that a constructor or conversion function (since C++11) or [deduction guide](https://en.cppreference.com/w/cpp/language/ctad) (since C++17) is explicit, that is, it cannot be used for [implicit conversions](https://en.cppreference.com/w/cpp/language/implicit_cast) and [copy-initialization](https://en.cppreference.com/w/cpp/language/copy_initialization).

| 2) The explicit specifier may be used with a constant expression. The function is explicit if and only if that constant expression evaluates to true. | (since C++20) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

The explicit specifier may only appear within the *decl-specifier-seq* of the declaration of a constructor or conversion function (since C++11) within its class definition.

### Notes

A constructor with a single non-default parameter (until C++11) that is declared without the function specifier explicit is called a [converting constructor](https://en.cppreference.com/w/cpp/language/converting_constructor).

Both constructors (other than [copy](https://en.cppreference.com/w/cpp/language/copy_constructor)/[move](https://en.cppreference.com/w/cpp/language/move_constructor)) and user-defined conversion functions may be function templates; the meaning of `explicit` doesn't change.

| A `(` token that follows `explicit` is parsed as part of the explicit specifier:`struct S {     explicit (S)(const S&);    // error in C++20, OK in C++17     explicit (operator int)(); // error in C++20, OK in C++17 };` | (since C++20) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

### Example

Run this code

``` cpp
struct A
{
    A(int) { }      // converting constructor
    A(int, int) { } // converting constructor (C++11)
    operator bool() const { return true; }
};
 
struct B
{
    explicit B(int) { }
    explicit B(int, int) { }
    explicit operator bool() const { return true; }
};
 
int main()
{
    A a1 = 1;      // OK: copy-initialization selects A::A(int)
    A a2(2);       // OK: direct-initialization selects A::A(int)
    A a3 {4, 5};   // OK: direct-list-initialization selects A::A(int, int)
    A a4 = {4, 5}; // OK: copy-list-initialization selects A::A(int, int)
    A a5 = (A)1;   // OK: explicit cast performs static_cast
    if (a1) ;      // OK: A::operator bool()
    bool na1 = a1; // OK: copy-initialization selects A::operator bool()
    bool na2 = static_cast<bool>(a1); // OK: static_cast performs direct-initialization
 
//  B b1 = 1;      // error: copy-initialization does not consider B::B(int)
    B b2(2);       // OK: direct-initialization selects B::B(int)
    B b3 {4, 5};   // OK: direct-list-initialization selects B::B(int, int)
//  B b4 = {4, 5}; // error: copy-list-initialization does not consider B::B(int,int)
    B b5 = (B)1;   // OK: explicit cast performs static_cast
    if (b2) ;      // OK: B::operator bool()
//  bool nb1 = b2; // error: copy-initialization does not consider B::operator bool()
    bool nb2 = static_cast<bool>(b2); // OK: static_cast performs direct-initialization
}
```

### See also

- [converting constructor](https://en.cppreference.com/w/cpp/language/converting_constructor)
- [initialization](https://en.cppreference.com/w/cpp/language/initialization)
- [copy initialization](https://en.cppreference.com/w/cpp/language/copy_initialization)
- [direct initialization](https://en.cppreference.com/w/cpp/language/direct_initialization)