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
public enum ImComplaintTargetType {

    /**
     * 用户
     */
    USER(1),
    /**
     * 群聊
     */
    GROUP(2);

    private final Integer value;

}
