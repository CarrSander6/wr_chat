import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { UserComplaintVO, UserComplaintForm, UserComplaintQuery } from '@/api/im/complaint/types';

/**
 * 查询用户投诉列表
 * @param query
 * @returns {*}
 */

export const listUserComplaint = (query?: UserComplaintQuery): AxiosPromise<UserComplaintVO[]> => {
  return request({
    url: '/im/complaint/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询用户投诉详细
 * @param id
 */
export const getUserComplaint = (id: string | number): AxiosPromise<UserComplaintVO> => {
  return request({
    url: '/im/complaint/' + id,
    method: 'get'
  });
};

/**
 * 处理用户投诉
 * @param data
 */
export const resloveUserComplaint = (data: UserComplaintForm) => {
  return request({
    url: '/im/complaint/reslove',
    method: 'post',
    data: data
  });
};