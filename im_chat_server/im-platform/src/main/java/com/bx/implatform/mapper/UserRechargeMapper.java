package com.bx.implatform.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bx.implatform.entity.UserRecharge;


/**
 * 用户充值记录Mapper接口
 *
 * @author Blue
 * @date 2025-08-27
 */
public interface UserRechargeMapper extends BaseMapper<UserRecharge> {

    default UserRecharge queryByTxHash(String txHash) {
        return selectOne(Wrappers.<UserRecharge>lambdaQuery().eq(UserRecharge::getTxHash, txHash));
    }

}
