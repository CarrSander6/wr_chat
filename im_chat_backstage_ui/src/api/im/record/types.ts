export interface RecordVO {
  /**
   * 
   */
  id: string | number;

  /**
   * 用户id
   */
  userId: string | number;

  /**
   * 红包全局唯一标识串
   */
  redPacket: string;

  /**
   * 人数
   */
  total: number;

  /**
   * 总金额(单位为分)
   */
  amount: number;

  /**
   * 是否有效
   */
  isActive: number;

}

export interface RecordForm extends BaseEntity {
  /**
   * 
   */
  id?: string | number;

  /**
   * 用户id
   */
  userId?: string | number;

  /**
   * 红包全局唯一标识串
   */
  redPacket?: string;

  /**
   * 人数
   */
  total?: number;

  /**
   * 总金额(单位为分)
   */
  amount?: number;

  /**
   * 是否有效
   */
  isActive?: number;

}

export interface RecordQuery extends PageQuery {

  /**
   * 用户id
   */
  userId?: string | number;

  /**
   * 红包全局唯一标识串
   */
  redPacket?: string;

  /**
   * 人数
   */
  total?: number;

  /**
   * 总金额(单位为分)
   */
  amount?: number;

  /**
   * 是否有效
   */
  isActive?: number;

    /**
     * 日期范围参数
     */
    params?: any;
}



