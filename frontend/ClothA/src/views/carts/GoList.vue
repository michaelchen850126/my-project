<template>
  <div class="order-list-container">
    <div v-if="orderDetails" class="order-summary">
      <p>您的訂單編號為：{{ orderDetails.ordernum }}</p>
      <div class="order-info">
        <div class="payment-info">
          <h2 class="section-title">購物明細</h2>
          <table class="order-table">
            <thead>
              <tr>
                <th>商品名稱</th>
                <th>活動名稱</th>
                <th>數量</th>
                <th>單價</th>
                <th>折扣價</th>
                <th>小計</th>
              </tr>
            </thead>
            <tbody>
  <tr v-for="detail in orderDetails.orderDetails" :key="detail.id">
    <td>
      <img :src="'data:image/jpeg;base64,' + detail.product.img" alt="Product Image" width="150" >
      <div>{{ detail.product.name }}</div>
      <div>尺寸: {{ detail.product.size }}</div>
    </td>
    <td>{{ detail.product.activity }}</td>
    <td>{{ detail.cart.quantity }}</td>
    <td><del>${{ detail.product.price }}</del></td>
    <td>${{ detail.product.discount_price }}</td>
    <td>${{ detail.cart.quantity * detail.product.discount_price }}</td>
  </tr>
</tbody>

          </table>
      
          <div class="total-amount">
    <div><strong>商品金額小計:</strong> {{ subtotal }}</div>
    <div><strong>運費:</strong> {{ formatAmount(shippingFee) }}</div>
    <div><strong>折價券:</strong> <span class="red-text2">-{{ orderDetails.couponowner && orderDetails.couponowner.coupon ? orderDetails.couponowner.coupon.discount : '無折價券' }}</span></div>
    <div><strong>總計:</strong> <span class="red-text">${{ formatAmount(orderDetails.totalAmount) }}</span></div>
</div>
        </div>
      </div>
      <div class="payment-info">
        <h2 class="section-title">付款方式與寄送資料</h2>
        <div><strong>收件者姓名:</strong> {{ orderDetails.recipientName }}</div>
        <div><strong>收件者電話:</strong> {{ orderDetails.recipientPhone }}</div>
        <div><strong>寄送方式:</strong> {{ orderDetails.shippingMethod }}</div>
        <div><strong>寄送地址:</strong> {{ orderDetails.address }}</div>
        <div><strong>付款方式:</strong> {{ orderDetails.paymentMethod }}</div>
      </div>
      <div class="notice">
        <h2 class="section-title">注意事項</h2>
        <ul>
          <li>本訂單顏色因拍攝光線影響，商品以實際顏色為準。</li>
          <li>您可以隨時追蹤您的訂單狀態，查詢您的訂單處理進度。</li>
          <li>如有任何疑問，請聯繫客服，我們將為您提供協助。</li>
        </ul>
      </div>
    </div>
    <div v-else>
      <p>尚未載入訂單資料。</p>
    </div>
    <div class="button-container">
    <button class="back-button" @click="goBack">返回上一頁</button>
  </div></div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const orderDetails = ref(null);
const router = useRouter();
const shippingFee = ref(0);

const subtotal = computed(() => {
  if (!orderDetails.value) return 0;
  return orderDetails.value.orderDetails.reduce((acc, detail) => {
    const total = acc + detail.cart.quantity * detail.product.discount_price;
    console.log(total, "total");
    return total;
  }, 0);
});



onMounted(() => {
  fetchOrderDetails();
  calculateShippingFee();
});

function fetchOrderDetails() {
  const storedOrderDetails = sessionStorage.getItem('orderDetails');
  if (storedOrderDetails) {
    const orderDetailsArray = JSON.parse(storedOrderDetails);
    if (orderDetailsArray.length > 0) {
      orderDetails.value = orderDetailsArray[0]; // 假設只顯示第一個訂單的詳細資訊
    }
  }
}

function calculateShippingFee() {
  if (orderDetails.value) {
    shippingFee.value = orderDetails.value.shippingMethod === '宅配' ? 100 : 60;
  }
}

function formatAmount(amount) {
  return Math.floor(amount);
}

function goBack() {
  router.push('/carts/OrderList'); // 確保此路由存在
}
</script>

<style scoped>
.button-container {
  text-align: center; /* 使按鈕居中 */
}

.back-button {
  display: inline-block; /* 改為 inline-block 使其適應內容 */
  padding: 10px 20px;
  margin: 20px auto;
  background-color: #8a6d3b; /* 主色調 */
  color: #fff; /* 文字顏色 */
  border: none;
  border-radius: 5px; /* 圓角邊框 */
  cursor: pointer; /* 鼠標懸停時顯示手型 */
  font-size: 16px; /* 字體大小 */
  font-weight: bold; /* 文字加粗 */
  text-align: center; /* 文字居中 */
  transition: background-color 0.3s ease, transform 0.2s ease; /* 過渡效果 */
}

.back-button:hover {
  background-color: #6f4f28; /* 懸停時背景顏色 */
  transform: translateY(-2px); /* 懸停時輕微向上移動 */
}

.back-button:active {
  background-color: #1f6d98; /* 點擊時背景顏色 */
  transform: translateY(1px); /* 點擊時輕微向下移動 */
}


.order-list-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.title {
  font-size: 24px;
  margin-bottom: 20px;
  color: #333;
  text-align: center;
}

.section-title {
  font-size: 20px;
  margin: 20px 0;
  color: #333;
  border-bottom: 2px solid #ddd;
  padding-bottom: 10px;
}

.order-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

.order-table th, .order-table td {
  border: 1px solid #ddd;
  padding: 10px;
  text-align: center;
}

.order-table th {
  background-color: #f7f7f7;
}

.product-image {
  width: 50px;
  height: 50px;
  object-fit: cover;
  margin-right: 10px;
}

.payment-info, .notice {
  margin-top: 20px;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background-color: #f9f9f9;
}

.notice ul {
  padding-left: 20px;
}

.notice li {
  margin-bottom: 10px;
}

.total-amount{
  margin-top: 35px;
  text-align: center;
  font-size: 15px;
  font-family: '微軟正黑體';
  font-weight: 600;
}

.red-text {
  color: #c14948;
  font-size: 25px;
}

.red-text2 {
  color: #c14948;
  font-size: 15px;
}
</style>