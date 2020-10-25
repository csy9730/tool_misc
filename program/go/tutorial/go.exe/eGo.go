package main

import (
	"fmt"
	"time"
)

func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}

func main() {
	go say("world")
	say("hello")
	say("!")
	fmt.Println("end")
}
/*
	go 的行为类似生成器，不能立即启动，需要发送一次参数。
*/