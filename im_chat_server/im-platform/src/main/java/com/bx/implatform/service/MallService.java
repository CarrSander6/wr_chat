package com.bx.implatform.service;

import com.bx.implatform.dto.CreateOrderDTO;
import com.bx.implatform.vo.OrderVO;
import com.bx.implatform.vo.ProductVO;

import java.util.List;

/**
 * 商城服务接口
 */
public interface MallService {

    /**
     * 获取商品列表
     * @param pageNum 页码
     * @param pageSize 每页数量
     * @return 商品列表
     */
    List<ProductVO> getProductList(Integer pageNum, Integer pageSize);

    /**
     * 获取商品详情
     * @param productId 商品ID
     * @return 商品详情
     */
    ProductVO getProductDetail(Long productId);

    /**
     * 创建订单
     * @param dto 订单DTO
     * @return 订单信息
     */
    OrderVO createOrder(CreateOrderDTO dto);

    /**
     * 获取订单列表
     * @param pageNum 页码
     * @param pageSize 每页数量
     * @return 订单列表
     */
    List<OrderVO> getOrderList(Integer pageNum, Integer pageSize);

    /**
     * 获取订单详情
     * @param orderId 订单ID
     * @return 订单详情
     */
    OrderVO getOrderDetail(Long orderId);

    /**
     * 支付订单
     * @param orderId 订单ID
     * @param iosReceipt iOS交易凭证（iOS支付时需要）
     */
    void payOrder(Long orderId, String iosReceipt);

    /**
     * 取消订单
     * @param orderId 订单ID
     */
    void cancelOrder(Long orderId);
}
