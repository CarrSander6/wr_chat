import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { RobRecordVO, RobRecordForm, RobRecordQuery } from '@/api/im/robRecord/types';

/**
 * 查询抢红包记录列表
 * @param query
 * @returns {*}
 */

export const listRobRecord = (query?: RobRecordQuery): AxiosPromise<RobRecordVO[]> => {
  return request({
    url: '/im/robRecord/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询抢红包记录详细
 * @param id
 */
export const getRobRecord = (id: string | number): AxiosPromise<RobRecordVO> => {
  return request({
    url: '/im/robRecord/' + id,
    method: 'get'
  });
};

/**
 * 新增抢红包记录
 * @param data
 */
export const addRobRecord = (data: RobRecordForm) => {
  return request({
    url: '/im/robRecord',
    method: 'post',
    data: data
  });
};

/**
 * 修改抢红包记录
 * @param data
 */
export const updateRobRecord = (data: RobRecordForm) => {
  return request({
    url: '/im/robRecord',
    method: 'put',
    data: data
  });
};

/**
 * 删除抢红包记录
 * @param id
 */
export const delRobRecord = (id: string | number | Array<string | number>) => {
  return request({
    url: '/im/robRecord/' + id,
    method: 'delete'
  });
};
