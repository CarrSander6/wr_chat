package com.kai.redenvelope.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class RedRobRecordExample {
    /**
     * red_rob_record
     */
    protected String orderByClause;

    /**
     * red_rob_record
     */
    protected boolean distinct;

    /**
     * red_rob_record
     */
    protected List<Criteria> oredCriteria;

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public RedRobRecordExample() {
        oredCriteria = new ArrayList<>();
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     *
     * @mbg.generated 2024-10-12
     */
    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    /**
     * red_rob_record 2024-10-12
     */
    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(Integer value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Integer value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Integer value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(Integer value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(Integer value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Integer> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Integer> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(Integer value1, Integer value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(Integer value1, Integer value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNull() {
            addCriterion("user_id is null");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNotNull() {
            addCriterion("user_id is not null");
            return (Criteria) this;
        }

        public Criteria andUserIdEqualTo(Integer value) {
            addCriterion("user_id =", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotEqualTo(Integer value) {
            addCriterion("user_id <>", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThan(Integer value) {
            addCriterion("user_id >", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("user_id >=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThan(Integer value) {
            addCriterion("user_id <", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThanOrEqualTo(Integer value) {
            addCriterion("user_id <=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdIn(List<Integer> values) {
            addCriterion("user_id in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotIn(List<Integer> values) {
            addCriterion("user_id not in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdBetween(Integer value1, Integer value2) {
            addCriterion("user_id between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotBetween(Integer value1, Integer value2) {
            addCriterion("user_id not between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andRedPacketIsNull() {
            addCriterion("red_packet is null");
            return (Criteria) this;
        }

        public Criteria andRedPacketIsNotNull() {
            addCriterion("red_packet is not null");
            return (Criteria) this;
        }

        public Criteria andRedPacketEqualTo(String value) {
            addCriterion("red_packet =", value, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketNotEqualTo(String value) {
            addCriterion("red_packet <>", value, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketGreaterThan(String value) {
            addCriterion("red_packet >", value, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketGreaterThanOrEqualTo(String value) {
            addCriterion("red_packet >=", value, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketLessThan(String value) {
            addCriterion("red_packet <", value, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketLessThanOrEqualTo(String value) {
            addCriterion("red_packet <=", value, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketLike(String value) {
            addCriterion("red_packet like", value, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketNotLike(String value) {
            addCriterion("red_packet not like", value, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketIn(List<String> values) {
            addCriterion("red_packet in", values, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketNotIn(List<String> values) {
            addCriterion("red_packet not in", values, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketBetween(String value1, String value2) {
            addCriterion("red_packet between", value1, value2, "redPacket");
            return (Criteria) this;
        }

        public Criteria andRedPacketNotBetween(String value1, String value2) {
            addCriterion("red_packet not between", value1, value2, "redPacket");
            return (Criteria) this;
        }

        public Criteria andAmountIsNull() {
            addCriterion("amount is null");
            return (Criteria) this;
        }

        public Criteria andAmountIsNotNull() {
            addCriterion("amount is not null");
            return (Criteria) this;
        }

        public Criteria andAmountEqualTo(BigDecimal value) {
            addCriterion("amount =", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountNotEqualTo(BigDecimal value) {
            addCriterion("amount <>", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountGreaterThan(BigDecimal value) {
            addCriterion("amount >", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("amount >=", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountLessThan(BigDecimal value) {
            addCriterion("amount <", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountLessThanOrEqualTo(BigDecimal value) {
            addCriterion("amount <=", value, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountIn(List<BigDecimal> values) {
            addCriterion("amount in", values, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountNotIn(List<BigDecimal> values) {
            addCriterion("amount not in", values, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("amount between", value1, value2, "amount");
            return (Criteria) this;
        }

        public Criteria andAmountNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("amount not between", value1, value2, "amount");
            return (Criteria) this;
        }

        public Criteria andRobTimeIsNull() {
            addCriterion("rob_time is null");
            return (Criteria) this;
        }

        public Criteria andRobTimeIsNotNull() {
            addCriterion("rob_time is not null");
            return (Criteria) this;
        }

        public Criteria andRobTimeEqualTo(Date value) {
            addCriterion("rob_time =", value, "robTime");
            return (Criteria) this;
        }

        public Criteria andRobTimeNotEqualTo(Date value) {
            addCriterion("rob_time <>", value, "robTime");
            return (Criteria) this;
        }

        public Criteria andRobTimeGreaterThan(Date value) {
            addCriterion("rob_time >", value, "robTime");
            return (Criteria) this;
        }

        public Criteria andRobTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("rob_time >=", value, "robTime");
            return (Criteria) this;
        }

        public Criteria andRobTimeLessThan(Date value) {
            addCriterion("rob_time <", value, "robTime");
            return (Criteria) this;
        }

        public Criteria andRobTimeLessThanOrEqualTo(Date value) {
            addCriterion("rob_time <=", value, "robTime");
            return (Criteria) this;
        }

        public Criteria andRobTimeIn(List<Date> values) {
            addCriterion("rob_time in", values, "robTime");
            return (Criteria) this;
        }

        public Criteria andRobTimeNotIn(List<Date> values) {
            addCriterion("rob_time not in", values, "robTime");
            return (Criteria) this;
        }

        public Criteria andRobTimeBetween(Date value1, Date value2) {
            addCriterion("rob_time between", value1, value2, "robTime");
            return (Criteria) this;
        }

        public Criteria andRobTimeNotBetween(Date value1, Date value2) {
            addCriterion("rob_time not between", value1, value2, "robTime");
            return (Criteria) this;
        }
    }

    /**
     * red_rob_record
     */
    public static class Criteria extends GeneratedCriteria {
        protected Criteria() {
            super();
        }
    }

    /**
     * red_rob_record 2024-10-12
     */
    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}