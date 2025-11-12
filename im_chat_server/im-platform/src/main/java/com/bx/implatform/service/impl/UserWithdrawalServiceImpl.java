package com.bx.implatform.service.impl;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.bx.implatform.dto.WithdrawDTO;
import com.bx.implatform.entity.User;
import com.bx.implatform.entity.UserWithdrawal;
import com.bx.implatform.exception.GlobalException;
import com.bx.implatform.mapper.UserMapper;
import com.bx.implatform.mapper.UserWithdrawalMapper;
import com.bx.implatform.service.UserService;
import com.bx.implatform.service.UserWithdrawalService;
import com.bx.implatform.session.SessionContext;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 用户提现记录Service业务层处理
 *
 * @author Blue
 * @date 2025-08-27
 */
@RequiredArgsConstructor
@Service
public class UserWithdrawalServiceImpl implements UserWithdrawalService {

    private final UserWithdrawalMapper baseMapper;
    private final UserMapper userMapper;
    private final UserService userService;

    @Override
    public void withdraw(WithdrawDTO dto) {
        BigDecimal minWithdrawAmount = Convert.toBigDecimal(userMapper.selectConfigByKey("biz.min.withdraw.amount"));
        BigDecimal feeRatio = Convert.toBigDecimal(userMapper.selectConfigByKey("biz.fee.ratio"));
        Long userId = SessionContext.getSession().getUserId();
        User user = userMapper.selectById(userId);
        if (user.getBalance().compareTo(dto.getAmount()) < 0) {
            throw new GlobalException("余额不足");
        }
        if (dto.getAmount().compareTo(minWithdrawAmount) < 0) {
            throw new GlobalException("最小提现金额:" + minWithdrawAmount);
        }

        String orderSn = "TX" + IdUtil.getSnowflakeNextIdStr();

        userService.modifyUserFound(userId,
                orderSn,
                null,
                1,
                -1,
                dto.getAmount(),
                "提现",
                null);

        BigDecimal fee = dto.getAmount().multiply(feeRatio);
        UserWithdrawal userWithdrawal = new UserWithdrawal();
        userWithdrawal.setUserId(userId);
        userWithdrawal.setType(1);
        userWithdrawal.setOrderSn(orderSn);
        userWithdrawal.setAmount(dto.getAmount());
        userWithdrawal.setFeeAmount(fee);
        userWithdrawal.setActualAmount(dto.getAmount().subtract(fee));
        userWithdrawal.setStatus(1);
        userWithdrawal.setFromAddress(user.getWalletAddress());
        userWithdrawal.setCreateTime(new Date());
        userWithdrawal.setUpdateTime(new Date());
        baseMapper.insert(userWithdrawal);
    }

    @Override
    public List<UserWithdrawal> queryUserWithdrawPageList(Integer pageNum, Integer pageSiz) {
        LambdaQueryWrapper<UserWithdrawal> lqw = new LambdaQueryWrapper<>();
        lqw.eq(UserWithdrawal::getUserId, SessionContext.getSession().getUserId());
        lqw.orderByDesc(UserWithdrawal::getCreateTime);
        Page<UserWithdrawal> userWithdrawalPage = baseMapper.selectPage(new Page<>(pageNum, pageSiz), lqw);
        return userWithdrawalPage.getRecords();
    }

}
