import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { DetailVO, DetailForm, DetailQuery } from '@/api/im/detail/types';

/**
 * 查询红包明细金额列表
 * @param query
 * @returns {*}
 */

export const listDetail = (query?: DetailQuery): AxiosPromise<DetailVO[]> => {
  return request({
    url: '/im/detail/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询红包明细金额详细
 * @param id
 */
export const getDetail = (id: string | number): AxiosPromise<DetailVO> => {
  return request({
    url: '/im/detail/' + id,
    method: 'get'
  });
};

/**
 * 新增红包明细金额
 * @param data
 */
export const addDetail = (data: DetailForm) => {
  return request({
    url: '/im/detail',
    method: 'post',
    data: data
  });
};

/**
 * 修改红包明细金额
 * @param data
 */
export const updateDetail = (data: DetailForm) => {
  return request({
    url: '/im/detail',
    method: 'put',
    data: data
  });
};

/**
 * 删除红包明细金额
 * @param id
 */
export const delDetail = (id: string | number | Array<string | number>) => {
  return request({
    url: '/im/detail/' + id,
    method: 'delete'
  });
};
