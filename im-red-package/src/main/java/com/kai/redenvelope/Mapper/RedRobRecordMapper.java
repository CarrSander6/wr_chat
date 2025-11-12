package com.kai.redenvelope.Mapper;

import com.kai.redenvelope.entity.RedRobRecord;
import com.kai.redenvelope.entity.RedRobRecordExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface RedRobRecordMapper {
    /**
     *
     * @mbg.generated 2024-10-12
     */
    long countByExample(RedRobRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int deleteByExample(RedRobRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int deleteByPrimaryKey(Integer id);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int insert(RedRobRecord record);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int insertSelective(RedRobRecord record);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    List<RedRobRecord> selectByExample(RedRobRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    RedRobRecord selectByPrimaryKey(Integer id);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByExampleSelective(@Param("record") RedRobRecord record, @Param("example") RedRobRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByExample(@Param("record") RedRobRecord record, @Param("example") RedRobRecordExample example);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByPrimaryKeySelective(RedRobRecord record);

    /**
     *
     * @mbg.generated 2024-10-12
     */
    int updateByPrimaryKey(RedRobRecord record);
}