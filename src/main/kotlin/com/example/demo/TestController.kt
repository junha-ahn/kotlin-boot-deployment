package com.example.demo

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class TestController {
    @GetMapping("/")
    fun `index`(): String {
        println("Hi user")
        return "Hello world!!~~"
    }
}
