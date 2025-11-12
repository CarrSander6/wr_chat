package com.bx.implatform.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
@Schema(description = "设置密码DTO")
public class SetPasswordDTO {

    @NotEmpty(message = "交易密码不可为空")
    @Schema(description = "交易密码")
    private String tradePassword;

}
