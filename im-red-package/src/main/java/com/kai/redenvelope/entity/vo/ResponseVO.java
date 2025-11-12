package com.kai.redenvelope.entity.vo;

import com.kai.redenvelope.enums.StatusCode;
import lombok.Data;

/**
 * @author kai
 * @version 1.0
 * @date 2024/10/14
 * @Description
 */
/*响应信息类*/
@Data
public class ResponseVO<T> {
    private Integer code;
    private String msg;
    private T data;

    public ResponseVO(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }


    public ResponseVO(StatusCode statusCode) {
        this.code = statusCode.getCode();
        this.msg = statusCode.getMsg();
    }

    public ResponseVO(Integer code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
}
