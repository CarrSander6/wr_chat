package com.bx.implatform.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 响应码枚举
 *
 * @author Blue
 * @date 2020/10/19
 **/
@Getter
@AllArgsConstructor
public enum ResultCode {
    /**
     * 成功
     */
    SUCCESS(200, "成功"),
    /**
     * 未登录
     */
    NO_LOGIN(400, "未登录"),
    /**
     * token无效或已过期
     */
    INVALID_TOKEN(401, "token无效或已过期"),
    /**
     * 系统繁忙，请稍后再试
     */
    PROGRAM_ERROR(500, "系统繁忙，请稍后再试"),
    /**
     * 密码不正确
     */
    PASSWOR_ERROR(10001, "密码不正确"),
    /**
     * 该用户名已注册
     */
    USERNAME_ALREADY_REGISTER(10003, "该用户名已注册"),
    /**
     * 请不要输入非法内容
     */
    XSS_PARAM_ERROR(10004, "请不要输入非法内容"),
    
    // 业务错误码 (10xxx)
    /**
     * 用户不存在
     */
    USER_NOT_FOUND(10005, "用户不存在"),
    /**
     * 参数校验失败
     */
    PARAM_VALIDATION_ERROR(10006, "参数校验失败"),
    /**
     * 操作频繁，请稍后再试
     */
    RATE_LIMIT_ERROR(10007, "操作频繁，请稍后再试"),
    
    // 权限错误码 (20xxx)
    /**
     * 无权限访问
     */
    ACCESS_DENIED(20001, "无权限访问"),
    /**
     * 资源不存在
     */
    RESOURCE_NOT_FOUND(20002, "资源不存在"),
    
    // 数据错误码 (30xxx)
    /**
     * 数据不存在
     */
    DATA_NOT_FOUND(30001, "数据不存在"),
    /**
     * 数据已存在
     */
    DATA_ALREADY_EXISTS(30002, "数据已存在"),
    /**
     * 数据保存失败
     */
    DATA_SAVE_ERROR(30003, "数据保存失败"),
    
    // 缓存错误码 (40xxx)
    /**
     * 缓存异常
     */
    CACHE_ERROR(40001, "缓存异常"),
    
    // 异步处理错误码 (50xxx)
    /**
     * 异步任务执行失败
     */
    ASYNC_TASK_ERROR(50001, "异步任务执行失败");


    private final int code;
    private final String msg;


}

