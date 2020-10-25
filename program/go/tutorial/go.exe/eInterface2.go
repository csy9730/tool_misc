package main

import (
    "fmt"
)

type Phone interface {
    call()
    ring()
}

type NokiaPhone struct {
}

func (nokiaPhone NokiaPhone) call() {
    fmt.Println("I am Nokia, I can call you!")
}

func (nokiaPhone NokiaPhone) ring() {
    fmt.Println("I am Nokia, I can ring you!")
}

type IPhone struct {
}

func (iPhone IPhone) call() {
    fmt.Println("I am iPhone, I can call you!")
}

func (iPhone IPhone) ring() {
    fmt.Println("I am iPhone, I can ring you!")
}

func main() {
    var phone Phone

    phone = new(NokiaPhone)
    phone.call()
    phone.ring()

    phone = new(IPhone)
    phone.call()

}