import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { UserFundDetailVO, UserFundDetailForm, UserFundDetailQuery } from '@/api/im/userFundDetail/types';

/**
 * 查询用户资产明细列表
 * @param query
 * @returns {*}
 */

export const listUserFundDetail = (query?: UserFundDetailQuery): AxiosPromise<UserFundDetailVO[]> => {
  return request({
    url: '/im/userFundDetail/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询用户资产明细详细
 * @param id
 */
export const getUserFundDetail = (id: string | number): AxiosPromise<UserFundDetailVO> => {
  return request({
    url: '/im/userFundDetail/' + id,
    method: 'get'
  });
};

/**
 * 新增用户资产明细
 * @param data
 */
export const addUserFundDetail = (data: UserFundDetailForm) => {
  return request({
    url: '/im/userFundDetail',
    method: 'post',
    data: data
  });
};

/**
 * 修改用户资产明细
 * @param data
 */
export const updateUserFundDetail = (data: UserFundDetailForm) => {
  return request({
    url: '/im/userFundDetail',
    method: 'put',
    data: data
  });
};

/**
 * 删除用户资产明细
 * @param id
 */
export const delUserFundDetail = (id: string | number | Array<string | number>) => {
  return request({
    url: '/im/userFundDetail/' + id,
    method: 'delete'
  });
};
