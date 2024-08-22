<template>
  <div class="checkout-container">
    <h2>STEP 2. 付款與運送方式</h2>
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

    <div v-if="selectedItems.length === 0" class="empty-checkout">
      <p>未選擇商品。</p>
    </div>
    <div v-else>
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
              <button class="quantity-btn" @click="updateQuantity(item, item.quantity - 1)">-</button>
              {{ item.quantity }}
              <button class="quantity-btn" @click="updateQuantity(item, item.quantity + 1)">+</button>
            </p>
            <p><strong>小計:</strong> ${{ (item.product.discount_price * item.quantity).toFixed(2) }}</p>
          </div>
          <div class="item-actions">
            <button class="remove-btn" @click="removeItem(item.id)">刪除</button>
          </div>
        </div>
      </div>

      <div class="shipping-method">
        <label for="shipping">選擇配送方式:</label>
        <select id="shipping" v-model="shippingMethod" required>
          <option value="宅配">宅配</option>
          <option value="超商取貨">超商取貨</option>
        </select>
      </div>
      
      <div v-if="shippingMethod === '宅配'" class="address-input">
<div class="address-row">
  <div class="address-field">
    <label for="city">選擇縣市:</label>
    <select id="city" v-model="selectedCity" class="custom-select">
      <option v-for="city in cities" :key="city" :value="city">{{ city }}</option>
    </select>
  </div>
  <div class="address-field">
    <label for="district">選擇區域:</label>
    <select id="district" v-model="selectedDistrict" class="custom-select" required>
      <option v-for="district in districts[selectedCity] || []" :key="district" :value="district">{{ district }}</option>
    </select>
  </div>
  <div class="address-field">
    <label for="address">請輸入詳細地址:</label>
    <input id="address" type="text" v-model="address" placeholder="輸入地址" required>
  </div>
</div>
</div>
      <div v-if="shippingMethod === '超商取貨'" class="store-selection">
        <label for="store">選擇取貨門市:</label>
        <select id="store" v-model="selectedStore" required>
          <option v-for="store in stores" :key="store.id" :value="store.id">
            {{ store.name }} - {{ store.location }}
          </option>
        </select>
      </div>
      
      <div class="payment-method">
        <label for="payment">選擇支付方式:</label>
        <select id="payment" v-model="paymentMethod" required>
          <option value="貨到付款">貨到付款</option>
          <option value="綠界">綠界</option>
          <option value="linepay">linepay</option>
        </select>
      </div>
      
      <div class="coupon-selection">
        <label for="coupon">選擇折價券:</label>
        <select id="coupon" v-model="selectedCoupon" required>
          <option value="">不使用折價券</option>
          <option v-for="coupon in filteredCoupons" :key="coupon.id" :value="coupon">
            {{ coupon.coupon.name }} - ${{ coupon.coupon.discount }}
          </option>
        </select>
      </div>
      
      <div class="summary">
        <p><strong>商品金額:</strong> ${{ itemsTotal }}</p>
        <p><strong>運費:</strong> ${{ shippingCost }}</p>
        <p><strong>折扣:</strong> -${{ selectedCoupon ? selectedCoupon.coupon.discount : 0 }}</p>
        <p><strong>總金額:</strong> ${{ totalAmount }}</p>
        <button class="back-btn" @click="goBackToCart">重新選擇</button>
        <button class="checkout-btn" @click="checkout">下一步</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axiosapi from '@/plugins/axios.js';

const router = useRouter();
const route = useRoute();
//const selectedItems = ref([]);
const shippingMethod = ref('宅配');
const paymentMethod = ref('貨到付款');
const selectedCoupon = ref(null);
const coupons = ref([]);
const carts = ref([]);


const address = ref('');
const selectedCity = ref('');
const selectedDistrict = ref('');
const selectedStore = ref('');
const cities = ["台北市","新北市","基隆市","桃園市","台中市","台南市","高雄市","新竹市","嘉義市", "新竹縣",
  "苗栗縣","彰化縣","南投縣","雲林縣","嘉義縣","屏東縣","宜蘭縣","花蓮縣","台東縣","澎湖縣",
  "金門縣","連江縣"]; // 縣市資料
