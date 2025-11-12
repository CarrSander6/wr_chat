export interface RobRecordVO {
  /**
   * 
   */
  id: string | number;

  /**
   * 用户账号
   */
  userId: string | number;

  /**
   * 红包标识串
   */
  redPacket: string;

  /**
   * 红包金额(单位为分)
   */
  amount: number;

  /**
   * 时间
   */
  robTime: string;

}

export interface RobRecordForm extends BaseEntity {
  /**
   * 
   */
  id?: string | number;

  /**
   * 用户账号
   */
  userId?: string | number;

  /**
   * 红包标识串
   */
  redPacket?: string;

  /**
   * 红包金额(单位为分)
   */
  amount?: number;

  /**
   * 时间
   */
  robTime?: string;

}

export interface RobRecordQuery extends PageQuery {

  /**
   * 用户账号
   */
  userId?: string | number;

  /**
   * 红包标识串
   */
  redPacket?: string;

  /**
   * 红包金额(单位为分)
   */
  amount?: number;

  /**
   * 时间
   */
  robTime?: string;

    /**
     * 日期范围参数
     */
    params?: any;
}



