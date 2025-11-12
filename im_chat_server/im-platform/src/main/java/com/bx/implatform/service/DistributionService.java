package com.bx.implatform.service;

import com.bx.implatform.dto.ActivateDistributorDTO;
import com.bx.implatform.dto.CommissionWithdrawDTO;
import com.bx.implatform.entity.DistributionCommission;
import com.bx.implatform.vo.DistributorVO;

import java.util.List;

/**
 * 分销服务接口
 */
public interface DistributionService {

    /**
     * 激活分销商
     * @param dto 激活DTO
     * @return 推广码
     */
    String activateDistributor(ActivateDistributorDTO dto);

    /**
     * 获取分销商信息
     * @return 分销商信息
     */
    DistributorVO getDistributorInfo();

    /**
     * 获取佣金明细
     * @param pageNum 页码
     * @param pageSize 每页数量
     * @return 佣金明细列表
     */
    List<DistributionCommission> getCommissionList(Integer pageNum, Integer pageSize);

    /**
     * 佣金提现
     * @param dto 提现DTO
     */
    void withdrawCommission(CommissionWithdrawDTO dto);

    /**
     * 根据推广码获取推荐人用户ID
     * @param referralCode 推广码
     * @return 用户ID
     */
    Long getUserIdByReferralCode(String referralCode);

    /**
     * 生成推广码
     * @param userId 用户ID
     * @return 推广码
     */
    String generateReferralCode(Long userId);
}
