export interface UserFundDetailVO {
  /**
   * 主键
   */
  id: string | number;

  /**
   * 用户id
   */
  userId: string | number;

  /**
   * 描述
   */
  describes: string;

  /**
   * 资产类型
   */
  type: number;

  /**
   * 转入转出标识 -1：转出 1：转入
   */
  transferFlag: number;

  /**
   * 订单编号
   */
  orderNo: string;

  /**
   * 变动前
   */
  pointBefore: number;

  /**
   * 数量
   */
  amount: number;

  /**
   * 变动后
   */
  pointAfter: number;

  /**
   * hash
   */
  txHash: string;

  /**
   * 存证时间
   */
  txTime: string;

  /**
   * 备注
   */
  remark: string;

}

export interface UserFundDetailForm extends BaseEntity {
  /**
   * 主键
   */
  id?: string | number;

  /**
   * 用户id
   */
  userId?: string | number;

  /**
   * 描述
   */
  describes?: string;

  /**
   * 资产类型
   */
  type?: number;

  /**
   * 转入转出标识 -1：转出 1：转入
   */
  transferFlag?: number;

  /**
   * 订单编号
   */
  orderNo?: string;

  /**
   * 变动前
   */
  pointBefore?: number;

  /**
   * 数量
   */
  amount?: number;

  /**
   * 变动后
   */
  pointAfter?: number;

  /**
   * hash
   */
  txHash?: string;

  /**
   * 存证时间
   */
  txTime?: string;

  /**
   * 备注
   */
  remark?: string;

}

export interface UserFundDetailQuery extends PageQuery {

  /**
   * 用户id
   */
  userId?: string | number;

  /**
   * 描述
   */
  describes?: string;

  /**
   * 资产类型
   */
  type?: number;

  /**
   * 转入转出标识 -1：转出 1：转入
   */
  transferFlag?: number;

  /**
   * 订单编号
   */
  orderNo?: string;

  /**
   * 变动前
   */
  pointBefore?: number;

  /**
   * 数量
   */
  amount?: number;

  /**
   * 变动后
   */
  pointAfter?: number;

  /**
   * hash
   */
  txHash?: string;

  /**
   * 存证时间
   */
  txTime?: string;

    /**
     * 日期范围参数
     */
    params?: any;
}



