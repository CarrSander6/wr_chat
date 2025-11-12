import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { RecordVO, RecordForm, RecordQuery } from '@/api/im/record/types';

/**
 * 查询发红包记录列表
 * @param query
 * @returns {*}
 */

export const listRecord = (query?: RecordQuery): AxiosPromise<RecordVO[]> => {
  return request({
    url: '/im/record/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询发红包记录详细
 * @param id
 */
export const getRecord = (id: string | number): AxiosPromise<RecordVO> => {
  return request({
    url: '/im/record/' + id,
    method: 'get'
  });
};

/**
 * 新增发红包记录
 * @param data
 */
export const addRecord = (data: RecordForm) => {
  return request({
    url: '/im/record',
    method: 'post',
    data: data
  });
};

/**
 * 修改发红包记录
 * @param data
 */
export const updateRecord = (data: RecordForm) => {
  return request({
    url: '/im/record',
    method: 'put',
    data: data
  });
};

/**
 * 删除发红包记录
 * @param id
 */
export const delRecord = (id: string | number | Array<string | number>) => {
  return request({
    url: '/im/record/' + id,
    method: 'delete'
  });
};
