<template>
  <div class="checkout-container">
    <h2>STEP 4. 完成訂購</h2>
    <h3>感謝你的訂購！</h3>
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
  </div>
</template>

<script setup>  
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const currentStep = ref(4);
const router = useRouter();

onMounted(() => {
  //setTimeout(() => {
    //router.push('/pages/SearchOrders');
  //}, 3000); // 3000 毫秒（即 3 秒）後跳轉
});
</script>

<style scoped>
.checkout-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px;
  background: linear-gradient(135deg, #f0e4d7, #f5f5f5);
  border-radius: 15px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  width: 90%;
  margin: 50px auto;
  max-width: 600px;
}

h2 {
  text-align: center;
  color: #6f4f28; /* 深咖啡色 */
  font-family: 'Arial', sans-serif;
  font-size: 24px;
  margin-bottom: 20px;
}

h3{
  font-size: 16px;
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
  color: #ccc; /* 淺咖啡色 */
}
</style>
