package com.kai.redenvelope.Mapper;

import com.kai.redenvelope.entity.RedDetail;
import com.kai.redenvelope.entity.RedDetailExample;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


public interface RedDetailMapper {
    /**
     *
     * @mbg.generated 2024-10-12
     */
    long countByExample(RedDetailExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int deleteByExample(RedDetailExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int deleteByPrimaryKey(Integer id);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int insert(RedDetail record);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int insertSelective(RedDetail record);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    List<RedDetail> selectByExample(RedDetailExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    RedDetail selectByPrimaryKey(Integer id);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByExampleSelective(@Param("record") RedDetail record, @Param("example") RedDetailExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByExample(@Param("record") RedDetail record, @Param("example") RedDetailExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByPrimaryKeySelective(RedDetail record);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByPrimaryKey(RedDetail record);
}