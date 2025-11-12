package org.dromara.im.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author: Blue
 * @date: 2024-09-06
 * @version: 1.0
 */
@Getter
@AllArgsConstructor
public enum ImComplaintStatus {

    /**
     * 未处理
     */
    NOT_HANDLE(1),
    /**
     * 已处理
     */
    HANDLED(2);

    private final Integer value;

}
