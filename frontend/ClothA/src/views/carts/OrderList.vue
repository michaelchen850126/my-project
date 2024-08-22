<template>
  <div>
    <h1>訂單列表</h1>
    <div class="order-table">
      <div class="order-row order-header">
        <div>訂購日期</div>
        <div>訂單編號</div>
        <div>付款方式</div>
        <div>處理進度</div>
        <div>預計出貨日期</div>
        <div>應付金額</div>
      </div>
      <div class="order-row" v-for="order in paginatedOrders" :key="order.id">
        <div>{{ formatDate(order.orderDate) }}</div>
        <div>
          <a href="#" @click.prevent="navigateToOrderDetails(order.id)">{{ order.ordernum }}</a>
        </div>
        <div>{{ order.paymentMethod }}</div>
        <div>{{ order.status }}</div>
        <div>{{ calculateEstimatedShippingDate(order.orderDate) }}</div>
        <div>{{ order.totalAmount }}</div>
      </div>
    </div>
    <div class="pagination">
      <button @click="changePage(page - 1)" :disabled="page <= 1">上一頁</button>
      <span>Page {{ page }} of {{ totalPages }}</span>
      <button @click="changePage(page + 1)" :disabled="page >= totalPages">下一頁</button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import axiosapi from '@/plugins/axios.js'; 
import { useRouter } from 'vue-router';

const orders = ref([]);
const page = ref(1);
const perPage = 10;

const userId = ref(sessionStorage.getItem('userId'));
const router = useRouter();

onMounted(() => {
  fetchOrders();
});

function fetchOrders() {
  axiosapi.get(`/api/orders/user/${userId.value}`)
    .then(response => {
      // 假設 response.data 是一個訂單數組
      const data = response.data || [];
      // 將訂單按訂購日期降序排列
      orders.value = data.sort((a, b) => new Date(b.orderDate) - new Date(a.orderDate));
    })
    .catch(error => {
      console.error('Error fetching orders:', error);
    });
}

function navigateToOrderDetails(orderId) {
  axiosapi.get(`/api/orders/detail/${orderId}`)
    .then(response => {
      // 將訂單細節存儲到 sessionStorage
      sessionStorage.setItem('orderDetails', JSON.stringify(response.data));
      router.push('/carts/GoList'); // 跳轉到訂單列表
    })
    .catch(error => {
      console.error('Error fetching order details:', error);
    });
}

// 分頁
const totalPages = computed(() => Math.ceil(orders.value.length / perPage));
const paginatedOrders = computed(() => {
  const start = (page.value - 1) * perPage;
  const end = start + perPage;
  return orders.value.slice(start, end);
});

function changePage(newPage) {
  if (newPage >= 1 && newPage <= totalPages.value) {
    page.value = newPage;
  }
}

function formatDate(dateString) {
  const date = new Date(dateString);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}

function calculateEstimatedShippingDate(orderDate) {
  const orderDateObj = new Date(orderDate);
  orderDateObj.setDate(orderDateObj.getDate() + 7); // 七天後
  return formatDate(orderDateObj.toISOString());
}
</script>

<style scoped>
.order-table {
  display: flex;
  flex-direction: column;
  width: 100%;
  margin-top: 20px;
}

.order-row {
  display: flex;
  border: 1px solid #ddd;
}

.order-header {
  font-weight: bold;
  background-color: #f2f2f2;
}

.order-row div {
  flex: 1;
  padding: 8px;
  text-align: left;
}

.order-row div a {
  color: #3498db;
  text-decoration: none;
}

.order-row div a:hover {
  text-decoration: underline;
}

.pagination {
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 20px 0;
}

.pagination button {
  padding: 10px 20px;
  margin: 0 5px;
  background-color: #8a6d3b; /* 主色調 */
  color: #fff;
  border: none;
  border-radius: 5px; /* 圓角邊框 */
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

.pagination button:disabled {
  background-color: #bdc3c7; /* 禁用狀態的背景顏色 */
  cursor: not-allowed; /* 禁用狀態的光標 */
}

.pagination button:hover:not(:disabled) {
  background-color: #6f4f28; /* 懸停時的顏色 */
  transform: translateY(-2px); /* 懸停時輕微向上移動 */
}

.pagination button:active:not(:disabled) {
  background-color: #473116; /* 點擊時的顏色 */
  transform: translateY(1px); /* 點擊時輕微向下移動 */
}

.pagination span {
  margin: 0 10px;
  font-size: 16px;
  color: #333; /* 字體顏色 */
}


button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}
</style>