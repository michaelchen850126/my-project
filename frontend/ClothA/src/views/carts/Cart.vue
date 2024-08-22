<template>
  <div class="cart-container">
    <h2><font-awesome-icon icon="fa-solid fa-basket-shopping" />STEP 1. 確認購物車<font-awesome-icon icon="fa-solid fa-basket-shopping" /></h2>
    <br>
      <!-- 進度條 -->
    <div class="shopping_steps">
      <div class="alpha grid_36 omega shoppingSteps"></div>
      <ol class="steps alpha grid_36 omega">
        <li :class="{'active': currentStep >= 1}"><span>STEP 1. 確認購物車</span></li>
        <li :class="{'active': currentStep >= 2}"><span>STEP 2. 付款與運送方式</span></li>
        <li :class="{'active': currentStep >= 3}"><span>STEP 3. 確認訂單資料</span></li>
        <li :class="{'active': currentStep >= 4}"><span>STEP 4. 完成訂購</span></li>
      </ol>
      <div class="clear"></div>
    </div>

    <div v-if="cart.length === 0" class="empty-cart">
      <p>購物車中暫無商品。</p>
    </div>
    
    <div v-else>
      <div v-for="item in filteredCart" :key="item.id" class="cart-item">
        <div class="item-details">
          <div class="item-image">
    <img :src="'data:image/jpeg;base64,' + item.product.img" alt="Product Image" >
</div>

          <div class="item-info">
            <p><strong>商品名稱:</strong> {{ item.product.name }}</p>
            <p><strong>尺寸:</strong> {{ item.product.size }}</p>
            <p><strong>顏色:</strong> {{ item.product.color }}</p>
            <p><strong>價錢:</strong> ${{ item.product.price }}</p>
            <p><strong>優惠價:</strong> ${{ item.product.discount_price }}<strong style="color: #c14948;">({{ item.product.activity }})</strong></p>
            <p><strong>數量:</strong>
              <button class="quantity-btn" @click="updateQuantity(item, item.quantity - 1)">-</button>
              {{ item.quantity }}
              <button class="quantity-btn" @click="updateQuantity(item, item.quantity + 1)">+</button>
            </p>
            <p><strong>小計:</strong> ${{ (item.product.discount_price * item.quantity).toFixed(2) }}</p>
          </div>
          <div class="item-actions">
            <input type="checkbox" @click="checkbox(item.id)" v-model="item.checked" @change="calculateTotal">
            <button class="remove-btn" @click="removeItem(item.id)">刪除</button>
          </div>
        </div>
      </div>
      <div class="total-price" v-if="totalPrice > 0">
        <p><strong>總金額:</strong> ${{ totalPrice }}</p>
        <button class="checkout-btn" @click="goToCheckout">前往結帳</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import axiosapi from '@/plugins/axios.js';
import router from '@/router/router';

const cart = ref([]);
const userId = ref(sessionStorage.getItem('userId'));
const totalPrice = ref(0);

const currentStep = ref(1);

onMounted(() => {
  fetchCart();
});

function fetchCart() {
  axiosapi.get(`/api/carts/user/${userId.value}`)
    .then(response => {
      cart.value = response.data || [];
      // Initialize checked status based on the data from backend
      cart.value.forEach(item => {
        item.checked = item.status === 0; // Assuming status 0 means checked
      });
      calculateTotal();
    })
    .catch(error => {
      console.error('Error fetching cart:', error);
    });
}


//const filteredCart = computed(() => {

  
 // return cart.value.filter(item => item.status != 1);
//});
const filteredCart = computed(() => {
      return cart.value.map(item => {
        return {
          ...item,
          checked: item.status === 0 // Set checked to true if status is 0
        };
      }).filter(item => item.status != 1); // Filter out items where status is 1
    });

function calculateTotal() {
  totalPrice.value = filteredCart.value.reduce((total, item) => {
    if (item.checked) {
      return total + (item.product.discount_price || 0) * item.quantity;
    }
    return total;
  }, 0).toFixed(2);
}

function checkbox(cartId) {
  // Find the item in the carts array
  const item = cart.value.find(item => item.id === cartId);

  if (item) {
    // Toggle the checked status
    const newCheckedStatus = !item.checked;
    item.checked = newCheckedStatus;

    // Prepare data for the backend based on the new status
    const endpoint = newCheckedStatus ? '/api/carts/status2' : '/api/carts/status';
    const data = newCheckedStatus ? [item.id] : [item.id];

    // Update the backend with the new status
    axiosapi.put(endpoint, data)
      .then(response => {
        console.log(newCheckedStatus ? 'Checked status updated successfully' : 'Unchecked status updated successfully');
        // Optionally, re-fetch cart data to ensure UI and backend are in sync
        fetchCart();
      })
      .catch(error => {
        console.error(`Error updating ${newCheckedStatus ? 'checked' : 'unchecked'} status:`, error);
      });
  }
}


