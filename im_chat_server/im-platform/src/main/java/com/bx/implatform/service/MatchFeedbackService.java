package com.bx.implatform.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.bx.implatform.entity.MatchFeedback;

import java.util.List;

public interface MatchFeedbackService extends IService<MatchFeedback> {

    void submitFeedback(Long targetUserId, Integer score, String comment);

    List<MatchFeedback> listMyFeedback(Integer pageNum, Integer pageSize);
}
