package com.bx.implatform.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.bx.implatform.entity.AfterSaleRequest;

import java.util.List;

public interface AfterSaleService extends IService<AfterSaleRequest> {

    Long requestReturn(Long orderId, String reason);

    void approve(Long id);

    void reject(Long id, String reason);

    List<AfterSaleRequest> listMyRequests(Integer pageNum, Integer pageSize);
}