function goToCheckout() {
  router.push({ name: 'pages-check-link' });
}

function updateQuantity(item, quantity) {
  console.log("item", item);
  console.log("quantity", quantity);

  if (quantity < 1) return;

  // Calculate subtotal
  const subtotal = (item.product.discount_price || 0) * quantity;

  // Send the updated quantity and subtotal to the server
  axiosapi.put(`/api/carts/quantity/${item.id}`, { quantity, subtotal })
    .then(() => {
      // Update the cart item locally
      const index = cart.value.findIndex(cartItem => cartItem.id === item.id);
      if (index !== -1) {
        cart.value[index].quantity = quantity;
        cart.value[index].subtotal = subtotal; // Update local subtotal
      }
      // Recalculate total price
      calculateTotal();
    })
    .catch(error => {
      console.error('Error updating quantity:', error);
    });
}

function removeItem(cartId) {
  axiosapi.delete(`/api/carts/${cartId}`)
    .then(() => {
      cart.value = cart.value.filter(item => item.id !== cartId);
      calculateTotal();
    })
    .catch(error => {
      console.error('Error removing item:', error);
    });
}
</script>

<style scoped>
.cart-container {
  padding: 20px;
  background-color: #f5f5f5;
  border-radius: 10px;
  max-width: 95%;
  margin: 0 auto;
}

h2 {
  text-align: center;
  color: #6f4f28; /* 深咖啡色 */
}

.empty-cart {
  text-align: center;
  color: #8a6d3b; /* 淺咖啡色 */
}

.cart-item {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  padding: 15px;
  background-color: #fff;
  border: 1px solid #d1b99f; /* 淺咖啡色邊框 */
  border-radius: 5px;
  transition: transform 0.3s ease;
}

.cart-item:hover {
  transform: translateY(-3px);
}

.item-details {
  display: flex;
  width: 100%;
}

.item-image img {
  max-width: 200px;
  margin-right: 20px;
  border-radius: 5px;
}

.item-info {
  flex-grow: 1;
  color: #4f3a2d; /* 中咖啡色文字 */
}

.item-actions {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.quantity-btn {
  padding: 5px 10px;
  background-color: #d1b99f; /* 淺咖啡色 */
  color: #3a2d1f; /* 深咖啡色文字 */
  border: none;
  border-radius: 3px;
  cursor: pointer;
  margin: 0 5px;
}

.quantity-btn:hover {
  background-color: #b0936d; /* 更深的咖啡色 */
}

.remove-btn {
  padding: 5px 10px;
  background-color: #d3816b; /* 暗紅咖啡色 */
  color: white;
  border: none;
  border-radius: 3px;
  cursor: pointer;
  margin-top: 10px;
}

.remove-btn:hover {
  background-color: #8c3a2b; /* 更深的暗紅咖啡色 */
}

.total-price {
  text-align: right;
  margin-top: 20px;
  color: #4f3a2d; /* 中咖啡色文字 */
}

.checkout-btn {
  padding: 10px 20px;
  background-color: #8a6d3b; /* 咖啡色 */
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 10px;
}

.checkout-btn:hover {
  background-color: #6f4f28; /* 深咖啡色 */
}

.shopping_steps {
  text-align: center;
  margin-bottom: 20px;
}

.steps {
  display: flex;
  justify-content: center;
  list-style: none;
  padding: 0;
  counter-reset: step;
}

.steps li {
  position: relative;
  flex: 1;
  text-align: center;
  font-size: 14px;
  color: #ccc;
}

.steps li:before {
  content: counter(step);
  counter-increment: step;
  width: 30px;
  height: 30px;
  line-height: 30px;
  border: 1px solid #ccc;
  display: block;
  text-align: center;
  margin: 0 auto 10px auto;
  border-radius: 50%;
  background-color: #fff;
}

.steps li.active {
  color: #6f4f28; /* 深咖啡色 */
}

.steps li.active:before {
  border-color: #6f4f28;
  background-color: #6f4f28;
  color: #fff;
}

.steps li:after {
  content: '';
  position: absolute;
  width: 100%;
  height: 0px;
  background-color: #ccc;
  top: 15px;
  left: 50%;
  z-index: -1;
}

.steps li:first-child:after {
  content: none;
}

.steps li.active + li:after {
  background-color: #6f4f28;
}

.empty-checkout {
  text-align: center;
  color: #8a6d3b; /* 淺咖啡色 */
}

.search-orders-button {
  display: block;
  width: 100%;
  padding: 10px 20px;
  margin-bottom: 20px;
  background-color: #8a6d3b;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
}

.search-orders-button:hover {
  background-color: #6f4f28;
}
</style>
