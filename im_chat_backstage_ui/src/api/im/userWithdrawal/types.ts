export interface UserWithdrawalVO {
  /**
   * 主键
   */
  id: string | number;

  /**
   * 用户id
   */
  userId: string | number;

  /**
   * 类型（1余额）
   */
  type: number;

  /**
   * 订单编号
   */
  orderSn: string;

  /**
   * 提现金额
   */
  amount: number;

  /**
   * 手续费
   */
  feeAmount: number;

  /**
   * 实际到账金额
   */
  actualAmount: number;

  /**
   * hash
   */
  txHash: string;

  /**
   * 状态（1：待审核 2：待确认 3: 已到账 4: 未到账 5: 审核拒绝）
   */
  status: number;

  /**
   * 时间
   */
  transferTime: string;

  /**
   * 提现地址
   */
  fromAddress: string;

  /**
   * 数据
   */
  notifyData: string;

  /**
   * 备注
   */
  remark: string;

}

export interface UserWithdrawalForm extends BaseEntity {
  /**
   * 主键
   */
  id?: string | number;

  /**
   * 用户id
   */
  userId?: string | number;

  /**
   * 类型（1余额）
   */
  type?: number;

  /**
   * 订单编号
   */
  orderSn?: string;

  /**
   * 提现金额
   */
  amount?: number;

  /**
   * 手续费
   */
  feeAmount?: number;

  /**
   * 实际到账金额
   */
  actualAmount?: number;

  /**
   * hash
   */
  txHash?: string;

  /**
   * 状态（1：待审核 2：待确认 3: 已到账 4: 未到账 5: 审核拒绝）
   */
  status?: number;

  /**
   * 时间
   */
  transferTime?: string | string[];

  /**
   * 开始时间
   */
  startTime?: string;

  /**
   * 结束时间
   */
  endTime?: string;

  /**
   * 提现地址
   */
  fromAddress?: string;

  /**
   * 数据
   */
  notifyData?: string;

  /**
   * 备注
   */
  remark?: string;

}

export interface UserWithdrawalQuery extends PageQuery {

  /**
   * 用户id
   */
  userId?: string | number;

  /**
   * 类型（1余额）
   */
  type?: number;

  /**
   * 订单编号
   */
  orderSn?: string;

  /**
   * 提现金额
   */
  amount?: number;

  /**
   * 手续费
   */
  feeAmount?: number;

  /**
   * 实际到账金额
   */
  actualAmount?: number;

  /**
   * hash
   */
  txHash?: string;

  /**
   * 状态（1：待审核 2：待确认 3: 已到账 4: 未到账 5: 审核拒绝）
   */
  status?: number;

  /**
   * 时间
   */
  transferTime?: string | string[];

  /**
   * 开始时间
   */
  startTime?: string;

  /**
   * 结束时间
   */
  endTime?: string;

  /**
   * 提现地址
   */
  fromAddress?: string;

  /**
   * 数据
   */
  notifyData?: string;

    /**
     * 日期范围参数
     */
    params?: any;
}