const districts = {
  "台北市": ["中正區", "大同區", "中山區", "松山區", "大安區", "萬華區", "信義區", "士林區", "北投區", "內湖區", "南港區", "文山區"],
  "新北市": ["三峽區", "板橋區", "新店區", "汐止區", "萬里區", "金山區", "深坑區", "石碇區", "瑞芳區", "平溪區", "雙溪區", "貢寮區", "坪林區", "烏來區", "永和區", "中和區", "土城區", "樹林區", "鶯歌區", "三重區", "新莊區", "泰山區", "林口區", "蘆洲區", "五股區", "八里區", "淡水區", "三芝區", "石門區"],
  "桃園市": ["桃園區", "中壢區", "八德區", "蘆竹區", "大溪區", "楊梅區", "大園區", "龜山區", "龍潭區", "平鎮區", "新屋區", "觀音區", "復興區"],
  "台中市": ["中區", "東區", "南區", "西區", "北區", "北屯區", "西屯區", "南屯區", "太平區", "大里區", "霧峰區", "烏日區", "豐原區", "后里區", "石岡區", "東勢區", "和平區", "新社區", "潭子區", "大雅區", "神岡區", "大肚區", "沙鹿區", "龍井區", "梧棲區", "清水區", "大甲區", "外埔區", "大安區"],
  "台南市": ["中西區", "東區", "南區", "北區", "安平區", "安南區", "永康區", "歸仁區", "新化區", "左鎮區", "玉井區", "楠西區", "南化區", "仁德區", "關廟區", "龍崎區", "官田區", "麻豆區", "佳里區", "西港區", "七股區", "將軍區", "學甲區", "北門區", "新營區", "後壁區", "白河區", "東山區", "六甲區", "下營區", "柳營區", "鹽水區", "善化區", "大內區", "山上區", "新市區", "安定區"],
  "高雄市": ["新興區", "前金區", "苓雅區", "鹽埕區", "鼓山區", "旗津區", "前鎮區", "三民區", "楠梓區", "小港區", "左營區", "仁武區", "大社區", "岡山區", "路竹區", "阿蓮區", "田寮區", "燕巢區", "橋頭區", "梓官區", "彌陀區", "永安區", "湖內區", "鳳山區", "大寮區", "林園區", "鳥松區", "大樹區", "旗山區", "美濃區", "六龜區", "內門區", "杉林區", "甲仙區", "桃源區", "那瑪夏區", "茂林區", "茄萣區"],
  "基隆市": ["仁愛區", "信義區", "中正區", "中山區", "安樂區", "暖暖區", "七堵區"],
  "新竹市": ["東區", "北區", "香山區"],
  "嘉義市": ["東區", "西區"],
  "新竹縣": ["竹北市", "竹東鎮", "新埔鎮", "關西鎮", "湖口鄉", "新豐鄉", "芎林鄉", "橫山鄉", "北埔鄉", "寶山鄉", "峨眉鄉", "尖石鄉", "五峰鄉"],
  "苗栗縣": ["苗栗市", "竹南鎮", "頭份市", "後龍鎮", "通霄鎮", "苑裡鎮", "卓蘭鎮", "造橋鄉", "西湖鄉", "頭屋鄉", "公館鄉", "銅鑼鄉", "三義鄉", "大湖鄉", "獅潭鄉", "三灣鄉", "南庄鄉", "泰安鄉"],
  "彰化縣": ["彰化市", "員林市", "和美鎮", "鹿港鎮", "溪湖鎮", "二林鎮", "田中鎮", "北斗鎮", "花壇鄉", "芬園鄉", "大村鄉", "永靖鄉", "伸港鄉", "線西鄉", "福興鄉", "秀水鄉", "埔心鄉", "埔鹽鄉", "大城鄉", "芳苑鄉", "竹塘鄉", "社頭鄉", "二水鄉", "田尾鄉", "埤頭鄉", "溪州鄉"],
  "南投縣": ["南投市", "埔里鎮", "草屯鎮", "竹山鎮", "集集鎮", "名間鄉", "鹿谷鄉", "中寮鄉", "魚池鄉", "國姓鄉", "水里鄉", "信義鄉", "仁愛鄉"],
  "雲林縣": ["斗六市", "斗南鎮", "虎尾鎮", "西螺鎮", "土庫鎮", "北港鎮", "古坑鄉", "大埤鄉", "莿桐鄉", "林內鄉", "二崙鄉", "崙背鄉", "麥寮鄉", "東勢鄉", "褒忠鄉", "臺西鄉", "元長鄉", "四湖鄉", "口湖鄉", "水林鄉"],
  "嘉義縣": ["太保市", "朴子市", "布袋鎮", "大林鎮", "民雄鄉", "溪口鄉", "新港鄉", "六腳鄉", "東石鄉", "義竹鄉", "鹿草鄉", "水上鄉", "中埔鄉", "竹崎鄉", "梅山鄉", "番路鄉", "大埔鄉", "阿里山鄉"],
  "屏東縣": ["屏東市", "潮州鎮", "東港鎮", "恆春鎮", "萬丹鄉", "長治鄉", "麟洛鄉", "九如鄉", "里港鄉", "鹽埔鄉", "高樹鄉", "萬巒鄉", "內埔鄉", "竹田鄉", "新埤鄉", "枋寮鄉", "新園鄉", "崁頂鄉", "林邊鄉", "南州鄉", "佳冬鄉", "琉球鄉", "車城鄉", "滿州鄉", "枋山鄉", "霧臺鄉", "瑪家鄉", "泰武鄉", "來義鄉", "春日鄉", "獅子鄉", "牡丹鄉", "三地門鄉"],
  "宜蘭縣": ["宜蘭市", "羅東鎮", "蘇澳鎮", "頭城鎮", "礁溪鄉", "壯圍鄉", "員山鄉", "冬山鄉", "五結鄉", "三星鄉", "大同鄉", "南澳鄉"],
  "花蓮縣": ["花蓮市", "鳳林鎮", "玉里鎮", "新城鄉", "吉安鄉", "壽豐鄉", "光復鄉", "豐濱鄉", "瑞穗鄉", "富里鄉", "秀林鄉", "萬榮鄉", "卓溪鄉"],
  "台東縣": ["台東市", "成功鎮", "關山鎮", "卑南鄉", "鹿野鄉", "池上鄉", "東河鄉", "長濱鄉", "太麻里鄉", "大武鄉", "綠島鄉", "海端鄉", "延平鄉", "金峰鄉", "達仁鄉", "蘭嶼鄉"],
  "澎湖縣": ["馬公市", "湖西鄉", "白沙鄉", "西嶼鄉", "望安鄉", "七美鄉"],
  "金門縣": ["金城鎮", "金湖鎮", "金沙鎮", "金寧鄉", "烈嶼鄉", "烏坵鄉"],
  "連江縣": ["南竿鄉", "北竿鄉", "莒光鄉", "東引鄉"]
}; // 各縣市區域資料
const stores = ref([
  { id: 1, name: '7-11 台北忠孝店', location: '台北市中正區忠孝路1號' },
  { id: 2, name: '7-11 台北車站店', location: '台北市中正區台北車站1樓' },
  { id: 3, name: '7-11 高雄六合店', location: '高雄市六合路2號' },
  // 可以添加更多門市
]);

