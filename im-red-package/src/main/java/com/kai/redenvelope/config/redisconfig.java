package com.kai.redenvelope.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

/**
 * @author kai
 * @version 1.0
 * @date 2024/10/14
 * @Description
 */
@Configuration
public class redisconfig {

    @Autowired
    private RedisConnectionFactory redisConnectionFactory;



    //缓存操作组件RedisTemplate的自定义配置
    @Bean
    public RedisTemplate<String,Object> redisTemplate() {
        //定义RedisTemplate实例
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        System.out.println("redis初始化-----------------------");
        //设置Redis的链接工厂
        redisTemplate.setConnectionFactory(redisConnectionFactory);

        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new GenericJackson2JsonRedisSerializer());

        redisTemplate.setHashKeySerializer(new StringRedisSerializer());

        return redisTemplate;
    }

    //缓存操作StringRedisTemplate
    @Bean
    public StringRedisTemplate stringRedisTemplate() {

        //先采用默认配置，后续补充
        StringRedisTemplate stringRedisTemplate = new StringRedisTemplate();
        stringRedisTemplate.setConnectionFactory(redisConnectionFactory);

        return stringRedisTemplate;
    }
}
