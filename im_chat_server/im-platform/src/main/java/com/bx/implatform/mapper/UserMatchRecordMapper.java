package com.bx.implatform.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bx.implatform.entity.UserMatchRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户匹配记录Mapper
 */
@Mapper
public interface UserMatchRecordMapper extends BaseMapper<UserMatchRecord> {

    /**
     * 获取用户未浏览的用户列表
     * @param userId 当前用户ID
     * @param limit 限制数量
     * @return 用户ID列表
     */
    List<Long> getUnviewedUsers(@Param("userId") Long userId, @Param("limit") Integer limit);
}
