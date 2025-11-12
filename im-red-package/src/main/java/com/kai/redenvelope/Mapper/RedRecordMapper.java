package com.kai.redenvelope.Mapper;

import com.kai.redenvelope.entity.RedRecord;
import com.kai.redenvelope.entity.RedRecordExample;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


public interface RedRecordMapper {
    /**
     *
     * @mbg.generated 2024-10-12
     */
    long countByExample(RedRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int deleteByExample(RedRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int deleteByPrimaryKey(Integer id);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int insert(RedRecord record);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int insertSelective(RedRecord record);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    List<RedRecord> selectByExample(RedRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    RedRecord selectByPrimaryKey(Integer id);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByExampleSelective(@Param("record") RedRecord record, @Param("example") RedRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByExample(@Param("record") RedRecord record, @Param("example") RedRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByPrimaryKeySelective(RedRecord record);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByPrimaryKey(RedRecord record);
}