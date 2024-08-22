<template>
  <div class="order-detail-container">
    <h2>確認訂單資料</h2>
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


    <div class="total-price">
<p><strong>本次消費總計:</strong> <span class="red-text">${{ orderData.totalAmount }}</span></p>
</div>

    <div v-for="item in selectedItems" :key="item.id" class="checkout-item">
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
            {{ item.quantity }}
          </p>
          <p><strong>小計:</strong> ${{ (item.product.discount_price * item.quantity).toFixed(2) }}</p>
        </div>
      </div>
    </div>

      <!-- 收貨人資訊 -->

  <div v-if="orderData" class="recipient-info">
    <h3>收貨人資訊</h3>
    <label>收貨人姓名:</label>
    <input id="recipientName" type="text" v-model="recipientName" placeholder="請輸入姓名">
    <br>
    <label>聯絡電話:</label>
    <input id="recipientPhone" type="text" v-model="recipientPhone" placeholder="請輸入聯絡電話">
    <p></p>
    <h3>收貨人資訊</h3>
    <p><label><strong>配送方式:</strong></label> {{ orderData.shippingMethod }}</p>
  <p v-if="orderData.shippingMethod === '宅配'"><label><strong>地址:</strong></label> {{ orderData.selectedCity }} {{ orderData.selectedDistrict }} {{ orderData.address }}</p>
  <p v-else><label><strong>取貨門市:</strong></label> {{ getStoreName(orderData.selectedStore) }}</p>

    <p><label><strong>支付方式:</strong></label> {{ orderData.paymentMethod }}</p>

    <h3>使用折價券</h3>
    <p><label><strong>折價券:</strong></label>{{ orderData.selectedCoupon?.coupon?.name  || '無使用折價券' }}
</p>
  </div>
</div>
  <!-- 隱藏的表單 -->
  <form ref="paymentForm" :action="'https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut/V5'" method="POST" style="display:none;">
      <input type="hidden" name="MerchantID" :value="payment.merchantID" />
      <input type="hidden" name="MerchantTradeNo" :value="merchantTradeNo" />
      <input type="hidden" name="MerchantTradeDate" :value="merchantTradeDate" />
      <input type="hidden" name="PaymentType" value="aio" />
      <input type="hidden" name="EncryptType" value="1" />
      <input type="hidden" name="TotalAmount" :value="parseFloat(orderData.totalAmount)" />
      <input type="hidden" name="TradeDesc" :value="payment.tradeDesc" />
      <input type="hidden" name="ItemName" :value="payment.itemName" />
      <input type="hidden" name="ReturnURL" :value="payment.returnURL" />
      <input type="hidden" name="ClientBackURL" :value="payment.clientBackURL" />
      <input type="hidden" name="ChoosePayment" :value="payment.choosePayment" />
      <input type="hidden" name="IgnorePayment" :value="payment.ignorePayment" />
      <input type="hidden" name="CheckMacValue" :value="checkMacValue" />
    </form>
<div class="action-buttons">
  <button class="back-btn" @click="goBackToCheckout">返回上一頁</button>
  <button class="submit-btn" @click="submitOrder">結帳</button>
</div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axiosapi from '@/plugins/axios.js';
import CryptoJS from "crypto-js";

const route = useRoute();
const router = useRouter();

const currentStep = ref(3);
const recipientName = ref('');
const shippingMethod = ref('');
const selectedCity = ref('');
const selectedDistrict = ref('');
const address = ref('');
const selectedStore = ref('');
const paymentMethod = ref('');
const totalPrice = ref(0);
const recipientPhone = ref('');
const carts = ref([]);
const orderData = ref('');
const paymentForm = ref(null)
const payment =  ref({
  merchantID: "3002607",
  hashKey: "pwFHCqoQZGmho4w6",
  hashIV: "EkRm7iFT261dpevs",
  isStage: true,
  totalAmount:  parseFloat(orderData.value.totalAmount), // 代入目前購物車金額
  tradeDesc: "測試敘述",
  itemName: "測試名稱",
  returnURL: "https://www.ecpay.com.tw", // 導向測試網址
  clientBackURL: "http://192.168.23.195:6173/carts/Complete",
  choosePayment: "ALL",
  ignorePayment: "WebATM#CVS#TWQR#BNPL#ATM" // 設定不開放的支付方式
});
const stores = ref([
{ id: 1, name: '7-11 台北忠孝店', location: '台北市中正區忠孝路1號' },
{ id: 2, name: '7-11 台北車站店', location: '台北市中正區台北車站1樓' },
{ id: 3, name: '7-11 高雄六合店', location: '高雄市六合路2號' },
]);

