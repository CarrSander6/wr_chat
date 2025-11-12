package com.bx.implatform.util;

import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.Map;

/**
 * iOS内购验证工具类
 * 
 * @author Blue
 * @date 2025-01-12
 */
@Slf4j
public class IOSReceiptVerifyUtil {

    /**
     * 生产环境验证地址
     */
    private static final String PRODUCTION_URL = "https://buy.itunes.apple.com/verifyReceipt";

    /**
     * 沙盒环境验证地址
     */
    private static final String SANDBOX_URL = "https://sandbox.itunes.apple.com/verifyReceipt";

    /**
     * 验证iOS收据
     * 
     * @param receiptData Base64编码的收据数据
     * @param password 应用共享密钥（用于自动续订订阅）
     * @param isSandbox 是否沙盒环境
     * @return 验证结果
     */
    public static VerifyResult verifyReceipt(String receiptData, String password, boolean isSandbox) {
        String url = isSandbox ? SANDBOX_URL : PRODUCTION_URL;
        
        Map<String, Object> params = new HashMap<>();
        params.put("receipt-data", receiptData);
        if (password != null && !password.isEmpty()) {
            params.put("password", password);
        }
        params.put("exclude-old-transactions", true);

        try {
            String response = HttpUtil.post(url, JSONUtil.toJsonStr(params));
            JSONObject jsonObject = JSONUtil.parseObj(response);
            
            int status = jsonObject.getInt("status");
            
            // 状态码21007表示沙盒收据发送到了生产环境，需要重试
            if (status == 21007 && !isSandbox) {
                log.info("Sandbox receipt sent to production, retrying with sandbox URL");
                return verifyReceipt(receiptData, password, true);
            }
            
            // 状态码21008表示生产收据发送到了沙盒环境，需要重试
            if (status == 21008 && isSandbox) {
                log.info("Production receipt sent to sandbox, retrying with production URL");
                return verifyReceipt(receiptData, password, false);
            }

            VerifyResult result = new VerifyResult();
            result.setStatus(status);
            result.setValid(status == 0);
            result.setMessage(getStatusMessage(status));
            result.setReceipt(jsonObject.getJSONObject("receipt"));
            result.setLatestReceiptInfo(jsonObject.getJSONArray("latest_receipt_info"));
            result.setPendingRenewalInfo(jsonObject.getJSONArray("pending_renewal_info"));
            
            return result;
        } catch (Exception e) {
            log.error("iOS receipt verification failed", e);
            VerifyResult result = new VerifyResult();
            result.setStatus(-1);
            result.setValid(false);
            result.setMessage("验证失败: " + e.getMessage());
            return result;
        }
    }

    /**
     * 获取状态码对应的消息
     * 
     * @param status 状态码
     * @return 消息
     */
    private static String getStatusMessage(int status) {
        switch (status) {
            case 0:
                return "验证成功";
            case 21000:
                return "App Store无法读取您提供的JSON数据";
            case 21002:
                return "收据数据不符合格式";
            case 21003:
                return "收据无法被验证";
            case 21004:
                return "您提供的共享密钥不匹配您账户中的共享密钥";
            case 21005:
                return "收据服务器当前不可用";
            case 21006:
                return "收据是有效的，但订阅服务已过期";
            case 21007:
                return "收据信息是测试用（sandbox），但却被发送到产品环境中验证";
            case 21008:
                return "收据信息是产品环境中使用，但却被发送到测试环境中验证";
            case 21009:
                return "内部数据访问错误";
            case 21010:
                return "用户账户无法找到或已被删除";
            default:
                return "未知错误";
        }
    }

    /**
     * 验证结果
     */
    public static class VerifyResult {
        /**
         * 状态码
         */
        private int status;

        /**
         * 是否有效
         */
        private boolean valid;

        /**
         * 消息
         */
        private String message;

        /**
         * 收据信息
         */
        private JSONObject receipt;

        /**
         * 最新收据信息（用于订阅）
         */
        private Object latestReceiptInfo;

        /**
         * 待续订信息
         */
        private Object pendingRenewalInfo;

        // Getters and Setters
        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public boolean isValid() {
            return valid;
        }

        public void setValid(boolean valid) {
            this.valid = valid;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public JSONObject getReceipt() {
            return receipt;
        }

        public void setReceipt(JSONObject receipt) {
            this.receipt = receipt;
        }

        public Object getLatestReceiptInfo() {
            return latestReceiptInfo;
        }

        public void setLatestReceiptInfo(Object latestReceiptInfo) {
            this.latestReceiptInfo = latestReceiptInfo;
        }

        public Object getPendingRenewalInfo() {
            return pendingRenewalInfo;
        }

        public void setPendingRenewalInfo(Object pendingRenewalInfo) {
            this.pendingRenewalInfo = pendingRenewalInfo;
        }

        /**
         * 获取产品ID
         */
        public String getProductId() {
            if (receipt != null && receipt.containsKey("product_id")) {
                return receipt.getStr("product_id");
            }
            return null;
        }

        /**
         * 获取交易ID
         */
        public String getTransactionId() {
            if (receipt != null && receipt.containsKey("transaction_id")) {
                return receipt.getStr("transaction_id");
            }
            return null;
        }

        /**
         * 获取原始交易ID
         */
        public String getOriginalTransactionId() {
            if (receipt != null && receipt.containsKey("original_transaction_id")) {
                return receipt.getStr("original_transaction_id");
            }
            return null;
        }
    }
}
