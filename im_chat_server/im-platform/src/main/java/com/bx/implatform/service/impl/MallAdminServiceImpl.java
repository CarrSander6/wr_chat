package com.bx.implatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bx.implatform.entity.MallCategory;
import com.bx.implatform.entity.MallProduct;
import com.bx.implatform.entity.MallSku;
import com.bx.implatform.exception.GlobalException;
import com.bx.implatform.mapper.MallCategoryMapper;
import com.bx.implatform.mapper.MallProductMapper;
import com.bx.implatform.mapper.MallSkuMapper;
import com.bx.implatform.service.MallAdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MallAdminServiceImpl extends ServiceImpl<MallCategoryMapper, MallCategory> implements MallAdminService {

    private final MallCategoryMapper categoryMapper;
    private final MallSkuMapper skuMapper;
    private final MallProductMapper productMapper;
    private final com.bx.implatform.mapper.MallOrderMapper orderMapper;
    private final com.bx.implatform.mapper.AfterSaleRequestMapper afterSaleRequestMapper;

    @Override
    public Long createCategory(String name, Long parentId, Integer sortOrder) {
        MallCategory c = new MallCategory();
        c.setName(name);
        c.setParentId(parentId);
        c.setSortOrder(sortOrder);
        c.setStatus(1);
        c.setCreatedTime(new Date());
        c.setUpdatedTime(new Date());
        categoryMapper.insert(c);
        return c.getId();
    }

    @Override
    public void updateCategory(Long id, String name, Long parentId, Integer sortOrder, Integer status) {
        MallCategory c = categoryMapper.selectById(id);
        if (c == null) throw new GlobalException("分类不存在");
        c.setName(name);
        c.setParentId(parentId);
        c.setSortOrder(sortOrder);
        c.setStatus(status);
        c.setUpdatedTime(new Date());
        categoryMapper.updateById(c);
    }

    @Override
    public void deleteCategory(Long id) {
        categoryMapper.deleteById(id);
    }

    @Override
    public List<MallCategory> listCategories(Long parentId) {
        LambdaQueryWrapper<MallCategory> w = new LambdaQueryWrapper<>();
        if (parentId != null) w.eq(MallCategory::getParentId, parentId);
        w.eq(MallCategory::getStatus, 1).orderByAsc(MallCategory::getSortOrder);
        return categoryMapper.selectList(w);
    }

    @Override
    public Long addSku(Long productId, String skuCode, String attributes, BigDecimal price, Integer stock) {
        MallProduct p = productMapper.selectById(productId);
        if (p == null) throw new GlobalException("商品不存在");
        MallSku s = new MallSku();
        s.setProductId(productId);
        s.setSkuCode(skuCode);
        s.setAttributes(attributes);
        s.setPrice(price);
        s.setStock(stock);
        s.setStatus(1);
        s.setCreatedTime(new Date());
        s.setUpdatedTime(new Date());
        skuMapper.insert(s);
        // 更新商品聚合库存
        int totalStock = aggregateProductStock(productId);
        p.setStock(totalStock);
        p.setUpdatedTime(new Date());
        productMapper.updateById(p);
        return s.getId();
    }

    @Override
    public void updateSku(Long id, String attributes, BigDecimal price, Integer stock, Integer status) {
        MallSku s = skuMapper.selectById(id);
        if (s == null) throw new GlobalException("SKU不存在");
        s.setAttributes(attributes);
        s.setPrice(price);
        s.setStock(stock);
        s.setStatus(status);
        s.setUpdatedTime(new Date());
        skuMapper.updateById(s);
        // 更新商品聚合库存
        MallProduct p = productMapper.selectById(s.getProductId());
        if (p != null) {
            p.setStock(aggregateProductStock(s.getProductId()));
            p.setUpdatedTime(new Date());
            productMapper.updateById(p);
        }
    }

    @Override
    public void deleteSku(Long id) {
        MallSku s = skuMapper.selectById(id);
        if (s != null) {
            skuMapper.deleteById(id);
            MallProduct p = productMapper.selectById(s.getProductId());
            if (p != null) {
                p.setStock(aggregateProductStock(s.getProductId()));
                p.setUpdatedTime(new Date());
                productMapper.updateById(p);
            }
        }
    }

    @Override
    public List<MallSku> listSkus(Long productId) {
        LambdaQueryWrapper<MallSku> w = new LambdaQueryWrapper<>();
        w.eq(MallSku::getProductId, productId).eq(MallSku::getStatus, 1).orderByAsc(MallSku::getId);
        return skuMapper.selectList(w);
    }

    @Override
    public void shipOrder(Long orderId, String carrier, String shippingNo) {
        com.bx.implatform.entity.MallOrder order = orderMapper.selectById(orderId);
        if (order == null) throw new GlobalException("订单不存在");
        if (order.getStatus() != 1) throw new GlobalException("仅支持已支付订单发货");
        order.setShippingCarrier(carrier);
        order.setShippingNo(shippingNo);
        order.setShippedTime(new Date());
        order.setUpdatedTime(new Date());
        orderMapper.updateById(order);
    }

    @Override
    public java.util.List<com.bx.implatform.entity.AfterSaleRequest> listAfterSales(Integer pageNum, Integer pageSize, Integer status) {
        pageNum = pageNum == null || pageNum <= 0 ? 1 : pageNum;
        pageSize = pageSize == null || pageSize <= 0 ? 20 : pageSize;
        com.baomidou.mybatisplus.extension.plugins.pagination.Page<com.bx.implatform.entity.AfterSaleRequest> page = new com.baomidou.mybatisplus.extension.plugins.pagination.Page<>(pageNum, pageSize);
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<com.bx.implatform.entity.AfterSaleRequest> w = new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        if (status != null) w.eq(com.bx.implatform.entity.AfterSaleRequest::getStatus, status);
        w.orderByDesc(com.bx.implatform.entity.AfterSaleRequest::getCreatedTime);
        return afterSaleRequestMapper.selectPage(page, w).getRecords();
    }

    private int aggregateProductStock(Long productId){
        LambdaQueryWrapper<MallSku> w = new LambdaQueryWrapper<>();
        w.eq(MallSku::getProductId, productId).eq(MallSku::getStatus, 1);
        return skuMapper.selectList(w).stream()
                .mapToInt(sku -> sku.getStock() != null ? sku.getStock() : 0)
                .sum();
    }
}
