package com.bx.implatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bx.implatform.entity.AfterSaleRequest;
import com.bx.implatform.entity.MallOrder;
import com.bx.implatform.exception.GlobalException;
import com.bx.implatform.mapper.AfterSaleRequestMapper;
import com.bx.implatform.mapper.MallOrderMapper;
import com.bx.implatform.service.AfterSaleService;
import com.bx.implatform.session.SessionContext;
import com.bx.implatform.session.UserSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AfterSaleServiceImpl extends ServiceImpl<AfterSaleRequestMapper, AfterSaleRequest> implements AfterSaleService {

    private final AfterSaleRequestMapper afterSaleMapper;
    private final MallOrderMapper orderMapper;

    @Override
    public Long requestReturn(Long orderId, String reason) {
        UserSession session = SessionContext.getSession();
        MallOrder order = orderMapper.selectById(orderId);
        if (order == null) throw new GlobalException("订单不存在");
        if (!order.getUserId().equals(session.getUserId())) throw new GlobalException("无权操作该订单");
        if (order.getStatus() != 1) throw new GlobalException("仅支持已支付订单申请售后");
        AfterSaleRequest r = new AfterSaleRequest();
        r.setOrderId(orderId);
        r.setUserId(session.getUserId());
        r.setReason(reason);
        r.setStatus(0);
        r.setCreatedTime(new Date());
        r.setUpdatedTime(new Date());
        afterSaleMapper.insert(r);
        return r.getId();
    }

    @Override
    public void approve(Long id) {
        AfterSaleRequest r = afterSaleMapper.selectById(id);
        if (r == null) throw new GlobalException("售后申请不存在");
        r.setStatus(1);
        r.setUpdatedTime(new Date());
        afterSaleMapper.updateById(r);
        // 退款简化为将订单状态改为已取消并不做余额变动，后续可扩展为支付通道退款
        MallOrder order = orderMapper.selectById(r.getOrderId());
        if (order != null) {
            order.setStatus(2);
            order.setUpdatedTime(new Date());
            orderMapper.updateById(order);
        }
    }

    @Override
    public void reject(Long id, String reason) {
        AfterSaleRequest r = afterSaleMapper.selectById(id);
        if (r == null) throw new GlobalException("售后申请不存在");
        r.setStatus(2);
        r.setUpdatedTime(new Date());
        afterSaleMapper.updateById(r);
    }

    @Override
    public List<AfterSaleRequest> listMyRequests(Integer pageNum, Integer pageSize) {
        UserSession session = SessionContext.getSession();
        pageNum = pageNum == null || pageNum <= 0 ? 1 : pageNum;
        pageSize = pageSize == null || pageSize <= 0 ? 20 : pageSize;
        Page<AfterSaleRequest> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<AfterSaleRequest> w = new LambdaQueryWrapper<>();
        w.eq(AfterSaleRequest::getUserId, session.getUserId()).orderByDesc(AfterSaleRequest::getCreatedTime);
        return afterSaleMapper.selectPage(page, w).getRecords();
    }
}
