export interface UserComplaintVO {
  /**
   * id
   */
  id: number;

  /**
   *  发起用户id
   */
  userId: number;

  /**
   * 发起用户名
   */
  userName: String;

  /**
   * 投诉对象类型 1:用户 2:群聊
   */
  targetType: number;

  /**
   * 投诉对象id
   */
  targetId: number;


  /**
   * 投诉对象名称
   */
  targetName: string;

  /**
   * 投诉原因类型 字典: im_complatin_type
   */
  type: number;

  /**
   * 图片列表,最多9张
   */
  images?: string;

  /**
   * 投诉内容
   */
  content?: string;

  /**
   *处理状态 1:未处理 2:已处理
  */
  status: number;
  /**
   * 处理投诉的管理员id
   */
  resolvedAdminId?: number;

  /**
   * 处理结果类型
   */
  resolvedType?: number;

  /**
   * 处理结果摘要
   */
  resolvedSummary?: string;

  /**
   * 处理时间
   */
  resolvedTime?: string;

  /**
  * 创建投诉时间
  */
  createTime: string

}

export interface UserComplaintForm {
  /**
   * id
   */
  id: number;

  /**
   *  发起用户id
   */
  userId: number;

  /**
   * 发起用户名
   */
  userName: String;

  /**
   * 投诉对象类型 1:用户 2:群聊
   */
  targetType: number;

  /**
   * 投诉对象id
   */
  targetId: number;


  /**
   * 投诉对象ming
   */
  targetName: string;

  /**
   * 投诉原因类型 字典: im_complatin_type
   */
  type: number;

  /**
   * 图片列表,最多9张
   */
  images?: string;

  /**
   * 内容
   */
  content: string;

  /**
   *处理状态 1:未处理 2:已处理
  */
  status: number;
  /**
   * 处理投诉的管理员id
   */
  resolvedAdminId?: number;

  /**
   * 处理投诉的管理员用户名
   */
  resolvedAdminName?: String;
  /**
   * 处理结果类型
   */
  resolvedType?: number;

  /**
   * 处理结果摘要
   */
  resolvedSummary?: string;

  /**
   * 处理时间
   */
  resolvedTime?: string;

  /**
  * 创建投诉时间
  */
  createTime: string

}

export interface UserComplaintQuery extends PageQuery {

  /**
   * 用户id
   */
  userId?: number;

  /**
   *处理状态 1:未处理 2:已处理
   */
  status: number;

  /**
   * 投诉原因类型 字典: im_complatin_type
   */
  type?: number;

}
