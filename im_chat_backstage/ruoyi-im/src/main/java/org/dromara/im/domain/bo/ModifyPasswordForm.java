package org.dromara.im.domain.bo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.io.Serializable;

@Data
public class ModifyPasswordForm implements Serializable {

    /**
     * 用户ID
     */
    @NotNull(message = "用户ID不能为空")
    private Long userId;

    /**
     * 新密码
     */
    @NotNull(message = "新密码不能为空")
    private String password;

    /**
     * 密码类型（1、登录密码 2：交易密码）
     */
    @NotNull(message = "密码类型不能为空")
    private Integer type;
}