onMounted(() => {
const storedOrderData = sessionStorage.getItem("orderData");
if (storedOrderData) {
  try {
    
    orderData.value = JSON.parse(storedOrderData) || orderData.value;
  } catch (error) {
    console.error('Error parsing order data:', error);
  }
}
const userId = sessionStorage.getItem('userId');
axiosapi.get(`/api/carts/user/${userId}`)
.then(response => {
  console.log('Response data:', response.data);
  if (response.data ) {
    carts.value = response.data.filter(cart => cart.status === 0);
  } else {
    console.error('Error: carts data is undefined or not in expected format');
  }
})
.catch(error => {
  console.error('Error fetching carts:', error);
});
});

const getImageSrc = (imgPath) => {
return `/images/${imgPath}`;
};

const selectedItems = computed(() => {
return carts.value.filter(cart => cart.status === 0 || cart.status === undefined);
});
const merchantTradeNo = computed(() => {
  const date = new Date();
  return `od${date.getFullYear()}${(date.getMonth() + 1)
    .toString()
    .padStart(2, "0")}${date
    .getDate()
    .toString()
    .padStart(2, "0")}${date
    .getHours()
    .toString()
    .padStart(2, "0")}${date
    .getMinutes()
    .toString()
    .padStart(2, "0")}${date
    .getSeconds()
    .toString()
    .padStart(2, "0")}${date
    .getMilliseconds()
    .toString()
    .padStart(3, "0")}`;
});
const merchantTradeDate = computed(() => {
  return new Date().toLocaleDateString("zh-TW", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    second: "2-digit",
    hour12: false,
  });
});
const checkMacValue = computed(() => {
  return generateCheckMacValue();
});
const generateCheckMacValue = () => {
  const params = {
    MerchantID: payment.value.merchantID,
    MerchantTradeNo: merchantTradeNo.value,
    MerchantTradeDate: merchantTradeDate.value,
    PaymentType: "aio",
    EncryptType: 1,
    TotalAmount:  parseFloat(orderData.value.totalAmount),
    TradeDesc: payment.value.tradeDesc,
    ItemName: payment.value.itemName,
    ReturnURL: payment.value.returnURL,
    ClientBackURL:  payment.value.clientBackURL,
    ChoosePayment: payment.value.choosePayment,
    IgnorePayment: payment.value.ignorePayment,
  };
  const step0 = Object.entries(params)
    .map(([key, value]) => `${key}=${value}`)
    .join("&");

  const step1 = step0
    .split("&")
    .sort((a, b) => a.split("=")[0].localeCompare(b.split("=")[0]))
    .join("&");

  const step2 = `HashKey=${payment.value.hashKey}&${step1}&HashIV=${payment.value.hashIV}`;
  const step3 = dotNetUrlEncode(encodeURIComponent(step2));
  const step4 = step3.toLowerCase();
  const step5 = CryptoJS.SHA256(step4).toString().toUpperCase(); // 使用 crypto-js 进行 SHA256 加密

  return step5;
};

const dotNetUrlEncode = (string) => {
      const replacements = {
        "%2D": "-",
        "%5F": "_",
        "%2E": ".",
        "%21": "!",
        "%2A": "*",
        "%28": "(",
        "%29": ")",
        "%20": "+",
      };

      return Object.entries(replacements).reduce(
        (acc, [encoded, decoded]) => acc.replace(new RegExp(encoded, "g"), decoded),
        string
      );
}
const submitPayment = () => {
  const params = {
    MerchantID: payment.value.merchantID,
    MerchantTradeNo: merchantTradeNo.value,
    MerchantTradeDate: merchantTradeDate.value,
    PaymentType: "aio",
    EncryptType: 1,
    TotalAmount:  parseFloat(orderData.value.totalAmount),
    TradeDesc: payment.value.tradeDesc,
    ItemName: payment.value.itemName,
    ReturnURL: payment.value.returnURL,
    ClientBackURL: payment.value.clientBackURL,
    ChoosePayment: payment.value.choosePayment,
    IgnorePayment: payment.value.ignorePayment,
    CheckMacValue: checkMacValue.value,
  };
  
  console.log("Submitting Payment with params:", params);

  axiosapi.post("/submitPayment", params, {
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }
  })
    .then(response => {
      if (response.data) {
        window.location.href = response.data; // 重定向到 URL
      } else {
        console.error("Redirect URL is not available in response.");
      }
    })
    .catch(error => {
      console.error("Error submitting payment:", error);
    });
};

const filteredItems = computed(() => {
return carts.value.filter(cart => cart.status === 0 || cart.status === undefined);
});

const getStoreName = (storeId) => {
const store = stores.value.find(store => store.id === storeId);
return store ? store.name : '';
};

const goBackToCheckout = () => {
  router.push({ path: '/carts/Check' });
};


