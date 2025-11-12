package com.bx.implatform.service;

import com.bx.implatform.vo.UserVO;

import java.util.List;

/**
 * 匹配推荐服务 - 智能推荐算法
 * 
 * @author Blue
 * @date 2025-01-12
 */
public interface MatchRecommendService {

    /**
     * 获取智能推荐用户列表
     * 基于用户画像、兴趣、地理位置等因素进行推荐
     * 
     * @param limit 推荐数量
     * @return 推荐用户列表
     */
    List<UserVO> getSmartRecommendations(Integer limit);

    /**
     * 根据兴趣标签推荐
     * 
     * @param limit 推荐数量
     * @return 推荐用户列表
     */
    List<UserVO> getRecommendationsByInterest(Integer limit);

    /**
     * 根据地理位置推荐（附近的人）
     * 
     * @param longitude 经度
     * @param latitude 纬度
     * @param radius 半径（公里）
     * @param limit 推荐数量
     * @return 推荐用户列表
     */
    List<UserVO> getRecommendationsByLocation(Double longitude, Double latitude, Integer radius, Integer limit);

    /**
     * 计算用户匹配度
     * 
     * @param userId 用户ID
     * @param targetUserId 目标用户ID
     * @return 匹配度分数 (0-100)
     */
    Integer calculateMatchScore(Long userId, Long targetUserId);

    /**
     * 更新用户推荐权重
     * 基于用户的匹配行为，更新推荐算法的权重
     * 
     * @param userId 用户ID
     */
    void updateRecommendationWeight(Long userId);
}
