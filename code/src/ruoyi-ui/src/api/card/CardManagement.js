import request from '@/utils/request'

// 查询银行卡管理列表
export function listCardManagement(query) {
  return request({
    url: '/card/CardManagement/list',
    method: 'get',
    params: query
  })
}

// 查询银行卡管理详细
export function getCardManagement(cardId) {
  return request({
    url: '/card/CardManagement/' + cardId,
    method: 'get'
  })
}

// 新增银行卡管理
export function addCardManagement(data) {
  return request({
    url: '/card/CardManagement',
    method: 'post',
    data: data
  })
}

// 修改银行卡管理
export function updateCardManagement(data) {
  return request({
    url: '/card/CardManagement',
    method: 'put',
    data: data
  })
}

// 删除银行卡管理
export function delCardManagement(cardId) {
  return request({
    url: '/card/CardManagement/' + cardId,
    method: 'delete'
  })
}
