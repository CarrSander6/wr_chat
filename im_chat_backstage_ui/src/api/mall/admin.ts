import request from '@/utils/request'

export function listCategories(parentId?: number) {
  return request({ url: '/mall/admin/category/list', method: 'get', params: { parentId } })
}

export function createCategory(data: { name: string; parentId?: number; sortOrder?: number }) {
  return request({ url: '/mall/admin/category/create', method: 'post', params: data })
}

export function updateCategory(id: number, data: { name: string; parentId?: number; sortOrder?: number; status?: number }) {
  return request({ url: `/mall/admin/category/update/${id}`, method: 'put', params: data })
}

export function deleteCategory(id: number) {
  return request({ url: `/mall/admin/category/delete/${id}`, method: 'delete' })
}

export function listSkus(productId: number) {
  return request({ url: '/mall/admin/sku/list', method: 'get', params: { productId } })
}

export function addSku(data: { productId: number; skuCode: string; attributes?: string; price: number; stock: number }) {
  return request({ url: '/mall/admin/sku/add', method: 'post', params: data })
}

export function updateSku(id: number, data: { attributes?: string; price?: number; stock?: number; status?: number }) {
  return request({ url: `/mall/admin/sku/update/${id}`, method: 'put', params: data })
}

export function deleteSku(id: number) {
  return request({ url: `/mall/admin/sku/delete/${id}`, method: 'delete' })
}

export function shipOrder(data: { orderId: number; carrier: string; shippingNo: string }) {
  return request({ url: '/mall/admin/order/ship', method: 'post', params: data })
}

export function listAfterSales(params: { pageNum?: number; pageSize?: number; status?: number }) {
  return request({ url: '/mall/admin/aftersale/list', method: 'get', params })
}

export function approveAfterSale(id: number) {
  return request({ url: '/mall/admin/aftersale/approve', method: 'post', params: { id } })
}

export function rejectAfterSale(id: number, reason?: string) {
  return request({ url: '/mall/admin/aftersale/reject', method: 'post', params: { id, reason } })
}