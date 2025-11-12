package com.bx.implatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.bx.implatform.entity.DistributionCommission;
import com.bx.implatform.entity.DistributionUser;
import com.bx.implatform.entity.MallOrder;
import com.bx.implatform.entity.MallProduct;
import com.bx.implatform.entity.User;
import com.bx.implatform.mapper.DistributionCommissionMapper;
import com.bx.implatform.mapper.DistributionUserMapper;
import com.bx.implatform.mapper.MallOrderMapper;
import com.bx.implatform.mapper.MallProductMapper;
import com.bx.implatform.mapper.UserMapper;
import com.bx.implatform.service.DistributionStatisticsService;
import com.bx.implatform.session.SessionContext;
import com.bx.implatform.session.UserSession;
import com.bx.implatform.vo.DistributionStatisticsVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 分销统计服务实现
 * 
 * @author Blue
 * @date 2025-01-12
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class DistributionStatisticsServiceImpl implements DistributionStatisticsService {

    private final DistributionUserMapper distributionUserMapper;
    private final DistributionCommissionMapper commissionMapper;
    private final MallOrderMapper orderMapper;
    private final MallProductMapper productMapper;
    private final UserMapper userMapper;

    @Override
    public DistributionStatisticsVO getStatistics() {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        DistributionStatisticsVO vo = new DistributionStatisticsVO();

        // 获取分销商信息
        LambdaQueryWrapper<DistributionUser> userWrapper = new LambdaQueryWrapper<>();
        userWrapper.eq(DistributionUser::getUserId, userId);
        DistributionUser distributor = distributionUserMapper.selectOne(userWrapper);

        if (distributor == null) {
            return vo;
        }

        // 基础信息
        vo.setTotalCommission(distributor.getTotalCommission());
        vo.setAvailableCommission(distributor.getAvailableCommission());
        vo.setWithdrawnCommission(distributor.getWithdrawnCommission());

        // 团队人数
        LambdaQueryWrapper<DistributionUser> level1Wrapper = new LambdaQueryWrapper<>();
        level1Wrapper.eq(DistributionUser::getParentUserId, userId);
        vo.setLevel1Count(Math.toIntExact(distributionUserMapper.selectCount(level1Wrapper)));

        LambdaQueryWrapper<DistributionUser> level2Wrapper = new LambdaQueryWrapper<>();
        level2Wrapper.eq(DistributionUser::getGrandParentUserId, userId);
        vo.setLevel2Count(Math.toIntExact(distributionUserMapper.selectCount(level2Wrapper)));

        vo.setTeamTotalCount(vo.getLevel1Count() + vo.getLevel2Count());

        // 今日佣金
        Date todayStart = Date.from(LocalDateTime.of(LocalDate.now(), LocalTime.MIN)
                .atZone(ZoneId.systemDefault()).toInstant());
        Date todayEnd = Date.from(LocalDateTime.of(LocalDate.now(), LocalTime.MAX)
                .atZone(ZoneId.systemDefault()).toInstant());

        LambdaQueryWrapper<DistributionCommission> todayWrapper = new LambdaQueryWrapper<>();
        todayWrapper.eq(DistributionCommission::getDistributorUserId, userId)
                .eq(DistributionCommission::getStatus, 1)
                .between(DistributionCommission::getCreatedTime, todayStart, todayEnd);
        List<DistributionCommission> todayCommissions = commissionMapper.selectList(todayWrapper);
        vo.setTodayCommission(todayCommissions.stream()
                .map(DistributionCommission::getCommissionAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add));

        // 昨日佣金
        Date yesterdayStart = Date.from(LocalDateTime.of(LocalDate.now().minusDays(1), LocalTime.MIN)
                .atZone(ZoneId.systemDefault()).toInstant());
        Date yesterdayEnd = Date.from(LocalDateTime.of(LocalDate.now().minusDays(1), LocalTime.MAX)
                .atZone(ZoneId.systemDefault()).toInstant());

        LambdaQueryWrapper<DistributionCommission> yesterdayWrapper = new LambdaQueryWrapper<>();
        yesterdayWrapper.eq(DistributionCommission::getDistributorUserId, userId)
                .eq(DistributionCommission::getStatus, 1)
                .between(DistributionCommission::getCreatedTime, yesterdayStart, yesterdayEnd);
        List<DistributionCommission> yesterdayCommissions = commissionMapper.selectList(yesterdayWrapper);
        vo.setYesterdayCommission(yesterdayCommissions.stream()
                .map(DistributionCommission::getCommissionAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add));

        // 本月佣金
        Date monthStart = Date.from(LocalDateTime.of(LocalDate.now().withDayOfMonth(1), LocalTime.MIN)
                .atZone(ZoneId.systemDefault()).toInstant());

        LambdaQueryWrapper<DistributionCommission> monthWrapper = new LambdaQueryWrapper<>();
        monthWrapper.eq(DistributionCommission::getDistributorUserId, userId)
                .eq(DistributionCommission::getStatus, 1)
                .ge(DistributionCommission::getCreatedTime, monthStart);
        List<DistributionCommission> monthCommissions = commissionMapper.selectList(monthWrapper);
        vo.setMonthCommission(monthCommissions.stream()
                .map(DistributionCommission::getCommissionAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add));

        // 订单统计
        LambdaQueryWrapper<DistributionCommission> todayOrderWrapper = new LambdaQueryWrapper<>();
        todayOrderWrapper.eq(DistributionCommission::getDistributorUserId, userId)
                .between(DistributionCommission::getCreatedTime, todayStart, todayEnd);
        vo.setTodayOrderCount(Math.toIntExact(commissionMapper.selectCount(todayOrderWrapper)));

        LambdaQueryWrapper<DistributionCommission> monthOrderWrapper = new LambdaQueryWrapper<>();
        monthOrderWrapper.eq(DistributionCommission::getDistributorUserId, userId)
                .ge(DistributionCommission::getCreatedTime, monthStart);
        vo.setMonthOrderCount(Math.toIntExact(commissionMapper.selectCount(monthOrderWrapper)));

        LambdaQueryWrapper<DistributionCommission> totalOrderWrapper = new LambdaQueryWrapper<>();
        totalOrderWrapper.eq(DistributionCommission::getDistributorUserId, userId);
        vo.setTotalOrderCount(Math.toIntExact(commissionMapper.selectCount(totalOrderWrapper)));

        return vo;
    }

    @Override
    public List<Map<String, Object>> getTeamList(Integer level, Integer pageNum, Integer pageSize) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize <= 0) {
            pageSize = 20;
        }

        LambdaQueryWrapper<DistributionUser> wrapper = new LambdaQueryWrapper<>();
        if (level == 1) {
            wrapper.eq(DistributionUser::getParentUserId, userId);
        } else if (level == 2) {
            wrapper.eq(DistributionUser::getGrandParentUserId, userId);
        } else {
            wrapper.and(w -> w.eq(DistributionUser::getParentUserId, userId)
                    .or().eq(DistributionUser::getGrandParentUserId, userId));
        }
        wrapper.orderByDesc(DistributionUser::getCreatedTime);

        // 简单分页
        int offset = (pageNum - 1) * pageSize;
        wrapper.last("LIMIT " + offset + ", " + pageSize);

        List<DistributionUser> teamMembers = distributionUserMapper.selectList(wrapper);

        List<Map<String, Object>> result = new ArrayList<>();
        for (DistributionUser member : teamMembers) {
            Map<String, Object> map = new HashMap<>();
            
            User user = userMapper.selectById(member.getUserId());
            if (user != null) {
                map.put("userId", user.getId());
                map.put("nickName", user.getNickName());
                map.put("headImage", user.getHeadImageThumb());
            }
            
            map.put("referralCode", member.getReferralCode());
            map.put("totalCommission", member.getTotalCommission());
            map.put("activatedTime", member.getActivatedTime());
            map.put("level", member.getParentUserId().equals(userId) ? 1 : 2);

            // 统计该成员的订单数
            LambdaQueryWrapper<DistributionCommission> commissionWrapper = new LambdaQueryWrapper<>();
            commissionWrapper.eq(DistributionCommission::getBuyerUserId, member.getUserId())
                    .eq(DistributionCommission::getStatus, 1);
            long orderCount = commissionMapper.selectCount(commissionWrapper);
            map.put("orderCount", orderCount);

            result.add(map);
        }

        return result;
    }

    @Override
    public List<Map<String, Object>> getDailyCommissionStats(Integer days) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        if (days == null || days <= 0) {
            days = 7;
        }

        List<Map<String, Object>> result = new ArrayList<>();

        for (int i = days - 1; i >= 0; i--) {
            LocalDate date = LocalDate.now().minusDays(i);
            Date dayStart = Date.from(LocalDateTime.of(date, LocalTime.MIN)
                    .atZone(ZoneId.systemDefault()).toInstant());
            Date dayEnd = Date.from(LocalDateTime.of(date, LocalTime.MAX)
                    .atZone(ZoneId.systemDefault()).toInstant());

            LambdaQueryWrapper<DistributionCommission> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(DistributionCommission::getDistributorUserId, userId)
                    .eq(DistributionCommission::getStatus, 1)
                    .between(DistributionCommission::getCreatedTime, dayStart, dayEnd);

            List<DistributionCommission> commissions = commissionMapper.selectList(wrapper);
            BigDecimal dayCommission = commissions.stream()
                    .map(DistributionCommission::getCommissionAmount)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            Map<String, Object> map = new HashMap<>();
            map.put("date", date.toString());
            map.put("commission", dayCommission);
            map.put("orderCount", commissions.size());
            result.add(map);
        }

        return result;
    }

    @Override
    public List<Map<String, Object>> getCommissionRanking(Integer type, Integer limit) {
        if (limit == null || limit <= 0) {
            limit = 10;
        }

        Date startTime = null;
        if (type != null) {
            LocalDateTime now = LocalDateTime.now();
            if (type == 1) {
                // 今日
                startTime = Date.from(LocalDateTime.of(LocalDate.now(), LocalTime.MIN)
                        .atZone(ZoneId.systemDefault()).toInstant());
            } else if (type == 2) {
                // 本周
                startTime = Date.from(now.with(java.time.DayOfWeek.MONDAY).toLocalDate().atStartOfDay()
                        .atZone(ZoneId.systemDefault()).toInstant());
            } else if (type == 3) {
                // 本月
                startTime = Date.from(LocalDateTime.of(LocalDate.now().withDayOfMonth(1), LocalTime.MIN)
                        .atZone(ZoneId.systemDefault()).toInstant());
            }
        }

        // 获取所有分销商
        LambdaQueryWrapper<DistributionUser> userWrapper = new LambdaQueryWrapper<>();
        userWrapper.eq(DistributionUser::getStatus, 1);
        List<DistributionUser> distributors = distributionUserMapper.selectList(userWrapper);

        // 计算每个分销商的佣金
        Map<Long, BigDecimal> commissionMap = new HashMap<>();
        for (DistributionUser distributor : distributors) {
            LambdaQueryWrapper<DistributionCommission> commissionWrapper = new LambdaQueryWrapper<>();
            commissionWrapper.eq(DistributionCommission::getDistributorUserId, distributor.getUserId())
                    .eq(DistributionCommission::getStatus, 1);
            
            if (startTime != null) {
                commissionWrapper.ge(DistributionCommission::getCreatedTime, startTime);
            }

            List<DistributionCommission> commissions = commissionMapper.selectList(commissionWrapper);
            BigDecimal totalCommission = commissions.stream()
                    .map(DistributionCommission::getCommissionAmount)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            commissionMap.put(distributor.getUserId(), totalCommission);
        }

        // 排序并取前N名
        List<Map.Entry<Long, BigDecimal>> sortedList = commissionMap.entrySet().stream()
                .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
                .limit(limit)
                .collect(Collectors.toList());

        List<Map<String, Object>> result = new ArrayList<>();
        int rank = 1;
        for (Map.Entry<Long, BigDecimal> entry : sortedList) {
            Map<String, Object> map = new HashMap<>();
            map.put("rank", rank++);
            map.put("userId", entry.getKey());
            map.put("commission", entry.getValue());

            User user = userMapper.selectById(entry.getKey());
            if (user != null) {
                map.put("nickName", user.getNickName());
                map.put("headImage", user.getHeadImageThumb());
            }

            result.add(map);
        }

        return result;
    }

    @Override
    public BigDecimal calculateEstimatedCommission(Long productId, Integer quantity) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        if (quantity == null || quantity <= 0) {
            quantity = 1;
        }

        // 获取商品信息
        MallProduct product = productMapper.selectById(productId);
        if (product == null || !product.getEnableDistribution()) {
            return BigDecimal.ZERO;
        }

        // 获取用户的分销商信息
        LambdaQueryWrapper<DistributionUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DistributionUser::getUserId, userId);
        DistributionUser distributor = distributionUserMapper.selectOne(wrapper);

        if (distributor == null || distributor.getParentUserId() == null) {
            return BigDecimal.ZERO;
        }

        // 计算订单金额
        BigDecimal orderAmount = product.getPrice().multiply(new BigDecimal(quantity));

        // 计算一级佣金
        BigDecimal commission = orderAmount.multiply(product.getLevel1CommissionRate());

        return commission;
    }
}
