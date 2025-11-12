package com.kai.redenvelope;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.kai.redenvelope.Mapper")
public class RedisRedEnvelopeApplication {

    public static void main(String[] args) {
        SpringApplication.run(RedisRedEnvelopeApplication.class, args);
    }

}
