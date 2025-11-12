package com.bx.implatform.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bx.implatform.entity.User;
import com.bx.implatform.entity.UserFundDetail;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface UserMapper extends BaseMapper<User> {

    default User queryByWalletAddress(String walletAddress) {
        return selectOne(Wrappers.<User>lambdaQuery().eq(User::getWalletAddress, walletAddress));
    }

    /**
     * 查询加锁
     */
    default User queryByUserIdLock(Long userId) {
        return selectOne(Wrappers.<User>lambdaQuery().eq(User::getId, userId).last(" for update"));
    }

    @Select("select config_value from sys_config WHERE config_key = #{key}")
    String selectConfigByKey(@Param("key") String key);

    @Select("select * from im_user_fund_detail where user_id = #{userId} order by id desc limit #{offset},#{pageSize}")
    List<UserFundDetail> queryUerFoundDetail(@Param("offset") Integer offset, @Param("pageSize") Integer pageSize, @Param("userId") Long userId);

}
