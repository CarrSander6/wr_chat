package com.bx.implatform.service;



import com.bx.implatform.dto.WithdrawDTO;
import com.bx.implatform.entity.UserWithdrawal;

import java.util.Collection;
import java.util.List;

/**
 * 用户提现记录Service接口
 *
 * @author Blue
 * @date 2025-08-27
 */
public interface UserWithdrawalService {


    void withdraw(WithdrawDTO dto);

    List<UserWithdrawal> queryUserWithdrawPageList(Integer pageNum, Integer pageSiz);
}
