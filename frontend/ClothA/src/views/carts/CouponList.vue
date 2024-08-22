<template>
  <div class="coupon-list">
    <h2>領取折價券</h2>
    <ul class="coupon-list__items">
      <li v-for="coupon in coupons" :key="coupon.id" class="coupon-list__item">
        <div class="coupon">
          <h3 class="coupon__title">{{ coupon.name }}</h3>
          <p class="coupon__description">{{ coupon.description }}</p>
          <p class="coupon__discount">折扣: {{ coupon.discount }}</p>
          <p class="coupon__validity">
            有效期: {{ new Date(coupon.start_at).toLocaleDateString() }} - {{ new Date(coupon.end_at).toLocaleDateString() }}
          </p>
          <button @click="claimCoupon(coupon.id)" class="coupon__button">領取</button>
        </div>
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axiosapi from '@/plugins/axios.js';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';

const coupons = ref([]);
const userId = sessionStorage.getItem('userId');

// Fetch coupons from the API
function fetchCoupons() {
  axiosapi.get('/api/coupons/available')
    .then(response => {
      console.log("response.data", response.data);
      coupons.value = response.data || [];
    })
    .catch(error => {
      console.error('Error fetching coupons:', error);
    });
}

// Claim a coupon by sending the coupon ID and user ID to the API
function claimCoupon(couponId) {
  if (!userId) {
    Swal.fire({
      icon: 'error',
      title: '錯誤',
      text: 'User ID is missing.'
    });
    return;
  }

  axiosapi.post('/api/coupons/claim', null, {
    params: {
      couponId: couponId,
      userId: userId
    }
  })
    .then(response => {
      if (response.status === 200) {
        Swal.fire({
          icon: 'success',
          title: '成功',
          text: '領取成功，開始購物吧!'
        }).then(() => {
          // 重定向到 /
          window.location.href = '/';
        });
        fetchCoupons(); // Refresh the list of available coupons
      } else {
        Swal.fire({
          icon: 'error',
          title: '失敗',
          text: '如有疑問請洽客服，將為您處理'
        });
      }
    })
    .catch(error => {
      // console.error('Error claiming coupon:', error);
      Swal.fire({
        icon: 'error',
        title: '已擁有此折價券',
        text: '請到購物車確認折價券'
      });
    });
}

// Fetch coupons when the component is mounted
onMounted(() => {
  fetchCoupons();
});
</script>

<style scoped>
.coupon-list {
  padding: 20px;
  background-color: #f9f9f9;
}

.coupon-list__items {
  list-style-type: none;
  padding: 0;
}

.coupon-list__item {
  margin-bottom: 20px;
}

.coupon {
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background-color: #fff;
}

.coupon__title {
  font-size: 20px;
  margin-bottom: 10px;
}

.coupon__description,
.coupon__discount,
.coupon__validity {
  margin-bottom: 5px;
}

.coupon__button {
  padding: 10px 20px;
  background-color: #8a6d3b;
  color: white;
  border: none;
  border-radius: 5px; /* 圓角邊框 */
  cursor: pointer; /* 鼠標懸停時顯示手型 */
}

.coupon__button:hover {
  background-color: #6f4f28;
}
</style>
