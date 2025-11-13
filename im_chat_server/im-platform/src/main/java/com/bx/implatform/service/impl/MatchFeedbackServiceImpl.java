package com.bx.implatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bx.implatform.entity.MatchFeedback;
import com.bx.implatform.exception.GlobalException;
import com.bx.implatform.mapper.MatchFeedbackMapper;
import com.bx.implatform.service.MatchFeedbackService;
import com.bx.implatform.session.SessionContext;
import com.bx.implatform.session.UserSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MatchFeedbackServiceImpl extends ServiceImpl<MatchFeedbackMapper, MatchFeedback> implements MatchFeedbackService {

    private final MatchFeedbackMapper feedbackMapper;

    @Override
    public void submitFeedback(Long targetUserId, Integer score, String comment) {
        UserSession session = SessionContext.getSession();
        if (score == null || score < 1 || score > 5) {
            throw new GlobalException("评分需为1-5");
        }
        MatchFeedback feedback = new MatchFeedback();
        feedback.setUserId(session.getUserId());
        feedback.setTargetUserId(targetUserId);
        feedback.setScore(score);
        feedback.setComment(comment);
        feedback.setCreatedTime(new Date());
        feedbackMapper.insert(feedback);
    }

    @Override
    public List<MatchFeedback> listMyFeedback(Integer pageNum, Integer pageSize) {
        UserSession session = SessionContext.getSession();
        pageNum = pageNum == null || pageNum <= 0 ? 1 : pageNum;
        pageSize = pageSize == null || pageSize <= 0 ? 20 : pageSize;
        Page<MatchFeedback> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<MatchFeedback> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MatchFeedback::getUserId, session.getUserId())
                .orderByDesc(MatchFeedback::getCreatedTime);
        return feedbackMapper.selectPage(page, wrapper).getRecords();
    }
}
