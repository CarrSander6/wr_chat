package com.bx.implatform.e2e;

import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

/**
 * E2E测试基类
 * 
 * @author Blue
 * @date 2024
 */
@SpringBootTest
@AutoConfigureMockMvc
public abstract class E2ETestBase {

    @Autowired
    protected MockMvc mockMvc;

    @BeforeEach
    public void setUp() {
        // 测试前的准备工作
    }

    /**
     * 获取测试用户token
     */
    protected String getTestUserToken() {
        // 模拟获取测试用户token
        return "test-token";
    }
}
