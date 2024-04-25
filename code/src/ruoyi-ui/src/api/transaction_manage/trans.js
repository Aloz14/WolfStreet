import request from '@/utils/request'

// 查询trans列表
export function listTrans(query) {
  return request({
    url: '/transaction_manage/trans/list',
    method: 'get',
    params: query
  })
}

// 查询trans详细
export function getTrans(fStreamId) {
  return request({
    url: '/transaction_manage/trans/' + fStreamId,
    method: 'get'
  })
}

// 新增trans
export function addTrans(data) {
  return request({
    url: '/transaction_manage/trans',
    method: 'post',
    data: data
  })
}

// 修改trans
export function updateTrans(data) {
  return request({
    url: '/transaction_manage/trans',
    method: 'put',
    data: data
  })
}

// 删除trans
export function delTrans(fStreamId) {
  return request({
    url: '/transaction_manage/trans/' + fStreamId,
    method: 'delete'
  })
}
