package com.bx.implatform.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.bx.implatform.entity.MallCategory;
import com.bx.implatform.entity.MallSku;

import java.util.List;

public interface MallAdminService extends IService<MallCategory> {

    Long createCategory(String name, Long parentId, Integer sortOrder);

    void updateCategory(Long id, String name, Long parentId, Integer sortOrder, Integer status);

    void deleteCategory(Long id);

    List<MallCategory> listCategories(Long parentId);

    Long addSku(Long productId, String skuCode, String attributes, java.math.BigDecimal price, Integer stock);

    void updateSku(Long id, String attributes, java.math.BigDecimal price, Integer stock, Integer status);

    void deleteSku(Long id);

    List<MallSku> listSkus(Long productId);

    void shipOrder(Long orderId, String carrier, String shippingNo);

    java.util.List<com.bx.implatform.entity.AfterSaleRequest> listAfterSales(Integer pageNum, Integer pageSize, Integer status);
}
