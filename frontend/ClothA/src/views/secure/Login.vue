<template>
 <div class="divimg">
 <div class="login-container">
    <div class="login-card">
      <!-- 用於顯示警告信息 -->
    <el-alert v-if="alertVisible" :title="alertTitle" :type="alertType" center />
      <h3>登入</h3>
      <form @submit.prevent="login">
        <div class="form-group">
          <label for="email">
            <font-awesome-icon icon="fa-solid fa-envelope" size="sm" style="color: #000000;" />
            電子郵件
          </label>
          <input type="email" id="email" v-model="email" required placeholder="輸入電子郵件" />
        </div>
        <div class="form-group password-group">
          <label for="password">
            <font-awesome-icon icon="fa-solid fa-key" size="sm" style="color: #000000;" />
            密碼
          </label>
          <div class="password-wrapper">
            <input :type="passwordFieldType" id="password" v-model="password" required placeholder="輸入密碼" />
            <button type="button" @click="togglePasswordVisibility" class="toggle-password">
              <font-awesome-icon :icon="passwordFieldType === 'password' ? 'eye' : 'eye-slash'" size="sm" />
            </button>
          </div>
        </div>
        <div class="form-group">
          <label for="inputCode">驗證碼：</label>
          <div class="code_show">
            <canvas id="codeCanvas" width="120" height="30"></canvas>
            <a id="linkbt" @click.prevent="generateCode">看不清換一張</a>
          </div>
          <input type="text" id="inputCode" v-model="inputCode" />
          <span id="text_show">{{ textShow }}</span>
        </div>
        <div class="form-group">
          <label>
            <input type="checkbox" v-model="rememberMe" />記住密碼
          </label>
        </div>
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">登入</button>
        </div>
      </form>
      <div class="extra-links">
        <router-link to="/secure/Register" class="link">新用戶</router-link>
        <router-link to="/secure/ForgotPwd" class="link">忘記密碼</router-link>
      </div>
    </div>
  </div>
</div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axiosapi from '@/plugins/axios.js';
import Cookies from 'js-cookie';
import { ElAlert } from 'element-plus'; // 引入 Element Plus 的 ElAlert 組件

// 設定表單數據的狀態
const email = ref('');
const password = ref('');
const rememberMe = ref(false);
const passwordFieldType = ref('password');
const router = useRouter();
const loginAttempts = ref(0); // 登入嘗試次數
const inputCode = ref('');
const textShow = ref('');
let code = ''; // 驗證碼

// 用於顯示警告信息
const alertVisible = ref(false);
const alertTitle = ref('');
const alertType = ref('');

// 生成驗證碼
function generateCode() {
  const canvas = document.getElementById('codeCanvas');
  const ctx = canvas.getContext('2d');
  const codeLength = 6; // 驗證碼長度
  const codeChars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  // 隨機生成驗證碼
  code = '';
  for (let i = 0; i < codeLength; i++) {
    const charNum = Math.floor(Math.random() * codeChars.length);
    code += codeChars[charNum];
  }

  // 清除畫布
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  // 畫隨機背景
  ctx.fillStyle = '#f5f5f5';
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  // 畫隨機線條
  for (let j = 0; j < 2; j++) {
    ctx.beginPath();
    ctx.strokeStyle = '#'+Math.floor(Math.random()*16777215).toString(16);
    ctx.moveTo(Math.random() * canvas.width, Math.random() * canvas.height);
    ctx.lineTo(Math.random() * canvas.width, Math.random() * canvas.height);
    ctx.lineWidth = Math.random() * 2 + 1;
    ctx.stroke();
  }

  // 畫驗證碼文本
  ctx.font = 'bold 20px Arial';
  ctx.fillStyle = '#000';
  ctx.fillText(code, 10, 25);
}

// 驗證驗證碼
function validateCode() {
  if (inputCode.value.length <= 0) {
    textShow.value = '請輸入驗證碼';
    document.getElementById('text_show').style.color = 'red';
    return false;
  } else if (inputCode.value.toUpperCase() !== code.toUpperCase()) {
    textShow.value = '您輸入的驗證碼有誤';
    document.getElementById('text_show').style.color = 'red';
    generateCode(); // 驗證碼錯誤，重新生成
    return false;
  } else {
    textShow.value = '驗證碼正確';
    document.getElementById('text_show').style.color = 'green';
    return true;
  }
}

// 顯示警告信息
function showAlert(title, type) {
  alertTitle.value = title;
  alertType.value = type;
  alertVisible.value = true;

  setTimeout(() => {
    alertVisible.value = false;
  }, 3000); // 顯示警告 3 秒
}

