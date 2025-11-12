package com.bx.implatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.bx.implatform.entity.UserRecharge;
import com.bx.implatform.mapper.UserRechargeMapper;
import com.bx.implatform.service.UserRechargeService;
import com.bx.implatform.session.SessionContext;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 用户充值记录Service业务层处理
 *
 * @author Blue
 * @date 2025-08-27
 */
@RequiredArgsConstructor
@Service
public class UserRechargeServiceImpl implements UserRechargeService {

    private final UserRechargeMapper baseMapper;


    @Override
    public List<UserRecharge> queryUserRechargePageList(Integer pageNum, Integer pageSiz) {
        LambdaQueryWrapper<UserRecharge> lqw = Wrappers.<UserRecharge>lambdaQuery().eq(UserRecharge::getUserId, SessionContext.getSession().getUserId());
        lqw.orderByDesc(UserRecharge::getCreateTime);
        Page<UserRecharge> userRechargePage = baseMapper.selectPage(new Page<>(pageNum, pageSiz), lqw);
        return userRechargePage.getRecords();
    }
}
