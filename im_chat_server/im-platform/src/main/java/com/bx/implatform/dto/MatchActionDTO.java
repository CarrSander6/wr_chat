package com.bx.implatform.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 匹配操作DTO
 */
@Data
public class MatchActionDTO {

    /**
     * 目标用户ID
     */
    @NotNull(message = "目标用户ID不能为空")
    private Long targetUserId;

    /**
     * 操作类型: 1-喜欢 2-不喜欢
     */
    @NotNull(message = "操作类型不能为空")
    private Integer actionType;
}
