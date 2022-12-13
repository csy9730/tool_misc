# namespace



### 定义
命名空间只能全局范围内定义
``` cpp
namespace namespace_name {
   // 代码声明
}
```


``` cpp
using namespace std;
```


### 嵌套的命名空间
命名空间可以嵌套，您可以在一个命名空间中定义另一个命名空间，如下所示：

```cpp

namespace namespace_name1 {
   // 代码声明
   namespace namespace_name2 {
      // 代码声明
   }
}
```

### open
命名空间是开放的，即可以随时把新的成员加入已有的命名空间中(常用).


### 无名命名空间
无名命名空间，意味着命名空间中的标识符只能在本文件内访问，相当于给这个标识符加上了static，使得其可以作为内部连接

### 命名空间别名
给命名空间 取个别名


``` cpp
namespace ublas = boost::numeric::ublas;
ublas::vector<double> v;
```