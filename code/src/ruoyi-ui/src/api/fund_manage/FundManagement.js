import request from '@/utils/request'

// 查询基金管理列表
export function listFundManagement(query) {
  return request({
    url: '/fund_manage/FundManagement/list',
    method: 'get',
    params: query
  })
}

// 查询基金管理详细
export function getFundManagement(fId) {
  return request({
    url: '/fund_manage/FundManagement/' + fId,
    method: 'get'
  })
}

// 新增基金管理
export function addFundManagement(data) {
  return request({
    url: '/fund_manage/FundManagement',
    method: 'post',
    data: data
  })
}

// 修改基金管理
export function updateFundManagement(data) {
  return request({
    url: '/fund_manage/FundManagement',
    method: 'put',
    data: data
  })
}

// 删除基金管理
export function delFundManagement(fId) {
  return request({
    url: '/fund_manage/FundManagement/' + fId,
    method: 'delete'
  })
}