// 登入功能
async function login() {
  if (!email.value || !password.value) {
    showAlert('請輸入電子信箱和密碼', 'warning');
    return;
  }

  if (!validateCode()) {
    showAlert('驗證碼錯誤，請重試', 'warning');
    return;
  }

  try {
    const request = {
      email: email.value,
      password: password.value,
    };

    const response = await axiosapi.post('/api/auth/login', request);

    if (response.data.success) {
      showAlert(`登入成功 歡迎 ${response.data.username}`, 'success');

      sessionStorage.setItem('userEmail', response.data.userEmail);
      sessionStorage.setItem('userId', response.data.userId);
      sessionStorage.setItem('username', response.data.username);
      sessionStorage.setItem('user', JSON.stringify({
        email: response.data.userEmail,
        id: response.data.userId,
        username: response.data.username,
        avatar: response.data.avatar,
      }));

      axiosapi.defaults.headers.authorization = `Bearer ${response.data.token}`;
      if (rememberMe.value) {
        Cookies.set('authToken', response.data.token, { expires: 30 });
        Cookies.set('userEmail', email.value, { expires: 30 });
      } else {
        Cookies.remove('authToken');
        Cookies.remove('userEmail');
      }
      router.push('/').then(() => {
        window.location.reload();
      });
    } else {
      handleLoginError(response.data.message);
    }
  } catch (error) {
    handleLoginError(error.message);
  }
}

// 處理登入錯誤
function handleLoginError(message) {
  loginAttempts.value++;
  if (loginAttempts.value >= 3) {
    router.push({ path: '/secure/ForgotPwd', query: { email: email.value } });
  } else if (message === '帳號未註冊') {
    router.push({ path: '/secure/Register', query: { email: email.value } });
  } else {
    showAlert(message, 'error');
  }
}


// 切換密碼可見性
function togglePasswordVisibility() {
  passwordFieldType.value = passwordFieldType.value === 'password' ? 'text' : 'password';
}

// 元件掛載時初始化
onMounted(() => {
  const storedEmail = Cookies.get('userEmail');
  if (storedEmail) {
    email.value = storedEmail;
    rememberMe.value = true;
  }

  const user = JSON.parse(sessionStorage.getItem('user'));
  if (user) {
    console.log('用戶 ID:', user.id);
  } else {
    console.log('用戶信息未儲存。');
  }

  generateCode(); // 初始化時生成驗證碼
  document.getElementById('linkbt').onclick = generateCode; // 點擊連結重新生成驗證碼
});
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
  background-image: url('@/assets/images/usersBackground/Login.jpg'); /* 设置背景图像 */
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
  background-color: rgba(122, 118, 118, 0.603); 
  z-index: 1; 
}

.divimg > * {
  position: relative; /* 使子元素相对于父容器定位，以确保它们在覆盖层之上 */
  z-index: 2;
}


.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-top: 5vh;
  height: 100vh;
  /* background: linear-gradient(135deg, rgba(143, 142, 142, 0.8), rgba(157, 154, 152, 0.8)); */
  animation: gradientAnimation 20s ease infinite;
}

.login-card {
  background-color: #fff;
  padding: 1.5rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  width: 100%;
  max-width: 360px;
  transition: box-shadow 0.3s ease-in-out;
}

.login-card:hover {
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
}

h3 {
  font-size: 1.5rem;
  color: #333;
  margin-bottom: 1rem;
  text-align: center;
}

.form-group {
  margin-bottom: 0.75rem;
}

label {
  display: block;
  font-size: 0.75rem;
  color: #555;
  margin-bottom: 0.25rem;
}

input[type="email"],
input[type="password"],
input[type="text"] {
  width: 100%;
  padding: 0.5rem;
  font-size: 0.875rem;
  border: 1px solid #ddd;
  border-radius: 6px;
  transition: border-color 0.2s ease;
}

input[type="email"]:focus,
input[type="password"]:focus,
input[type="text"]:focus {
  border-color: #787a7c;
}

.password-group {
  position: relative;
}

.password-wrapper {
  display: flex;
  align-items: center;
}

.toggle-password {
  position: absolute;
  right: 5px;
  background: none;
  border: none;
  cursor: pointer;
  color: #555;
  font-size: 0.875rem;
}

.code_show {
  display: flex;
  align-items: center;
}

#codeCanvas {
  margin-left: 5px;
  border: 1px solid #ddd;
  cursor: pointer;
}

#linkbt {
  margin-left: 5px;
  color: #565656;
  cursor: pointer;
}

#text_show {
  margin-top: 5px;
  font-size: 0.75rem;
}

.form-actions {
  margin-top: 1rem;
  text-align: center;
}

.btn {
  display: inline-block;
  padding: 0.5rem 1rem;
  font-size: 0.875rem;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.btn-primary {
  background-color: #000000;
  color: #fff;
}

.btn-primary:hover {
  background-color: #6c6c6c;
}

.extra-links {
  margin-top: 0.75rem;
  display: flex;
  justify-content: space-between;
}

.link {
  font-size: 0.75rem;
  color: #6c6c6c;
  text-decoration: none;
  transition: color 0.2s ease;
}

.link:hover {
  color: #000000;
}
</style>
