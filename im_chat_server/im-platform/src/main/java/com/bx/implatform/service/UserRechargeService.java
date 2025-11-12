package com.bx.implatform.service;

import com.bx.implatform.entity.UserRecharge;

import java.util.Collection;
import java.util.List;

/**
 * 用户充值记录Service接口
 *
 * @author Blue
 * @date 2025-08-27
 */
public interface UserRechargeService {

    List<UserRecharge> queryUserRechargePageList(Integer pageNum, Integer pageSiz);

}
