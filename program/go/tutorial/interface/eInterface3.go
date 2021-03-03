package main

import (
	"fmt"
	"math"
)

type I interface {
	M()
}

type T struct {
	S string
}

func (t *T) M() {
	fmt.Println(t.S)
}

type F float64

func (f F) M() {
	fmt.Println(f)
}

func main() {
	var i I

	i = &T{"Hello"}
	describe(i)
	i.M()

	i = F(math.Pi)
	describe(i)
	i.M()

	var t2 = T{"world"}
	t2.M()
}

func describe(i I) {
	fmt.Printf("(%v, %T)\n", i, i)
}
// 接口值，似乎是 实例临时转化成接口类，然后直接接口实现函数。
// 作用：是可以单次（临时）执行一次接口