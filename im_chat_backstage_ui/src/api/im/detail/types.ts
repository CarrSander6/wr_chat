export interface DetailVO {
  /**
   * 
   */
  id: string | number;

  /**
   * 红包记录id
   */
  recordId: string | number;

  /**
   * 金额(单位为分)
   */
  amount: number;

  /**
   * 是否有效
   */
  isActive: number;

}

export interface DetailForm extends BaseEntity {
  /**
   * 
   */
  id?: string | number;

  /**
   * 红包记录id
   */
  recordId?: string | number;

  /**
   * 金额(单位为分)
   */
  amount?: number;

  /**
   * 是否有效
   */
  isActive?: number;

}

export interface DetailQuery extends PageQuery {

  /**
   * 红包记录id
   */
  recordId?: string | number;

  /**
   * 金额(单位为分)
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



