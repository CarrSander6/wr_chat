package com.bx.implatform.service;

import com.bx.implatform.dto.MatchActionDTO;
import com.bx.implatform.vo.MatchHistoryVO;
import com.bx.implatform.vo.MatchedUserVO;
import com.bx.implatform.vo.UserVO;

import java.util.List;

/**
 * 匹配服务接口
 */
public interface MatchService {

    /**
     * 获取待匹配的用户列表
     * @param limit 数量限制
     * @return 用户列表
     */
    List<UserVO> getMatchCandidates(Integer limit);

    /**
     * 记录匹配操作（喜欢/不喜欢）
     * @param dto 操作DTO
     * @return 是否匹配成功
     */
    Boolean recordMatchAction(MatchActionDTO dto);

    /**
     * 获取匹配历史记录
     * @param actionType 操作类型（可选）
     * @param pageNum 页码
     * @param pageSize 每页数量
     * @return 历史记录列表
     */
    List<MatchHistoryVO> getMatchHistory(Integer actionType, Integer pageNum, Integer pageSize);

    /**
     * 获取已匹配的用户列表
     * @return 匹配用户列表
     */
    List<MatchedUserVO> getMatchedUsers();

    /**
     * 检查两个用户是否匹配
     * @param user1Id 用户1 ID
     * @param user2Id 用户2 ID
     * @return 是否匹配
     */
    Boolean checkMatch(Long user1Id, Long user2Id);
}