const currentStep = ref(2);

if (route.query.items) {
  try {
    selectedItems.value = JSON.parse(route.query.items);
  } catch (error) {
    console.error('Error parsing selected items:', error);
  }
}

onMounted(() => {
  const userId = sessionStorage.getItem('userId');
  axiosapi.get(`/api/orders/coupons/${userId}`)
    .then(response => {
      coupons.value = response.data.coupons;
    })
    .catch(error => {
      console.error('Error fetching coupons:', error);
    });

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

const selectedItems = computed(() => {
  return carts.value.filter(cart => cart.status === 0 || cart.status === undefined);
});


const filteredCoupons = computed(() => {
  return coupons.value.filter(coupon => coupon.status === 1 || coupon.status === undefined);
});

const itemsTotal = computed(() => {
  return selectedItems.value.reduce((total, item) => total + item.product.discount_price * item.quantity, 0).toFixed(2);
});

const shippingCost = computed(() => (shippingMethod.value === '宅配' ? 100 : 60));

const discount = computed(() => {
  if (selectedCoupon.value) {
    console.log("selectedCoupon.value.coupon.id", selectedCoupon.value.coupon.id);
    const coupon = coupons.value.find(c => c.coupon.id === selectedCoupon.value.coupon.id);

    return coupon ? coupon.coupon.discount : 0;
  }
  return 0;
});

const totalAmount = computed(() => {
  return (parseFloat(itemsTotal.value) + shippingCost.value - discount.value).toFixed(2);
});

function updateQuantity(item, quantity) {
if (quantity < 1) return;
axiosapi.put(`/api/carts/quantity/${item.id}`, { quantity })
  .then(() => {
    item.quantity = quantity;
   // calculateTotal();
  })
  .catch(error => {
    console.error('Error updating quantity:', error);
  });
}

function removeItem(cartId) {
axiosapi.delete(`/api/carts/${cartId}`)
  .then(() => {
    carts.value = carts.value.filter(item => item.id !== cartId);
   // calculateTotal();
  })
  .catch(error => {
    console.error('Error removing item:', error);
  });
}

const getImageSrc = (imgPath) => {
  return `/images/${imgPath}`;
};

const goBackToCart = () => {
  router.push({ path: '/carts/Cart' });
};


const checkout = () => {
  const userId = sessionStorage.getItem('userId');
  const orderData = {
    userId: userId,
    shippingMethod: shippingMethod.value,
    selectedCity: selectedCity.value,
    selectedDistrict: selectedDistrict.value,
    address: address.value,
    selectedStore: selectedStore.value,
    paymentMethod: paymentMethod.value,
    selectedCoupon: selectedCoupon.value,
    selectedItems: selectedItems.value,
    totalAmount: totalAmount.value
  };
  console.log("orderData",orderData);
  sessionStorage.setItem("orderData", JSON.stringify(orderData));
  router.push({
    path: '/carts/OrderDetail',
    //query: { orderData: JSON.stringify(orderData) }
  });
};

</script>

<style scoped>
.checkout-container {
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

.empty-checkout {
text-align: center;
color: #8a6d3b; /* 淺咖啡色 */
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
  background-color: #a84d35; /* 暗紅咖啡色 */
  color: white;
  border: none;
  border-radius: 3px;
  cursor: pointer;
  margin-top: 10px;
}

.remove-btn:hover {
  background-color: #8c3a2b; /* 更深的暗紅咖啡色 */
}

.shipping-method, .payment-method, .coupon-selection {
  margin: 15px 0;
}

label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  color: #6f4f28; /* 深咖啡色 */
}

select {
  padding: 5px;
  border: 1px solid #d1b99f; /* 淺咖啡色邊框 */
  border-radius: 5px;
}

.summary {
  text-align: right;
  margin-top: 20px;
  color: #4f3a2d; /* 中咖啡色文字 */
}

.back-btn, .checkout-btn {
  padding: 10px 20px;
  background-color: #6f4f28; /* 深咖啡色 */
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 10px;
}

.back-btn:hover, .checkout-btn:hover {
  background-color: #4f3a2d; /* 更深的咖啡色 */
}

.shipping-method,
.payment-method,
.coupon-selection {
  margin: 20px 0;
}

.address-input {
  margin: 20px 0;
}

.address-row {
  display: inline-flex;
  flex-wrap: wrap;
}

.address-field {
  flex: 1;
  margin-right: 10px;
}

.address-field label {
  display: block;
}

.custom-select {
height: auto;
max-height: 150px; /* 5行選項高度 */
overflow-y: auto; /* 垂直滾動條 */
}
</style>
