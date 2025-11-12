package org.dromara.common.core.utils.ip;

import cn.hutool.core.net.NetUtil;
import cn.hutool.http.HtmlUtil;
import org.dromara.common.core.utils.StringUtils;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.regex.Pattern;

/**
 * 获取地址类
 *
 * @author Lion Li
 */
@Slf4j
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class AddressUtils {

    // 未知地址
    public static final String UNKNOWN = "XX XX";

    // IPv4 地址正则表达式
    private static final Pattern IPV4_PATTERN = Pattern.compile(
        "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    );

    // IPv6 地址正则表达式（简化版）
    private static final Pattern IPV6_PATTERN = Pattern.compile(
        "^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$|^::1$|^::(ffff:)?([0-9]{1,3}\\.){3}[0-9]{1,3}$"
    );

    public static String getRealAddressByIP(String ip) {
        if (StringUtils.isBlank(ip)) {
            return UNKNOWN;
        }

        try {
            // 清理HTML标签
            ip = HtmlUtil.cleanHtmlTag(ip);

            // 去除空格和其他无效字符
            ip = ip.trim();

            // 处理本地回环地址
            if ("127.0.0.1".equals(ip) || "localhost".equals(ip)) {
                return "内网IP";
            }

            // 处理IPv6回环地址 (::1 或 0:0:0:0:0:0:0:1)
            if (StringUtils.containsAny(ip, "0:0:0:0:0:0:0:1", "::1")) {
                return "内网IP";
            }

            // 验证IP地址格式
            if (!isValidIpAddress(ip)) {
                log.warn("Invalid IP address format: {}", ip);
                return UNKNOWN;
            }

            // 检查是否为内网IP (支持IPv4和IPv6)
            if (NetUtil.isInnerIP(ip)) {
                return "内网IP";
            }

            // 查询IP地址信息 (IPv6会返回"未知")
            return RegionUtils.getCityInfo(ip);

        } catch (Exception e) {
            log.error("Error processing IP address: {}, error: {}", ip, e.getMessage());
            return UNKNOWN;
        }
    }

    /**
     * 验证IP地址格式是否有效
     *
     * @param ip IP地址
     * @return 是否为有效的IP地址
     */
    private static boolean isValidIpAddress(String ip) {
        if (StringUtils.isBlank(ip)) {
            return false;
        }

        // 检查是否为IPv4格式
        if (IPV4_PATTERN.matcher(ip).matches()) {
            return true;
        }

        // 检查是否为IPv6格式（简化检查）
        return ip.contains(":") && IPV6_PATTERN.matcher(ip).matches();
    }
}
