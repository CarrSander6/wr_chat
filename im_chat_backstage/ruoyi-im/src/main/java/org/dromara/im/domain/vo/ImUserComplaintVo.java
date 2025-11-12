package org.dromara.im.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.fhs.core.trans.anno.Trans;
import com.fhs.core.trans.constant.TransType;
import com.fhs.core.trans.vo.TransPojo;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.dromara.im.constant.ImConstant;
import org.dromara.im.domain.ImUser;
import org.dromara.im.domain.ImUserComplaint;
import org.dromara.system.domain.SysUser;

import java.util.Date;



/**
 * 用户投诉视图对象 im_user_complaint
 *
 * @author Blue
 * @date 2025-06-24
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = ImUserComplaint.class)
public class ImUserComplaintVo implements TransPojo {

    /**
     * id
     */
    private Long id;

    /**
     * 发起用户id
     */
    @Trans(type = TransType.SIMPLE,dataSource = ImConstant.DS_IM_PLATFORM,target = ImUser.class, fields = "userName", ref = "userName")
    private Long userId;

    /**
     * 发起用户
     */
    private String userName;


    /**
     * 投诉对象类型 1:用户 2:群聊
     */
    private Integer targetType;


    /**
     * 投诉对象id
     */
    private Long targetId;

    /**
     * 投诉对象id
     */
    private String targetName;

    /**
     * 投诉原因类型 字典: im_complatin_type
     */
    private Integer type;

    /**
     * 图片列表,最多9张
     */
    private String images;

    /**
     * 投诉内容
     */
    private String content;

    /**
     * 状态 1:未处理 2:已处理
     */
    private Integer status;

    /**
     * 处理人id
     */
    @Trans(type = TransType.SIMPLE, target = SysUser.class, fields = "userName", ref = "resolvedAdminName")
    private Long resolvedAdminId;

    /**
     * 处理人名称
     */
    private String resolvedAdminName;

    /**
     * 处理结果类型,字典:im_resolved_type
     */
    private String resolvedType;

    /**
     * 处理结果摘要
     */
    private String resolvedSummary;

    /**
     * 处理时间
     */
    private String resolvedTime;

    /**
     * 创建时间
     */
    private Date createTime;

}
