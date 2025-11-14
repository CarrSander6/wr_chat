package com.bx.implatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bx.implatform.entity.AfterSaleRequest;
import com.bx.implatform.entity.MallOrder;
import com.bx.implatform.entity.MallProduct;
import com.bx.implatform.entity.MallSku;
import com.bx.implatform.exception.GlobalException;
import com.bx.implatform.mapper.AfterSaleRequestMapper;
import com.bx.implatform.mapper.MallOrderMapper;
import com.bx.implatform.mapper.MallProductMapper;
import com.bx.implatform.mapper.MallSkuMapper;
import com.bx.implatform.mapper.DistributionCommissionMapper;
import com.bx.implatform.entity.DistributionCommission;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
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
    private final MallProductMapper productMapper;
    private final MallSkuMapper skuMapper;
    private final DistributionCommissionMapper commissionMapper;

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
        MallOrder order = orderMapper.selectById(r.getOrderId());
        if (order != null) {
            order.setStatus(2);
            order.setUpdatedTime(new Date());
            orderMapper.updateById(order);
            MallProduct product = productMapper.selectById(order.getProductId());
            if (order.getSkuId() != null) {
                MallSku sku = skuMapper.selectById(order.getSkuId());
                if (sku != null) {
                    Integer skuStock = sku.getStock() != null ? sku.getStock() : 0;
                    sku.setStock(skuStock + order.getQuantity());
                    sku.setUpdatedTime(new Date());
                    skuMapper.updateById(sku);
                }
                if (product != null) {
                    Integer productStock = product.getStock() != null ? product.getStock() : 0;
                    Integer productSales = product.getSalesCount() != null ? product.getSalesCount() : 0;
                    product.setStock(productStock + order.getQuantity());
                    product.setSalesCount(Math.max(0, productSales - order.getQuantity()));
                    product.setUpdatedTime(new Date());
                    productMapper.updateById(product);
                }
            } else if (product != null) {
                Integer productStock = product.getStock() != null ? product.getStock() : 0;
                Integer productSales = product.getSalesCount() != null ? product.getSalesCount() : 0;
                product.setStock(productStock + order.getQuantity());
                product.setSalesCount(Math.max(0, productSales - order.getQuantity()));
                product.setUpdatedTime(new Date());
                productMapper.updateById(product);
            }
            LambdaQueryWrapper<DistributionCommission> w = new LambdaQueryWrapper<>();
            w.eq(DistributionCommission::getOrderId, order.getId()).eq(DistributionCommission::getStatus, 0);
            List<DistributionCommission> cs = commissionMapper.selectList(w);
            Date now = new Date();
            for (DistributionCommission c : cs) {
                c.setStatus(2);
                c.setSettledTime(null);
                commissionMapper.updateById(c);
            }
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
