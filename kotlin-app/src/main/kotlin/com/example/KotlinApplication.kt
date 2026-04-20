package com.example

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@SpringBootApplication
class KotlinApplication

fun main(args: Array<String>) {
    runApplication<KotlinApplication>(*args)
}

@RestController
class KotlinController {
    @GetMapping("/")
    fun getMessage(): Map<String, String> {
        return mapOf(
            "message" to "Hello from Kotlin API",
            "version" to "1.0.0"
        )
    }

    @GetMapping("/health")
    fun getHealth(): Map<String, String> {
        val hostname = java.net.InetAddress.getLocalHost().hostName
        return mapOf(
            "status" to "healthy",
            "hostname" to hostname
        )
    }
}
