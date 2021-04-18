# go-lang


## 语法特性

### var
变量类型：类型与c++类似，
主要有布尔类型，整型，浮点型，字符串类型，复合类型。
整型支持多种长度的整型。类型名称与c语言的名称相同
* int/uint
* int8/uint8
* int16/uint16
* int32/uint32
* int64/uint64

``` go
package main

import "fmt"

func main() {
    var i int
    var f float64
    var b bool
    var s string
    fmt.Printf("%v %v %v %q\n", i, f, b, s)
}
```


`var identifier1, identifier2 type`
这种定义方式，与js语言类似又不同，类型后置，名称前置。

复合类型：
``` go
var a *int
var a []int
var a map[string] int
var a chan int
var a func(string) int
```

通过自动推定，省略类型名
``` go
package main
import "fmt"
func main() {
    var d = true
    fmt.Println(d)
}
```

通过使用操作符`:=`结合新变量自动推定，省略var
这种不带声明格式的只能在函数体中出现
``` go
package main
import "fmt"
func main() {
    f := "Hello" // var f string = "Hello"

    fmt.Println(f)
}
```

变量块声明
``` go
// 这种因式分解关键字的写法一般用于声明全局变量
var (
    vname1 v_type1
    vname2 v_type2
)
```

var 创建变量
删除变量 （略）
更新变量 赋值=
读取变量 
#### 变量作用域

函数内定义的变量称为局部变量
函数外定义的变量称为全局变量
函数定义中的变量称为形式参数


#### 指针
``` go
func main() {
   var a int = 10  

   fmt.Printf("变量的地址: %x\n", &a  )
}
```

``` go
var ip *int        /* 指向整型*/
var fp *float32    /* 指向浮点型 */
```

### 容器
迭代数组(array)、切片(slice)、通道(channel)或集合(map)

#### 数组

例如以下定义了数组 balance 长度为 10 类型为 float32：
``` go
var balance [10] float32
```

数组元素可以通过索引（位置）来读取。格式为数组名后加中括号，中括号中为索引的值。例如：
``` go
var salary float32 = balance[9]
```
#### 切片
Go 语言切片是对数组的抽象。

Go 数组的长度不可改变，在特定场景中这样的集合就不太适用，Go 中提供了一种灵活，功能强悍的内置类型切片("动态数组")，与数组相比切片的长度是不固定的，可以追加元素，在追加时可能使切片的容量增大。
##### 范围(Range)
Go 语言中 range 关键字用于 for 循环中迭代数组(array)、切片(slice)、通道(channel)或集合(map)的元素。在数组和切片中它返回元素的索引和索引对应的值，在集合中返回 key-value 对。

range类似迭代器？
#### map

### struct
``` go
type struct_variable_type struct {
   member definition
   member definition
   ...
   member definition
}
```

### 操作符
#### 类型转换
### 表达式
### 语句
#### 控制语句

### 接口

#### error interface
### function
#### argument
函数如果使用参数，该变量可称为函数的形参。

形参就像定义在函数体内的局部变量。

调用函数，可以通过两种方式来传递参数：


值传递	值传递是指在调用函数时将实际参数复制一份传递到函数中，这样在函数中如果对参数进行修改，将不会影响到实际参数。
引用传递	引用传递是指在调用函数时将实际参数的地址传递到函数中，那么在函数中对参数所进行的修改，将影响到实际参数。
#### 2
默认情况下，Go 语言使用的是值传递，即在调用过程中不会影响到实际参数。

函数支持接收者作为特殊参数。
接收者可以是形参（修改副本），指针（原址操作）
接收者既能为值又能为指针


## misc
#### iota
#### chan
#### Select

我们上面介绍的都是只有一个channel的情况，那么如果存在多个channel的时候，我们该如何操作呢，Go里面提供了一个关键字select，通过select可以监听channel上的数据流动。

select默认是阻塞的，只有当监听的channel中有发送或接收可以进行时才会运行，当多个channel都准备好的时候，select是随机的选择一个执行的。