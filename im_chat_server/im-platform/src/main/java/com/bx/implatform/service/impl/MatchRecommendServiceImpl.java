package com.bx.implatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.bx.implatform.entity.User;
import com.bx.implatform.entity.UserMatchRecord;
import com.bx.implatform.mapper.UserMapper;
import com.bx.implatform.mapper.UserMatchRecordMapper;
import com.bx.implatform.service.MatchRecommendService;
import com.bx.implatform.service.UserBlacklistService;
import com.bx.implatform.session.SessionContext;
import com.bx.implatform.session.UserSession;
import com.bx.implatform.util.BeanUtils;
import com.bx.implatform.vo.UserVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 匹配推荐服务实现 - 智能推荐算法
 * 
 * @author Blue
 * @date 2025-01-12
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class MatchRecommendServiceImpl implements MatchRecommendService {

    private final UserMapper userMapper;
    private final UserMatchRecordMapper matchRecordMapper;
    private final UserBlacklistService blacklistService;

    @Override
    public List<UserVO> getSmartRecommendations(Integer limit) {
        UserSession session = SessionContext.getSession();
        Long userId = (session != null ? session.getUserId() : null);

        if (limit == null || limit <= 0) {
            limit = 10;
        }

        // 获取当前用户信息
        User currentUser = (userId != null ? userMapper.selectById(userId) : null);
        if (currentUser == null) {
            // 无会话或用户不存在时，返回活跃用户作为兜底
            LambdaQueryWrapper<User> fallbackWrapper = new LambdaQueryWrapper<>();
            fallbackWrapper.eq(User::getStatus, 0)
                    .eq(User::getIsBanned, false)
                    .orderByDesc(User::getLastLoginTime)
                    .last("LIMIT " + limit);
            List<User> fallback = userMapper.selectList(fallbackWrapper);
            return fallback.stream()
                    .map(user -> BeanUtils.copyProperties(user, UserVO.class))
                    .collect(Collectors.toList());
        }

        // 获取已浏览过的用户ID列表
        LambdaQueryWrapper<UserMatchRecord> recordWrapper = new LambdaQueryWrapper<>();
        recordWrapper.eq(UserMatchRecord::getUserId, userId);
        List<UserMatchRecord> viewedRecords = matchRecordMapper.selectList(recordWrapper);
        List<Long> viewedUserIds = viewedRecords.stream()
                .map(UserMatchRecord::getTargetUserId)
                .collect(Collectors.toList());
        viewedUserIds.add(userId); // 排除自己

        // 获取候选用户
        LambdaQueryWrapper<User> userWrapper = new LambdaQueryWrapper<>();
        userWrapper.notIn(!viewedUserIds.isEmpty(), User::getId, viewedUserIds)
                .eq(User::getStatus, 0)
                .eq(User::getIsBanned, false)
                .last("LIMIT " + (limit * 3)); // 获取3倍数量用于打分排序

        List<User> candidates = userMapper.selectList(userWrapper);

        // 计算匹配分数并排序
        Map<Long, Integer> scoreMap = new HashMap<>();
        for (User candidate : candidates) {
            int score = calculateMatchScore(currentUser, candidate);
            scoreMap.put(candidate.getId(), score);
        }

        // 按分数降序排序并取top N
        List<User> recommendedUsers = candidates.stream()
                .filter(u -> userId == null || (!blacklistService.isInBlacklist(userId, u.getId()) && !blacklistService.isInBlacklist(u.getId(), userId)))
                .sorted((u1, u2) -> scoreMap.get(u2.getId()).compareTo(scoreMap.get(u1.getId())))
                .limit(limit)
                .collect(Collectors.toList());

        if (recommendedUsers.isEmpty()) {
            LambdaQueryWrapper<User> fallbackWrapper = new LambdaQueryWrapper<>();
            fallbackWrapper.ne(User::getId, currentUser.getId())
                    .eq(User::getStatus, 0)
                    .eq(User::getIsBanned, false)
                    .orderByDesc(User::getLastLoginTime)
                    .last("LIMIT " + limit);
            List<User> fallback = userMapper.selectList(fallbackWrapper);
            recommendedUsers = fallback.stream()
                    .filter(u -> userId == null || (!blacklistService.isInBlacklist(userId, u.getId()) && !blacklistService.isInBlacklist(u.getId(), userId)))
                    .collect(Collectors.toList());
        }

        return recommendedUsers.stream()
                .map(user -> BeanUtils.copyProperties(user, UserVO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<UserVO> getRecommendationsByInterest(Integer limit) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        if (limit == null || limit <= 0) {
            limit = 10;
        }

        User currentUser = userMapper.selectById(userId);
        if (currentUser == null || currentUser.getInterests() == null) {
            return getSmartRecommendations(limit);
        }

        // 获取已浏览过的用户ID列表
        LambdaQueryWrapper<UserMatchRecord> recordWrapper = new LambdaQueryWrapper<>();
        recordWrapper.eq(UserMatchRecord::getUserId, userId);
        List<UserMatchRecord> viewedRecords = matchRecordMapper.selectList(recordWrapper);
        List<Long> viewedUserIds = viewedRecords.stream()
                .map(UserMatchRecord::getTargetUserId)
                .collect(Collectors.toList());
        viewedUserIds.add(userId);

        // 查找兴趣相似的用户
        LambdaQueryWrapper<User> userWrapper = new LambdaQueryWrapper<>();
        userWrapper.notIn(!viewedUserIds.isEmpty(), User::getId, viewedUserIds)
                .eq(User::getStatus, 0)
                .eq(User::getIsBanned, false)
                .isNotNull(User::getInterests)
                .last("LIMIT " + limit);

        List<User> users = userMapper.selectList(userWrapper);
        
        return users.stream()
                .filter(u -> !blacklistService.isInBlacklist(userId, u.getId()) && !blacklistService.isInBlacklist(u.getId(), userId))
                .map(user -> BeanUtils.copyProperties(user, UserVO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<UserVO> getRecommendationsByLocation(Double longitude, Double latitude, Integer radius, Integer limit) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        if (limit == null || limit <= 0) {
            limit = 10;
        }
        if (radius == null || radius <= 0) {
            radius = 10; // 默认10公里
        }

        // 获取已浏览过的用户ID列表
        LambdaQueryWrapper<UserMatchRecord> recordWrapper = new LambdaQueryWrapper<>();
        recordWrapper.eq(UserMatchRecord::getUserId, userId);
        List<UserMatchRecord> viewedRecords = matchRecordMapper.selectList(recordWrapper);
        List<Long> viewedUserIds = viewedRecords.stream()
                .map(UserMatchRecord::getTargetUserId)
                .collect(Collectors.toList());
        viewedUserIds.add(userId);
        
        double latDegree = radius / 111.0;
        double lonDegree = radius / (111.0 * Math.max(0.1, Math.cos(Math.toRadians(latitude))));
        double minLat = latitude - latDegree;
        double maxLat = latitude + latDegree;
        double minLon = longitude - lonDegree;
        double maxLon = longitude + lonDegree;

        LambdaQueryWrapper<User> userWrapper = new LambdaQueryWrapper<>();
        userWrapper.notIn(!viewedUserIds.isEmpty(), User::getId, viewedUserIds)
                .eq(User::getStatus, 0)
                .eq(User::getIsBanned, false)
                .isNotNull(User::getLongitude)
                .isNotNull(User::getLatitude)
                .between(User::getLatitude, minLat, maxLat)
                .between(User::getLongitude, minLon, maxLon)
                .last("LIMIT " + (limit * 3));

        List<User> candidates = userMapper.selectList(userWrapper);

        Map<Long, Integer> scoreMap = new HashMap<>();
        User currentUser = userMapper.selectById(userId);
        for (User candidate : candidates) {
            int score = calculateMatchScore(currentUser, candidate);
            scoreMap.put(candidate.getId(), score);
        }

        List<User> recommendedUsers = candidates.stream()
                .filter(u -> !blacklistService.isInBlacklist(userId, u.getId()) && !blacklistService.isInBlacklist(u.getId(), userId))
                .sorted((u1, u2) -> scoreMap.get(u2.getId()).compareTo(scoreMap.get(u1.getId())))
                .limit(limit)
                .collect(Collectors.toList());

        if (recommendedUsers.isEmpty()) {
            LambdaQueryWrapper<User> fallbackWrapper = new LambdaQueryWrapper<>();
            fallbackWrapper.ne(User::getId, userId)
                    .eq(User::getStatus, 0)
                    .eq(User::getIsBanned, false)
                    .orderByDesc(User::getLastLoginTime)
                    .last("LIMIT " + limit);
            List<User> fallback = userMapper.selectList(fallbackWrapper);
            recommendedUsers = fallback.stream()
                    .filter(u -> !blacklistService.isInBlacklist(userId, u.getId()) && !blacklistService.isInBlacklist(u.getId(), userId))
                    .collect(Collectors.toList());
        }

        return recommendedUsers.stream()
                .map(user -> BeanUtils.copyProperties(user, UserVO.class))
                .collect(Collectors.toList());
    }

    @Override
    public Integer calculateMatchScore(Long userId, Long targetUserId) {
        if (userId == null) {
            UserSession session = SessionContext.getSession();
            userId = session != null ? session.getUserId() : null;
        }
        User user = userId != null ? userMapper.selectById(userId) : null;
        User targetUser = userMapper.selectById(targetUserId);
        
        if (user == null || targetUser == null) {
            return 0;
        }

        return calculateMatchScore(user, targetUser);
    }

    /**
     * 计算两个用户的匹配度
     * 综合考虑：年龄差距、性别偏好、兴趣相似度、活跃度等因素
     */
    private Integer calculateMatchScore(User user, User targetUser) {
        int score = 50; // 基础分数

        // 1. 性别偏好匹配 (30分)
        if (user.getSex() != null && targetUser.getSex() != null) {
            // 异性加分
            if (!user.getSex().equals(targetUser.getSex())) {
                score += 30;
            } else {
                score += 10;
            }
        }

        // 2. 年龄差距 (20分)
        if (user.getAge() != null && targetUser.getAge() != null) {
            int ageDiff = Math.abs(user.getAge() - targetUser.getAge());
            if (ageDiff <= 3) {
                score += 20;
            } else if (ageDiff <= 5) {
                score += 15;
            } else if (ageDiff <= 10) {
                score += 10;
            } else {
                score += 5;
            }
        }

        // 3. 兴趣相似度 (20分)
        if (user.getInterests() != null && targetUser.getInterests() != null) {
            String[] userInterests = user.getInterests().split(",");
            String[] targetInterests = targetUser.getInterests().split(",");
            
            int commonInterests = 0;
            for (String interest : userInterests) {
                for (String targetInterest : targetInterests) {
                    if (interest.trim().equals(targetInterest.trim())) {
                        commonInterests++;
                        break;
                    }
                }
            }
            
            if (commonInterests > 0) {
                score += Math.min(20, commonInterests * 5);
            }
        }

        // 4. 活跃度 (15分)
        if (targetUser.getLastLoginTime() != null) {
            long daysSinceLogin = (System.currentTimeMillis() - targetUser.getLastLoginTime().getTime()) / (1000 * 60 * 60 * 24);
            if (daysSinceLogin == 0) {
                score += 15; // 今天登录
            } else if (daysSinceLogin <= 3) {
                score += 10; // 3天内登录
            } else if (daysSinceLogin <= 7) {
                score += 5; // 7天内登录
            }
        }

        // 5. 完整度加分 (15分)
        int completeness = 0;
        if (targetUser.getSignature() != null && !targetUser.getSignature().isEmpty()) completeness += 3;
        if (targetUser.getHeadImage() != null && !targetUser.getHeadImage().isEmpty()) completeness += 5;
        if (targetUser.getAge() != null && targetUser.getAge() > 0) completeness += 3;
        if (targetUser.getCity() != null && !targetUser.getCity().isEmpty()) completeness += 4;
        score += completeness;

        return Math.min(100, Math.max(0, score));
    }

    @Override
    public void updateRecommendationWeight(Long userId) {
        // TODO: 实现推荐权重更新逻辑
        // 可以基于用户的行为（喜欢/不喜欢）来调整推荐算法的权重
        // 使用机器学习模型进行个性化推荐
        log.info("Update recommendation weight for user: {}", userId);
    }
}
