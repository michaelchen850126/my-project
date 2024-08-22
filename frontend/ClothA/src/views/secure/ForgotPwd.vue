<template>
<div class="divimg">
  <div class="forgot-password-container">
    <!-- 步驟條 -->
    <el-steps style="width: 500px; max-width: 1000px" :active="step - 1" finish-status="success">
      <el-step title="步驟 1" />
      <el-step title="步驟 2" />
      <el-step title="步驟 3" />
    </el-steps>

    <!-- 步驟內容 -->
    <div class="card">
      <div class="header">
        <!-- 返回登入畫面按鈕 -->
        <button v-if="step === 1" type="button" class="btn btn-back" @click="goToLogin">
          <font-awesome-icon icon="fa-solid fa-arrow-left" size="2xl" />
        </button>
        <!-- 返回上一個步驟按鈕 -->
        <button v-if="step > 1" type="button" class="btn btn-back" @click="goBack">
          <font-awesome-icon icon="fa-solid fa-arrow-left" size="2xl" />
        </button>
        <h3>忘記密碼 - 第{{ step }}步</h3>
      </div>

      <!-- 步驟 1: 發送驗證碼 -->
      <form @submit.prevent="sendVerificationCode" v-show="step === 1">
        <div class="form-group">
          <label>信箱:</label>
          <input type="email" v-model="registrationData.email" required class="form-control" placeholder="請輸入電子郵件" />
        </div>
        <button type="submit" class="btn btn-primary">發送驗證碼</button>
      </form>

      <!-- 步驟 2: 驗證驗證碼 -->
      <form @submit.prevent="verifyCode" v-show="step === 2">
        <div class="form-group">
          <label>驗證碼:</label>
          <input type="text" v-model="registrationData.inputVerificationCode" required class="form-control" placeholder="請輸入驗證碼" />
        </div>
        <button type="submit" class="btn btn-success">驗證</button>
      </form>

      <!-- 步驟 3: 重新設定密碼 -->
      <form @submit.prevent="resetPassword" v-show="step === 3">
        <p>驗證成功！請輸入新密碼：</p>
        <div class="form-group password-group">
          <input :type="newPasswordVisible ? 'text' : 'password'" v-model="newPassword" placeholder="新密碼" required />
          <button type="button" @click="toggleNewPasswordVisibility" class="toggle-password">
            <i :class="newPasswordVisible ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'"></i>
          </button>
        </div>
        <div class="form-group password-group">
          <input :type="confirmPasswordVisible ? 'text' : 'password'" v-model="confirmPassword" placeholder="確認密碼" required />
          <button type="button" @click="toggleConfirmPasswordVisibility" class="toggle-password">
            <i :class="confirmPasswordVisible ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'"></i>
          </button>
        </div>
        <button type="submit" class="btn btn-primary">重設密碼</button>
      </form>

      <!-- 顯示錯誤信息 -->
      <div v-if="error" class="alert alert-danger">
        <p>{{ error }}</p>
      </div>
    </div>
  </div>
</div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axiosapi from '@/plugins/axios';
import Swal from 'sweetalert2';
import { useRouter, useRoute } from 'vue-router';    // 用於操作路由的組件，讓你可以在 Vue 組件中進行路由跳轉。
import { ElLoading, ElMessage } from 'element-plus'; // 確保你已經導入了 ElLoading 和 ElMessage

const router = useRouter();
const route = useRoute();   // 使用 useRoute 獲取當前路由對象
const step = ref(1);
const registrationData = ref({
  email: '',
  inputVerificationCode: ''
});
const newPassword = ref('');
const confirmPassword = ref('');
const error = ref('');
const newPasswordVisible = ref(false);
const confirmPasswordVisible = ref(false);

function toggleNewPasswordVisibility() {
  newPasswordVisible.value = !newPasswordVisible.value;
}

function toggleConfirmPasswordVisibility() {
  confirmPasswordVisible.value = !confirmPasswordVisible.value;
}

onMounted(async () => {
// 檢查是否有查詢參數並自動填入帳號
if (route.query && route.query.email) {  // 確保 route.query 存在且 email 不為 undefined
    registrationData.value.email = route.query.email;
}
});

function goToLogin() {
  router.push('/secure/login');
}

function goBack() {
  if (step.value === 1) {
    goToLogin();
  } else {
    step.value -= 1;
  }
}

