package com.bx.implatform.service.impl;

import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bx.implatform.dto.MatchActionDTO;
import com.bx.implatform.entity.User;
import com.bx.implatform.entity.UserMatch;
import com.bx.implatform.entity.UserMatchRecord;
import com.bx.implatform.mapper.UserMapper;
import com.bx.implatform.mapper.UserMatchMapper;
import com.bx.implatform.mapper.UserMatchRecordMapper;
import com.bx.implatform.service.MatchService;
import com.bx.implatform.session.SessionContext;
import com.bx.implatform.session.UserSession;
import com.bx.implatform.util.BeanUtils;
import com.bx.implatform.vo.MatchHistoryVO;
import com.bx.implatform.vo.MatchedUserVO;
import com.bx.implatform.vo.UserVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 匹配服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class MatchServiceImpl extends ServiceImpl<UserMatchRecordMapper, UserMatchRecord> implements MatchService {

    private final UserMatchRecordMapper userMatchRecordMapper;
    private final UserMatchMapper userMatchMapper;
    private final UserMapper userMapper;

    @Override
    public List<UserVO> getMatchCandidates(Integer limit) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        if (limit == null || limit <= 0) {
            limit = 10;
        }

        // Get unviewed users
        List<Long> unviewedUserIds = userMatchRecordMapper.getUnviewedUsers(userId, limit);

        // If not enough unviewed users, get random users
        if (unviewedUserIds.size() < limit) {
            LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.ne(User::getId, userId)
                    .eq(User::getStatus, 0)
                    .eq(User::getIsBanned, false)
                    .last("ORDER BY RAND() LIMIT " + (limit - unviewedUserIds.size()));
            
            List<User> randomUsers = userMapper.selectList(queryWrapper);
            unviewedUserIds.addAll(randomUsers.stream()
                    .map(User::getId)
                    .filter(id -> !unviewedUserIds.contains(id))
                    .collect(Collectors.toList()));
        }

        // Get user details
        List<UserVO> userVOList = new ArrayList<>();
        for (Long targetUserId : unviewedUserIds) {
            User user = userMapper.selectById(targetUserId);
            if (user != null) {
                UserVO userVO = BeanUtils.copyProperties(user, UserVO.class);
                userVOList.add(userVO);
            }
        }

        return userVOList;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean recordMatchAction(MatchActionDTO dto) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();
        Long targetUserId = dto.getTargetUserId();
        Integer actionType = dto.getActionType();

        // Check if already recorded
        LambdaQueryWrapper<UserMatchRecord> checkWrapper = new LambdaQueryWrapper<>();
        checkWrapper.eq(UserMatchRecord::getUserId, userId)
                .eq(UserMatchRecord::getTargetUserId, targetUserId);
        UserMatchRecord existingRecord = userMatchRecordMapper.selectOne(checkWrapper);

        if (existingRecord == null) {
            // Create new record
            UserMatchRecord record = new UserMatchRecord();
            record.setUserId(userId);
            record.setTargetUserId(targetUserId);
            record.setActionType(actionType);
            record.setCreatedTime(new Date());
            userMatchRecordMapper.insert(record);
        } else {
            // Update existing record
            existingRecord.setActionType(actionType);
            existingRecord.setCreatedTime(new Date());
            userMatchRecordMapper.updateById(existingRecord);
        }

        // If action is "like", check if target user also liked current user
        if (actionType == 1) {
            LambdaQueryWrapper<UserMatchRecord> targetWrapper = new LambdaQueryWrapper<>();
            targetWrapper.eq(UserMatchRecord::getUserId, targetUserId)
                    .eq(UserMatchRecord::getTargetUserId, userId)
                    .eq(UserMatchRecord::getActionType, 1);
            UserMatchRecord targetRecord = userMatchRecordMapper.selectOne(targetWrapper);

            if (targetRecord != null) {
                // Both users liked each other, create match
                LambdaQueryWrapper<UserMatch> matchWrapper = new LambdaQueryWrapper<>();
                matchWrapper.and(wrapper -> wrapper
                        .and(w -> w.eq(UserMatch::getUser1Id, userId).eq(UserMatch::getUser2Id, targetUserId))
                        .or(w -> w.eq(UserMatch::getUser1Id, targetUserId).eq(UserMatch::getUser2Id, userId))
                ).eq(UserMatch::getStatus, 1);
                
                UserMatch existingMatch = userMatchMapper.selectOne(matchWrapper);
                
                if (existingMatch == null) {
                    UserMatch match = new UserMatch();
                    match.setUser1Id(Math.min(userId, targetUserId));
                    match.setUser2Id(Math.max(userId, targetUserId));
                    match.setStatus(1);
                    match.setMatchTime(new Date());
                    match.setCreatedTime(new Date());
                    userMatchMapper.insert(match);
                    
                    log.info("Match created between user {} and user {}", userId, targetUserId);
                    return true;
                }
            }
        }

        return false;
    }

    @Override
    public List<MatchHistoryVO> getMatchHistory(Integer actionType, Integer pageNum, Integer pageSize) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize <= 0) {
            pageSize = 20;
        }

        Page<UserMatchRecord> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<UserMatchRecord> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(UserMatchRecord::getUserId, userId);
        if (actionType != null && actionType > 0) {
            queryWrapper.eq(UserMatchRecord::getActionType, actionType);
        }
        queryWrapper.orderByDesc(UserMatchRecord::getCreatedTime);

        Page<UserMatchRecord> recordPage = userMatchRecordMapper.selectPage(page, queryWrapper);
        
        List<MatchHistoryVO> historyList = new ArrayList<>();
        for (UserMatchRecord record : recordPage.getRecords()) {
            MatchHistoryVO vo = new MatchHistoryVO();
            vo.setId(record.getId());
            vo.setTargetUserId(record.getTargetUserId());
            vo.setActionType(record.getActionType());
            vo.setCreatedTime(record.getCreatedTime());

            User targetUser = userMapper.selectById(record.getTargetUserId());
            if (targetUser != null) {
                vo.setNickName(targetUser.getNickName());
                vo.setHeadImage(targetUser.getHeadImageThumb());
            }

            historyList.add(vo);
        }

        return historyList;
    }

    @Override
    public List<MatchedUserVO> getMatchedUsers() {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        LambdaQueryWrapper<UserMatch> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.and(wrapper -> wrapper
                .eq(UserMatch::getUser1Id, userId)
                .or()
                .eq(UserMatch::getUser2Id, userId)
        ).eq(UserMatch::getStatus, 1)
        .orderByDesc(UserMatch::getMatchTime);

        List<UserMatch> matches = userMatchMapper.selectList(queryWrapper);
        
        List<MatchedUserVO> matchedUsers = new ArrayList<>();
        for (UserMatch match : matches) {
            Long otherUserId = match.getUser1Id().equals(userId) ? match.getUser2Id() : match.getUser1Id();
            User otherUser = userMapper.selectById(otherUserId);
            
            if (otherUser != null) {
                MatchedUserVO vo = new MatchedUserVO();
                vo.setMatchId(match.getId());
                vo.setUserId(otherUser.getId());
                vo.setNickName(otherUser.getNickName());
                vo.setHeadImage(otherUser.getHeadImageThumb());
                vo.setSignature(otherUser.getSignature());
                vo.setSex(otherUser.getSex());
                vo.setMatchTime(match.getMatchTime());
                vo.setStatus(match.getStatus());
                
                matchedUsers.add(vo);
            }
        }

        return matchedUsers;
    }

    @Override
    public Boolean checkMatch(Long user1Id, Long user2Id) {
        LambdaQueryWrapper<UserMatch> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.and(wrapper -> wrapper
                .and(w -> w.eq(UserMatch::getUser1Id, user1Id).eq(UserMatch::getUser2Id, user2Id))
                .or(w -> w.eq(UserMatch::getUser1Id, user2Id).eq(UserMatch::getUser2Id, user1Id))
        ).eq(UserMatch::getStatus, 1);
        
        return userMatchMapper.selectCount(queryWrapper) > 0;
    }
}
