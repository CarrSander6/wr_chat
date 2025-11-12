package com.bx.implatform.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bx.implatform.entity.User;
import com.bx.implatform.entity.UserFundDetail;

public interface UserFundDetailMapper extends BaseMapper<UserFundDetail> {

    default UserFundDetail queryByTxHash(String txHash) {
        return selectOne(Wrappers.<UserFundDetail>lambdaQuery().eq(UserFundDetail::getTxHash, txHash));
    }
}
