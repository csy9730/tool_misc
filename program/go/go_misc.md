# go-lang


## 语法特性


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
```
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

#### iota

### function

函数支持接收者作为特殊参数。
接收者可以是形参（修改副本），指针（原址操作）
接收者既能为值又能为指针
