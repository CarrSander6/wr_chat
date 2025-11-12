export interface UserRechargeVO {
  /**
   * 主键
   */
  id: string | number;

  /**
   * 用户id
   */
  userId: string | number;

  /**
   * 订单编号
   */
  orderSn: string;

  /**
   * 充值金额
   */
  amount: number;

  /**
   * usdt金额
   */
  usdtAmount: number;

  /**
   * hash
   */
  txHash: string;

  /**
   * 状态
   */
  status: number;

  /**
   * 转出地址
   */
  fromAddress: string;

  /**
   * 转入地址
   */
  toAddress: string;

  /**
   * 链上数据
   */
  notifyData: string;

  /**
   * 凭证
   */
  img: string;

  /**
   * 备注
   */
  remark: string;

}

export interface UserRechargeForm extends BaseEntity {
  /**
   * 主键
   */
  id?: string | number;

  /**
   * 用户id
   */
  userId?: string | number;

  /**
   * 订单编号
   */
  orderSn?: string;

  /**
   * 充值金额
   */
  amount?: number;

  /**
   * usdt金额
   */
  usdtAmount?: number;

  /**
   * hash
   */
  txHash?: string;

  /**
   * 状态
   */
  status?: number;

  /**
   * 转出地址
   */
  fromAddress?: string;

  /**
   * 转入地址
   */
  toAddress?: string;

  /**
   * 链上数据
   */
  notifyData?: string;

  /**
   * 凭证
   */
  img?: string;

  /**
   * 备注
   */
  remark?: string;

}

export interface UserRechargeQuery extends PageQuery {

  /**
   * 用户id
   */
  userId?: string | number;

  /**
   * 订单编号
   */
  orderSn?: string;

  /**
   * 充值金额
   */
  amount?: number;

  /**
   * usdt金额
   */
  usdtAmount?: number;

  /**
   * hash
   */
  txHash?: string;

  /**
   * 状态
   */
  status?: number;

  /**
   * 转出地址
   */
  fromAddress?: string;

  /**
   * 转入地址
   */
  toAddress?: string;

  /**
   * 链上数据
   */
  notifyData?: string;

  /**
   * 凭证
   */
  img?: string;

    /**
     * 日期范围参数
     */
    params?: any;
}