const submitOrder = () => {
// 組合完整的地址
const fullAddress = [
  orderData.value.selectedCity,
  orderData.value.selectedDistrict,
  orderData.value.address
].filter(part => part).join(''); // 過濾掉空值，並用空格分隔各部分

const fullStoreAddress = [
  getStoreName(orderData.value.selectedStore),
  //orderData.value.selectedStore
].filter(part => part).join(''); // 過濾掉空值，並用空格分隔各部分

// 使用三元運算符選擇地址
const address = fullAddress ? fullAddress : fullStoreAddress;
const coupon = orderData.value.selectedCoupon?.owner?.owner_Id || null;
const orderPayload = {
  order: {
    userId: sessionStorage.getItem('userId'),
    recipientName: recipientName.value,
    recipientPhone: recipientPhone.value,
    shippingMethod: orderData.value.shippingMethod,
    address: address,
    //selectedStore: orderData.value.selectedStore,
    paymentMethod: orderData.value.paymentMethod,
    totalAmount: orderData.value.totalAmount,
    // coupon: orderData.value.selectedCoupon || null 
    coupon: coupon || null 
  },
  orderDetails: filteredItems.value.map(item => ({
    productId: item.product.id,
    quantity: item.quantity,
    cartId: item.id
  }))
};
// 打印 orderPayload 以供檢查
console.log('Order Payload:', JSON.stringify(orderPayload, null, 2));

// 提交訂單
axiosapi.post('/api/orders/create', orderPayload)
  .then(response => {
    console.log('Order Submitted Response:', response);
    console.log('Order Submitted Data:', response.data);
    
    if (response.data) {
      // 更新購物車狀態
      const cartIds = orderPayload.orderDetails.map(item => item.cartId);
      axiosapi.put('/api/carts/status3', cartIds)
        .then(() => {
          // 更新優惠券狀態（如果有選擇優惠券）
          const selectedCoupon = orderPayload.order.coupon;
          if (selectedCoupon) {
            // const couponOwnerId = selectedCoupon.owner.owner_Id;
            const couponOwnerId = selectedCoupon.owner_Id;
            axiosapi.put('/api/couponowner/status', [couponOwnerId])
              .then(() => {
                // 在這裡處理狀態更新成功後的邏輯，例如頁面跳轉
                if (orderPayload.order.paymentMethod === '貨到付款') {

                  router.push({ path: '/carts/Complete' }).then(() =>{
                  window.location.reload();}
                )}
              })
              .catch(error => {
                console.error('Error updating coupon status:', error);
              });
          } else {
            // 如果沒有選擇優惠券，直接處理成功邏輯
            if (orderPayload.order.paymentMethod === '貨到付款') {
              router.push({ path: '/carts/Complete' });
            }
          }
        })
        .catch(error => {
          console.error('Error updating cart status:', error);
        });
    } else {
      console.error('Error: Response data is null');
    }
  })
  .catch(error => {
    console.error('Error submitting order:', error);
  });

// 綠界支付處理
if (orderPayload.order.paymentMethod === '綠界') {
  paymentForm.value.submit();
};
}
</script>

<style scoped>
.order-detail-container {
  padding: 20px;
  background-color: #f5f5f5;
  border-radius: 10px;
  width: 95%;
  margin: 0 auto;
}

h2 {
  text-align: center;
  color: #6f4f28; /* 深咖啡色 */
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
  border: 1px dotted #ccc;
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
  background-color: #f89810;
  top: 15px;
  left: 20%;
  z-index: -1;
}

.steps li:first-child:after {
  content: none;
}

.steps li.active + li:after {
  background-color: #6f4f28;
}

.summary {
  margin-bottom: 20px;
}

.contact-info {
  margin-bottom: 20px;
}

.contact-info label {
  display: block;
  margin-top: 10px;
}

.contact-info input {
  width: 100%;
  padding: 10px;
  margin-top: 5px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.action-buttons {
  text-align: center;
}

.back-btn, .submit-btn {
  padding: 10px 20px;
  background-color: #6f4f28; /* 深咖啡色 */
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin: 5px;
}

.back-btn:hover, .submit-btn:hover {
  background-color: #4f3a2d; /* 更深的咖啡色 */
}

label {
display: block;
margin-bottom: 5px;
font-weight: bold;
color: #6f4f28; /* 深咖啡色 */
}

.checkout-item {
display: flex;
align-items: center;
margin-bottom: 20px;
padding: 15px;
background-color: #fff;
border: 1px solid #d1b99f; /* 淺咖啡色邊框 */
border-radius: 5px;
transition: transform 0.3s ease;
}

.checkout-item:hover {
transform: translateY(-3px);
}

.total-price{
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

.item-image img {
max-width: 100px;
margin-right: 20px;
border-radius: 5px;
width: 200px;
}

.item-details {
display: flex;
width: 100%;
}
</style>
