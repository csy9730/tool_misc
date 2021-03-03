# interface


显然可以发现，golang的struct和interface，和c语言的struct，c++的class有区别。

golang的struct 和 C的struct比较接近，不能携带方法/函数，只能保存数据。

interface 和 c++ 的虚函数接口比较接近，可以携带可以表达多态的函数/方法，但是不能携带数据。

golang 支持吧 struct和interface两者结合，实现类似class的效果，又有更高的自由度。

**Q**: 接口和继承的区别？

**A**: 
## demo
``` go
package main

import (
    "fmt"
)

type Phone interface {
    call()
}

type NokiaPhone struct {
}

func (nokiaPhone NokiaPhone) call() {
    fmt.Println("I am Nokia, I can call you!")
}

type IPhone struct {
}

func (iPhone IPhone) call() {
    fmt.Println("I am iPhone, I can call you!")
}

func main() {
    var phone Phone

    phone = new(NokiaPhone)
    phone.call()

    phone = new(IPhone)
    phone.call()

}
```