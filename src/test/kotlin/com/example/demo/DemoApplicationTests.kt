package com.example.demo

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.springframework.boot.test.context.SpringBootTest

@SpringBootTest
class DemoApplicationTests {

    @Test
    fun testIncrement() {
        // Given
        val number = 5

        // When
        val result = number + 1

        // Then
        assertEquals(7, result)
    }
}
