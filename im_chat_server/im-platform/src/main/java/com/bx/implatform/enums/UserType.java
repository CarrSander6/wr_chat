package com.bx.implatform.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserType {
    /**
     * 正常用户
     */
    NORMAL(1),
    /**
     * 公开账户
     */
    OPEN_ACCOUNT(2),

    /**
     * VIP
     */
    VIP(3),

    /**
     * admin
     */
    ADMIN(4),

    ;

    private final Integer value;

}
