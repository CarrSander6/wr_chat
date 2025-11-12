package com.kai.redenvelope.entity;

import java.math.BigDecimal;
import java.util.Date;

public class RedDetail {
    /**
     * 
     */
    private Integer id;

    /**
     * 红包记录id
     */
    private Integer recordId;

    /**
     * 金额(单位为分)
     */
    private BigDecimal amount;

    /**
     * 是否有效
     */
    private Byte isActive;

    /**
     * 
     */
    private Date createTime;

    /**
     * 
     * @return id 
     */
    public Integer getId() {
        return id;
    }

    /**
     * 
     * @param id 
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 红包记录id
     * @return record_id 红包记录id
     */
    public Integer getRecordId() {
        return recordId;
    }

    /**
     * 红包记录id
     * @param recordId 红包记录id
     */
    public void setRecordId(Integer recordId) {
        this.recordId = recordId;
    }

    /**
     * 金额(单位为分)
     * @return amount 金额(单位为分)
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * 金额(单位为分)
     * @param amount 金额(单位为分)
     */
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    /**
     * 是否有效
     * @return is_active 是否有效
     */
    public Byte getIsActive() {
        return isActive;
    }

    /**
     * 是否有效
     * @param isActive 是否有效
     */
    public void setIsActive(Byte isActive) {
        this.isActive = isActive;
    }

    /**
     * 
     * @return create_time 
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 
     * @param createTime 
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}