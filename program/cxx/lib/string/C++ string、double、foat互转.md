# C++ string、double、foat互转

[![飞鹏](https://picx.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=172ae18b)](https://www.zhihu.com/people/peng-fei-96-8)

[飞鹏](https://www.zhihu.com/people/peng-fei-96-8)

## C++ string to float and double Conversion

The easiest way to convert a string to a floating-point number is by using these **C++11** functions:

- **std::stof()** - convert `string` to `float`
- **std::stod()** - convert `string` to `double`
- **std::stold()** - convert `string` to `long double`.

### Example 1: C++ string to float and double

```cpp
#include <iostream>
#include <string>

int main() {
    std::string str = "123.4567";

    // convert string to float
    float num_float = std::stof(str);

    // convert string to double
    double num_double = std::stod(str);

   std:: cout<< "num_float = " << num_float << std::endl;
   std:: cout<< "num_double = " << num_double << std::endl;

    return 0;
}
```

### Example 2: C++ char Array to double

We can convert a `char` array to `double` by using the `std::atof()` function.

```cpp
#include <iostream>

// cstdlib is needed for atoi()
#include <cstdlib>

int main() {

    // declaring and initializing character array
    char str[] = "123.4567";

    double num_double = std::atof(str);

    std::cout << "num_double = " << num_double << std::endl;
    
    return 0;
}
```

### Example 3: float and double to string Using to_string()

```cpp
#include <iostream>
#include <string>

int main() {
    float num_float = 123.4567F;
    double num_double = 123.4567;

    std::string str1 = std::to_string(num_float);
    std::string str2 = std::to_string(num_double);

   std::cout << "Float to String = " << str1 << std::endl;
   std::cout << "Double to String = " << str2 << std::endl;

    return 0;
}
```

### Example 4: float and double to string Using stringstream

```cpp
#include <iostream>
#include<string>
#include<sstream> // for using stringstream

int main() {
    float num_float = 123.4567F;
    double num_double = 123.4567;
  
    // creating stringstream objects
    std::stringstream ss1;
    std::stringstream ss2;
  
    // assigning the value of num_float to ss1
    ss1 << num_float;
  
    // assigning the value of num_float to ss2
    ss2 << num_double;

    // initializing two string variables with the values of ss1 and ss2
    // and converting it to string format with str() function
    std::string str1 = ss1.str();
    std::string str2 = ss2.str();
  
    std::cout << "Float to String = " << str1 << std::endl;
    std::cout << "Double to String = " << str2 << std::endl;

    return 0;
}
```



发布于 2023-04-06 20:09・IP 属地北京

[C++](https://www.zhihu.com/topic/19584970)

[Modern C++](https://www.zhihu.com/topic/20744506)

[C++ 标准](https://www.zhihu.com/topic/19621071)