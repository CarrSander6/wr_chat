package com.bx.implatform.service.impl;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bx.implatform.dto.ActivateDistributorDTO;
import com.bx.implatform.dto.CommissionWithdrawDTO;
import com.bx.implatform.entity.DistributionCommission;
import com.bx.implatform.entity.DistributionUser;
import com.bx.implatform.entity.User;
import com.bx.implatform.exception.GlobalException;
import com.bx.implatform.mapper.DistributionCommissionMapper;
import com.bx.implatform.mapper.DistributionUserMapper;
import com.bx.implatform.mapper.UserMapper;
import com.bx.implatform.service.DistributionService;
import com.bx.implatform.service.UserWithdrawalService;
import com.bx.implatform.session.SessionContext;
import com.bx.implatform.session.UserSession;
import com.bx.implatform.vo.DistributorVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 分销服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class DistributionServiceImpl extends ServiceImpl<DistributionUserMapper, DistributionUser> implements DistributionService {

    private final DistributionUserMapper distributionUserMapper;
    private final DistributionCommissionMapper commissionMapper;
    private final UserMapper userMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String activateDistributor(ActivateDistributorDTO dto) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        // Check if already a distributor
        LambdaQueryWrapper<DistributionUser> checkWrapper = new LambdaQueryWrapper<>();
        checkWrapper.eq(DistributionUser::getUserId, userId);
        DistributionUser existing = distributionUserMapper.selectOne(checkWrapper);

        if (existing != null && existing.getStatus() == 1) {
            throw new GlobalException("您已经是分销商了");
        }

        // Get parent distributor if referral code provided
        Long parentUserId = null;
        Long grandParentUserId = null;
        if (StrUtil.isNotBlank(dto.getReferralCode())) {
            parentUserId = getUserIdByReferralCode(dto.getReferralCode());
            if (parentUserId != null) {
                // Get grandparent
                LambdaQueryWrapper<DistributionUser> parentWrapper = new LambdaQueryWrapper<>();
                parentWrapper.eq(DistributionUser::getUserId, parentUserId);
                DistributionUser parentDist = distributionUserMapper.selectOne(parentWrapper);
                if (parentDist != null) {
                    grandParentUserId = parentDist.getParentUserId();
                }
            }
        }

        // Generate referral code
        String referralCode = generateReferralCode(userId);

        if (existing == null) {
            // Create new distributor
            DistributionUser distributor = new DistributionUser();
            distributor.setUserId(userId);
            distributor.setReferralCode(referralCode);
            distributor.setParentUserId(parentUserId);
            distributor.setGrandParentUserId(grandParentUserId);
            distributor.setStatus(1); // Activated
            distributor.setTotalCommission(BigDecimal.ZERO);
            distributor.setAvailableCommission(BigDecimal.ZERO);
            distributor.setWithdrawnCommission(BigDecimal.ZERO);
            distributor.setActivatedTime(new Date());
            distributor.setCreatedTime(new Date());
            distributor.setUpdatedTime(new Date());
            distributionUserMapper.insert(distributor);
        } else {
            // Update existing distributor
            existing.setStatus(1);
            existing.setReferralCode(referralCode);
            existing.setParentUserId(parentUserId);
            existing.setGrandParentUserId(grandParentUserId);
            existing.setActivatedTime(new Date());
            existing.setUpdatedTime(new Date());
            distributionUserMapper.updateById(existing);
        }

        log.info("User {} activated as distributor with code {}", userId, referralCode);
        return referralCode;
    }

    @Override
    public DistributorVO getDistributorInfo() {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        LambdaQueryWrapper<DistributionUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(DistributionUser::getUserId, userId);
        DistributionUser distributor = distributionUserMapper.selectOne(queryWrapper);

        if (distributor == null) {
            throw new GlobalException("您还不是分销商");
        }

        DistributorVO vo = new DistributorVO();
        vo.setUserId(userId);
        vo.setReferralCode(distributor.getReferralCode());
        vo.setStatus(distributor.getStatus());
        vo.setTotalCommission(distributor.getTotalCommission() != null ? distributor.getTotalCommission() : BigDecimal.ZERO);
        vo.setAvailableCommission(distributor.getAvailableCommission() != null ? distributor.getAvailableCommission() : BigDecimal.ZERO);
        vo.setWithdrawnCommission(distributor.getWithdrawnCommission() != null ? distributor.getWithdrawnCommission() : BigDecimal.ZERO);
        vo.setActivatedTime(distributor.getActivatedTime());

        // Count referrals
        LambdaQueryWrapper<DistributionUser> level1Wrapper = new LambdaQueryWrapper<>();
        level1Wrapper.eq(DistributionUser::getParentUserId, userId);
        vo.setLevel1Count(Math.toIntExact(distributionUserMapper.selectCount(level1Wrapper)));

        LambdaQueryWrapper<DistributionUser> level2Wrapper = new LambdaQueryWrapper<>();
        level2Wrapper.eq(DistributionUser::getGrandParentUserId, userId);
        vo.setLevel2Count(Math.toIntExact(distributionUserMapper.selectCount(level2Wrapper)));

        return vo;
    }

    @Override
    public List<DistributionCommission> getCommissionList(Integer pageNum, Integer pageSize) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize <= 0) {
            pageSize = 20;
        }

        Page<DistributionCommission> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<DistributionCommission> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(DistributionCommission::getDistributorUserId, userId)
                .orderByDesc(DistributionCommission::getCreatedTime);

        Page<DistributionCommission> commissionPage = commissionMapper.selectPage(page, queryWrapper);
        return commissionPage.getRecords();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void withdrawCommission(CommissionWithdrawDTO dto) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        // Verify trade password
        User user = userMapper.selectById(userId);
        if (user.getTradePassword() == null || !user.getTradePassword().equals(dto.getTradePassword())) {
            throw new GlobalException("交易密码错误");
        }

        // Get distributor info
        LambdaQueryWrapper<DistributionUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(DistributionUser::getUserId, userId);
        DistributionUser distributor = distributionUserMapper.selectOne(queryWrapper);

        if (distributor == null) {
            throw new GlobalException("您还不是分销商");
        }

        BigDecimal availableCommission = distributor.getAvailableCommission() != null ? distributor.getAvailableCommission() : BigDecimal.ZERO;
        if (dto.getAmount().compareTo(availableCommission) > 0) {
            throw new GlobalException("可提现佣金不足");
        }

        BigDecimal withdrawnCommission = distributor.getWithdrawnCommission() != null ? distributor.getWithdrawnCommission() : BigDecimal.ZERO;
        
        // Update distributor balance
        distributor.setAvailableCommission(availableCommission.subtract(dto.getAmount()));
        distributor.setWithdrawnCommission(withdrawnCommission.add(dto.getAmount()));
        distributor.setUpdatedTime(new Date());
        distributionUserMapper.updateById(distributor);

        // Transfer to user balance
        BigDecimal userBalance = user.getBalance() != null ? user.getBalance() : BigDecimal.ZERO;
        user.setBalance(userBalance.add(dto.getAmount()));
        userMapper.updateById(user);

        log.info("User {} withdrew commission: {}", userId, dto.getAmount());
    }

    @Override
    public Long getUserIdByReferralCode(String referralCode) {
        if (StrUtil.isBlank(referralCode)) {
            return null;
        }

        LambdaQueryWrapper<DistributionUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(DistributionUser::getReferralCode, referralCode)
                .eq(DistributionUser::getStatus, 1);
        DistributionUser distributor = distributionUserMapper.selectOne(queryWrapper);

        return distributor != null ? distributor.getUserId() : null;
    }

    @Override
    public String generateReferralCode(Long userId) {
        String code;
        int attempts = 0;
        LambdaQueryWrapper<DistributionUser> checkWrapper;
        do {
            // Generate 8-character alphanumeric code
            code = RandomUtil.randomString("ABCDEFGHJKLMNPQRSTUVWXYZ23456789", 8);
            
            checkWrapper = new LambdaQueryWrapper<>();
            checkWrapper.eq(DistributionUser::getReferralCode, code);
            
            attempts++;
            if (attempts > 10) {
                throw new GlobalException("生成推广码失败，请重试");
            }
        } while (distributionUserMapper.selectCount(checkWrapper) > 0);

        return code;
    }
}