async function sendVerificationCode() {
  // 顯示 Loading 指示器
  const loading = ElLoading.service({
    lock: true,
    text: '驗證中...',
    background: 'rgba(0, 0, 0, 0.7)',
  });

  try {
    const response = await axiosapi.post('/api/auth/forgotPwdStep1', {
      email: registrationData.value.email
    });

    if (response.data.success) {
      // 關閉 Loading 指示器
      loading.close();
      step.value = 2;
      error.value = '';
    } else {
      // 關閉 Loading 指示器
      loading.close();
      ElMessage.error(response.data.message || '無法發送驗證碼，請再試一次。');
    }
  } catch (err) {
    console.error('發送驗證碼失敗:', err);
    // 關閉 Loading 指示器
    loading.close();
    ElMessage.error('發送驗證碼失敗，請稍後再試。');
  }
}

async function verifyCode() {
  try {
    const response = await axiosapi.post('/api/auth/forgotPwdStep2', {
      inputVerificationCode: registrationData.value.inputVerificationCode
    });

    if (response.data.success) {
      step.value = 3;
      error.value = '';
    } else {
      error.value = response.data.message || '驗證碼錯誤，請再試一次。';
    }
  } catch (err) {
    console.error('驗證碼驗證失敗:', err);
    error.value = '驗證碼驗證失敗，請稍後再試。';
  }
}

async function resetPassword() {
  if (!newPassword.value || !confirmPassword.value) {
    Swal.fire({
      icon: 'warning',
      text: '請輸入新密碼及確認密碼',
    });
    return;
  }

  if (newPassword.value !== confirmPassword.value) {
    Swal.fire({
      icon: 'warning',
      text: '新密碼與確認密碼不匹配',
    });
    return;
  }

  try {
    const response = await axiosapi.post('/api/auth/forgotPwdStep3', {
      newPassword: newPassword.value,
      confirmPassword: confirmPassword.value
    });

    if (response.data.success) {
      Swal.fire({
        icon: 'success',
        text: response.data.message,
        showConfirmButton: false,
        timer: 1000,
      }).then(() => {
        router.push('/secure/login');
      });
    } else {
      Swal.fire({
        icon: 'error',
        text: response.data.message,
      });
    }
  } catch (err) {
    console.error('重設密碼失敗:', err);
    Swal.fire({
      icon: 'error',
      text: '重設密碼失敗，請稍後再試。',
    });
  }
}

</script>

<style scoped>
/* @keyframes gradientAnimation {
0% {
background: radial-gradient(135deg, rgba(230, 230, 230, 0.95), rgba(180, 180, 180, 0.95));
}
25% {
background: radial-gradient(135deg, rgba(180, 180, 180, 0.95), rgba(230, 230, 230, 0.95));
}
50% {
background: radial-gradient(135deg, rgba(230, 230, 230, 0.95), rgba(180, 180, 180, 0.95));
}
75% {
background: radial-gradient(135deg, rgba(180, 180, 180, 0.95), rgba(230, 230, 230, 0.95));
}
100% {
background: radial-gradient(135deg, rgba(230, 230, 230, 0.95), rgba(180, 180, 180, 0.95));
}
} */

.divimg {
  background-image: url('@/assets/images/usersBackground/Register.jpg'); /* 设置背景图像 */
  background-size: cover; /* 确保背景图像覆盖整个容器 */
  background-position: center; /* 将背景图像居中 */
  background-repeat: no-repeat; /* 防止背景图像重复 */
  position: relative; /* 使覆盖层相对于父容器定位 */
  height: 100%;

}

.divimg::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(128, 119, 119, 0.418); 
  z-index: 2; 
}

.divimg > * {
  position: relative; /* 使子元素相对于父容器定位，以确保它们在覆盖层之上 */
  z-index: 2;
}

.forgot-password-container {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  height: calc(89vh - 40px);
  padding: 0 20px;
  /* background: linear-gradient(135deg, #ffffff, #d2c8c8); */
}

.card {
  width: 100%;
  max-width: 500px;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  padding: 20px;
  margin: 20px 0;
  position: relative;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.btn-back {
  background: none;
  border: none;
  cursor: pointer;
}

.form-group {
  margin-bottom: 15px;
}

.notification {
  background: #d2c8c8;
  color: black;
  padding: 15px;
  border: 1px solid #28a745;
  border-radius: 4px;
  margin-bottom: 15px;
}

.btn {
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
}

.btn-primary {
  background-color: black;
  color: white;
}

.btn.btn-primary:hover {
  background-color: #7b7b7b;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.btn-success {
  background: #28a745;
}

.toggle-password {
  border: none;
  background: none;
  cursor: pointer;
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
}
</style>
