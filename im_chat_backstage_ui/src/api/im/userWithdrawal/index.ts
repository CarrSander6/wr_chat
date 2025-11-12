import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { UserWithdrawalVO, UserWithdrawalForm, UserWithdrawalQuery } from '@/api/im/userWithdrawal/types';

/**
 * 查询用户提现记录列表
 * @param query
 * @returns {*}
 */

export const listUserWithdrawal = (query?: UserWithdrawalQuery): AxiosPromise<UserWithdrawalVO[]> => {
  return request({
    url: '/im/userWithdrawal/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询用户提现记录详细
 * @param id
 */
export const getUserWithdrawal = (id: string | number): AxiosPromise<UserWithdrawalVO> => {
  return request({
    url: '/im/userWithdrawal/' + id,
    method: 'get'
  });
};

/**
 * 新增用户提现记录
 * @param data
 */
export const addUserWithdrawal = (data: UserWithdrawalForm) => {
  return request({
    url: '/im/userWithdrawal',
    method: 'post',
    data: data
  });
};

/**
 * 修改用户提现记录
 * @param data
 */
export const updateUserWithdrawal = (data: UserWithdrawalForm) => {
  return request({
    url: '/im/userWithdrawal',
    method: 'put',
    data: data
  });
};

/**
 * 删除用户提现记录
 * @param id
 */
export const delUserWithdrawal = (id: string | number | Array<string | number>) => {
  return request({
    url: '/im/userWithdrawal/' + id,
    method: 'delete'
  });
};
