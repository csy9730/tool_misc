package com.example.demo2.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
	
    @RequestMapping("/")
    public String index() {
        return "Hello Spring Boot 2!";
    }

    @RequestMapping("/hello")
    public String index2() {
        return "Hello world!";
    }
}