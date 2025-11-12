package com.kai.redenvelope.entity;

import java.math.BigDecimal;
import java.util.Date;

public class RedRecord {
    /**
     * 
     */
    private Integer id;

    /**
     * 用户id
     */
    private Integer userId;

    /**
     * 红包全局唯一标识串
     */
    private String redPacket;

    /**
     * 人数
     */
    private Integer total;

    /**
     * 总金额(单位为分)
     */
    private BigDecimal amount;

    /**
     * 是否有效
     */
    private Byte isActive;

    /**
     * 创建时间
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
     * 用户id
     * @return user_id 用户id
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * 用户id
     * @param userId 用户id
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * 红包全局唯一标识串
     * @return red_packet 红包全局唯一标识串
     */
    public String getRedPacket() {
        return redPacket;
    }

    /**
     * 红包全局唯一标识串
     * @param redPacket 红包全局唯一标识串
     */
    public void setRedPacket(String redPacket) {
        this.redPacket = redPacket == null ? null : redPacket.trim();
    }

    /**
     * 人数
     * @return total 人数
     */
    public Integer getTotal() {
        return total;
    }

    /**
     * 人数
     * @param total 人数
     */
    public void setTotal(Integer total) {
        this.total = total;
    }

    /**
     * 总金额(单位为分)
     * @return amount 总金额(单位为分)
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * 总金额(单位为分)
     * @param amount 总金额(单位为分)
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
     * 创建时间
     * @return create_time 创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 创建时间
     * @param createTime 创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}