import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { UserRechargeVO, UserRechargeForm, UserRechargeQuery } from '@/api/im/userRecharge/types';

/**
 * 查询用户充值记录列表
 * @param query
 * @returns {*}
 */

export const listUserRecharge = (query?: UserRechargeQuery): AxiosPromise<UserRechargeVO[]> => {
  return request({
    url: '/im/userRecharge/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询用户充值记录详细
 * @param id
 */
export const getUserRecharge = (id: string | number): AxiosPromise<UserRechargeVO> => {
  return request({
    url: '/im/userRecharge/' + id,
    method: 'get'
  });
};

/**
 * 新增用户充值记录
 * @param data
 */
export const addUserRecharge = (data: UserRechargeForm) => {
  return request({
    url: '/im/userRecharge',
    method: 'post',
    data: data
  });
};

/**
 * 修改用户充值记录
 * @param data
 */
export const updateUserRecharge = (data: UserRechargeForm) => {
  return request({
    url: '/im/userRecharge',
    method: 'put',
    data: data
  });
};

/**
 * 删除用户充值记录
 * @param id
 */
export const delUserRecharge = (id: string | number | Array<string | number>) => {
  return request({
    url: '/im/userRecharge/' + id,
    method: 'delete'
  });
};
