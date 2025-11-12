package com.bx.implatform.service.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bx.implatform.dto.CreateOrderDTO;
import com.bx.implatform.entity.*;
import com.bx.implatform.exception.GlobalException;
import com.bx.implatform.mapper.*;
import com.bx.implatform.service.DistributionService;
import com.bx.implatform.service.MallService;
import com.bx.implatform.session.SessionContext;
import com.bx.implatform.session.UserSession;
import com.bx.implatform.util.BeanUtils;
import com.bx.implatform.vo.OrderVO;
import com.bx.implatform.vo.ProductVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 商城服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class MallServiceImpl extends ServiceImpl<MallOrderMapper, MallOrder> implements MallService {

    private final MallProductMapper productMapper;
    private final MallOrderMapper orderMapper;
    private final UserMapper userMapper;
    private final DistributionUserMapper distributionUserMapper;
    private final DistributionCommissionMapper commissionMapper;
    private final DistributionService distributionService;

    @Override
    public List<ProductVO> getProductList(Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize <= 0) {
            pageSize = 20;
        }

        Page<MallProduct> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<MallProduct> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MallProduct::getStatus, 1)
                .orderByAsc(MallProduct::getSortOrder)
                .orderByDesc(MallProduct::getCreatedTime);

        Page<MallProduct> productPage = productMapper.selectPage(page, queryWrapper);
        
        List<ProductVO> productVOList = new ArrayList<>();
        for (MallProduct product : productPage.getRecords()) {
            ProductVO vo = BeanUtils.copyProperties(product, ProductVO.class);
            productVOList.add(vo);
        }

        return productVOList;
    }

    @Override
    public ProductVO getProductDetail(Long productId) {
        MallProduct product = productMapper.selectById(productId);
        if (product == null) {
            throw new GlobalException("商品不存在");
        }
        
        return BeanUtils.copyProperties(product, ProductVO.class);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public OrderVO createOrder(CreateOrderDTO dto) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        // Get product
        MallProduct product = productMapper.selectById(dto.getProductId());
        if (product == null) {
            throw new GlobalException("商品不存在");
        }

        if (product.getStatus() != 1) {
            throw new GlobalException("商品已下架");
        }

        if (product.getStock() < dto.getQuantity()) {
            throw new GlobalException("库存不足");
        }

        // Calculate total amount
        BigDecimal totalAmount = product.getPrice().multiply(new BigDecimal(dto.getQuantity()));

        // Create order
        MallOrder order = new MallOrder();
        order.setOrderNo(IdUtil.getSnowflakeNextIdStr());
        order.setUserId(userId);
        order.setProductId(product.getId());
        order.setProductName(product.getProductName());
        order.setQuantity(dto.getQuantity());
        order.setUnitPrice(product.getPrice());
        order.setTotalAmount(totalAmount);
        order.setPaymentMethod(dto.getPaymentMethod());
        order.setIosReceipt(dto.getIosReceipt());
        order.setStatus(0); // Pending payment
        order.setReferrerUserId(dto.getReferrerUserId());
        order.setCreatedTime(new Date());
        order.setUpdatedTime(new Date());
        
        orderMapper.insert(order);

        // If iOS payment and receipt provided, process payment immediately
        if (dto.getPaymentMethod() == 2 && dto.getIosReceipt() != null) {
            payOrder(order.getId(), dto.getIosReceipt());
        }

        return BeanUtils.copyProperties(order, OrderVO.class);
    }

    @Override
    public List<OrderVO> getOrderList(Integer pageNum, Integer pageSize) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize <= 0) {
            pageSize = 20;
        }

        Page<MallOrder> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<MallOrder> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MallOrder::getUserId, userId)
                .orderByDesc(MallOrder::getCreatedTime);

        Page<MallOrder> orderPage = orderMapper.selectPage(page, queryWrapper);
        
        List<OrderVO> orderVOList = new ArrayList<>();
        for (MallOrder order : orderPage.getRecords()) {
            OrderVO vo = BeanUtils.copyProperties(order, OrderVO.class);
            orderVOList.add(vo);
        }

        return orderVOList;
    }

    @Override
    public OrderVO getOrderDetail(Long orderId) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        MallOrder order = orderMapper.selectById(orderId);
        if (order == null) {
            throw new GlobalException("订单不存在");
        }

        if (!order.getUserId().equals(userId)) {
            throw new GlobalException("无权查看该订单");
        }

        return BeanUtils.copyProperties(order, OrderVO.class);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void payOrder(Long orderId, String iosReceipt) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        MallOrder order = orderMapper.selectById(orderId);
        if (order == null) {
            throw new GlobalException("订单不存在");
        }

        if (!order.getUserId().equals(userId)) {
            throw new GlobalException("无权操作该订单");
        }

        if (order.getStatus() != 0) {
            throw new GlobalException("订单状态异常");
        }

        // Process payment based on payment method
        if (order.getPaymentMethod() == 1) {
            // Balance payment
            User user = userMapper.selectById(userId);
            if (user.getBalance().compareTo(order.getTotalAmount()) < 0) {
                throw new GlobalException("余额不足");
            }

            user.setBalance(user.getBalance().subtract(order.getTotalAmount()));
            userMapper.updateById(user);
        } else if (order.getPaymentMethod() == 2) {
            // iOS in-app purchase
            // TODO: Verify iOS receipt with Apple server
            if (iosReceipt != null) {
                order.setIosReceipt(iosReceipt);
            }
            log.info("iOS receipt for order {}: {}", orderId, iosReceipt);
        }

        // Update product stock
        MallProduct product = productMapper.selectById(order.getProductId());
        if (product != null) {
            product.setStock(product.getStock() - order.getQuantity());
            product.setSalesCount(product.getSalesCount() + order.getQuantity());
            product.setUpdatedTime(new Date());
            productMapper.updateById(product);
        }

        // Update order status
        order.setStatus(1); // Paid
        order.setPaidTime(new Date());
        order.setUpdatedTime(new Date());
        orderMapper.updateById(order);

        // Process distribution commission if applicable
        if (product != null && product.getEnableDistribution()) {
            processCommission(order, product);
        }

        log.info("Order {} paid successfully", orderId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cancelOrder(Long orderId) {
        UserSession session = SessionContext.getSession();
        Long userId = session.getUserId();

        MallOrder order = orderMapper.selectById(orderId);
        if (order == null) {
            throw new GlobalException("订单不存在");
        }

        if (!order.getUserId().equals(userId)) {
            throw new GlobalException("无权操作该订单");
        }

        if (order.getStatus() != 0) {
            throw new GlobalException("订单状态异常，无法取消");
        }

        order.setStatus(2); // Cancelled
        order.setUpdatedTime(new Date());
        orderMapper.updateById(order);

        log.info("Order {} cancelled", orderId);
    }

    /**
     * 处理分销佣金
     */
    private void processCommission(MallOrder order, MallProduct product) {
        Long buyerUserId = order.getUserId();

        // Get buyer's distributor info
        LambdaQueryWrapper<DistributionUser> buyerWrapper = new LambdaQueryWrapper<>();
        buyerWrapper.eq(DistributionUser::getUserId, buyerUserId);
        DistributionUser buyerDist = distributionUserMapper.selectOne(buyerWrapper);

        if (buyerDist != null) {
            // Level 1 commission (direct referrer)
            if (buyerDist.getParentUserId() != null) {
                processCommissionForDistributor(
                        buyerDist.getParentUserId(),
                        order,
                        product.getLevel1CommissionRate(),
                        1
                );
            }

            // Level 2 commission (indirect referrer)
            if (buyerDist.getGrandParentUserId() != null) {
                processCommissionForDistributor(
                        buyerDist.getGrandParentUserId(),
                        order,
                        product.getLevel2CommissionRate(),
                        2
                );
            }
        }
    }

    /**
     * 为分销商处理佣金
     */
    private void processCommissionForDistributor(Long distributorUserId, MallOrder order, 
                                                  BigDecimal commissionRate, Integer commissionType) {
        if (commissionRate == null || commissionRate.compareTo(BigDecimal.ZERO) <= 0) {
            return;
        }

        BigDecimal commissionAmount = order.getTotalAmount().multiply(commissionRate);

        // Create commission record
        DistributionCommission commission = new DistributionCommission();
        commission.setDistributorUserId(distributorUserId);
        commission.setOrderId(order.getId());
        commission.setBuyerUserId(order.getUserId());
        commission.setCommissionType(commissionType);
        commission.setOrderAmount(order.getTotalAmount());
        commission.setCommissionAmount(commissionAmount);
        commission.setCommissionRate(commissionRate);
        commission.setStatus(1); // Settled
        commission.setCreatedTime(new Date());
        commission.setSettledTime(new Date());
        commissionMapper.insert(commission);

        // Update distributor balance
        LambdaQueryWrapper<DistributionUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(DistributionUser::getUserId, distributorUserId);
        DistributionUser distributor = distributionUserMapper.selectOne(queryWrapper);

        if (distributor != null) {
            distributor.setTotalCommission(distributor.getTotalCommission().add(commissionAmount));
            distributor.setAvailableCommission(distributor.getAvailableCommission().add(commissionAmount));
            distributor.setUpdatedTime(new Date());
            distributionUserMapper.updateById(distributor);

            log.info("Commission {} processed for distributor {} on order {}", 
                    commissionAmount, distributorUserId, order.getId());
        }
    }
}
