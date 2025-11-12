package com.kai.redenvelope.entity;

import java.math.BigDecimal;
import java.util.Date;

public class RedRobRecord {
    /**
     * 
     */
    private Integer id;

    /**
     * 用户账号
     */
    private Integer userId;

    /**
     * 红包标识串
     */
    private String redPacket;

    /**
     * 红包金额(单位为分)
     */
    private BigDecimal amount;

    /**
     * 时间
     */
    private Date robTime;

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
     * 用户账号
     * @return user_id 用户账号
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * 用户账号
     * @param userId 用户账号
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * 红包标识串
     * @return red_packet 红包标识串
     */
    public String getRedPacket() {
        return redPacket;
    }

    /**
     * 红包标识串
     * @param redPacket 红包标识串
     */
    public void setRedPacket(String redPacket) {
        this.redPacket = redPacket == null ? null : redPacket.trim();
    }

    /**
     * 红包金额(单位为分)
     * @return amount 红包金额(单位为分)
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * 红包金额(单位为分)
     * @param amount 红包金额(单位为分)
     */
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    /**
     * 时间
     * @return rob_time 时间
     */
    public Date getRobTime() {
        return robTime;
    }

    /**
     * 时间
     * @param robTime 时间
     */
    public void setRobTime(Date robTime) {
        this.robTime = robTime;
    }
}