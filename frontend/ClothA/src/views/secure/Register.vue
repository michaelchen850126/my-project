<template>
<div class="divimg">
<div class="register-container">
<!-- 步驟條 -->
<el-steps style="width: 500px; max-width: 1000px" :active="step - 1" finish-status="success">
<el-step title="步驟 1" />
<el-step title="步驟 2" />
<el-step title="步驟 3" />
<el-step title="步驟 4" />
<el-step title="步驟 5" />
</el-steps>

<!-- 步驟內容 -->
<div class="card">
<div class="header">
<!-- 返回登入畫面按鈕 -->
<button v-if="step === 1" type="button" class="btn btn-back" @click="goToLogin">
    <font-awesome-icon icon="fa-solid fa-arrow-left" size="2xl" />
    返回登入
    </button>
    <!-- 返回上一個步驟按鈕 -->
    <button v-if="step > 1" type="button" class="btn btn-back" @click="goBack">
        <font-awesome-icon icon="fa-solid fa-arrow-left" size="2xl" />
        返回上一步
    </button>
    <h3>註冊 - 第{{ step }}步</h3>
</div>

<!-- 步驟 1: 發送驗證碼 -->
<form @submit.prevent="sendVerificationCode" v-show="step === 1">
    <div class="form-group">
        <label>信箱:</label>
        <input type="email" v-model="registrationData.email" required class="form-control" placeholder="請輸入電子郵件" />
    </div>
    <el-button type="primary" @click="sendVerificationCode">發送驗證碼</el-button>
</form>

<!-- 步驟 2: 驗證驗證碼 -->
<form @submit.prevent="verifyCode" v-show="step === 2">
<div class="form-group">
<label>驗證碼:</label>
<input type="text" v-model="registrationData.inputVerificationCode" required class="form-control" placeholder="請輸入驗證碼" />
</div>
<button type="submit" class="btn btn-success">驗證</button>
</form>

<!-- 步驟 3: 填寫用戶名和密碼 -->
<form @submit.prevent="submitStep3" v-show="step === 3">
<div class="form-group">
<label>用戶名:</label>
<input type="text" v-model="registrationData.username" required class="form-control" placeholder="請輸入用戶名" />
</div>
<div class="form-group">
<label>密碼:</label>
<div class="password-wrapper">
    <input :type="passwordFieldType" v-model="registrationData.password" required class="form-control" placeholder="請輸入密碼" />
    <button type="button" @click="togglePasswordVisibility" class="toggle-password">
        <font-awesome-icon :icon="passwordFieldType === 'password' ? 'eye' : 'eye-slash'" />
    </button>
</div>
</div>
<button type="submit" class="btn btn-primary">下一步</button>
</form>

<!-- 步驟 4: 填寫性別、生日和手機號碼 -->
<form @submit.prevent="submitStep4" v-show="step === 4">
<div class="form-group">
<label>性別:</label>
<select v-model="registrationData.gender" required class="form-control">
<option value="" disabled>請選擇性別</option>
<option value="male">男性</option>
<option value="female">女性</option>
<option value="other">不願透露</option>
</select>
</div>
<div class="form-group">
<label>生日:</label>
<input type="date" v-model="registrationData.birthday" required class="form-control" />
</div>
<div class="form-group">
<label>手機號碼:</label>
<input type="tel" v-model="registrationData.phone" pattern="[0-9]{10}" required class="form-control" placeholder="請輸入手機號碼" />
</div>
<button type="submit" class="btn btn-primary">下一步</button>
</form>

<!-- 步驟 5: 填寫地址和選擇照片 -->
<form @submit.prevent="submitRegistration" v-show="step === 5">
<div class="form-group">
<label>選擇縣市:</label>
<select v-model="registrationData.selectedCity" @change="onCityChange" required class="form-control">
<option value="" disabled>請選擇縣市</option>
<option v-for="(city, index) in cities" :key="index" :value="city">{{ city }}</option>
</select>
</div>
<div class="form-group">
<label>選擇區域:</label>
<select v-model="registrationData.selectedDistrict" required class="form-control">
<option value="" disabled>請選擇區域</option>
<option v-for="(district, index) in districts" :key="index" :value="district.name">{{ district.name }}</option>
</select>
</div>
<div class="form-group">
<label>詳細地址:</label>
<input type="text" v-model="registrationData.address" required class="form-control" placeholder="請輸入詳細地址" />
</div>
<div class="form-group">
<FileUpload class="btn btn-light" accept="imge/*"
    input-id="filess" input-name="filess" v-model="filess"
    :multiple="true">
    選擇圖片
</FileUpload>

<!-- 選擇圖片
</FileUpload> -->
<!-- 顯示選擇的檔案 -->
<div v-if="registrationData.avatar">
<p>{{ registrationData.avatar.name }}</p>
</div>
</div>
<button type="submit" class="btn btn-primary">註冊</button>
</form>

<!-- 顯示錯誤信息 -->
<div v-if="error" class="alert alert-danger">
<p>{{ error }}</p>
</div>

<!-- 顯示發送驗證碼後的小視窗 -->
<div v-if="showEmailNotification" class="notification">
<p>驗證碼已發送至您的信箱，請查收郵件。</p>
</div>

<!-- 註冊成功顯示提示 -->
<div v-if="registrationSuccess" style="max-width: 600px">
<el-alert title="註冊成功" type="success" show-icon />
</div>
</div>
</div>
<br>
</div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axiosapi from '@/plugins/axios';
import Swal from 'sweetalert2';
import FileUpload from 'vue-upload-component';
import { useRouter, useRoute } from 'vue-router'; // 用於操作路由的組件，讓你可以在 Vue 組件中進行路由跳轉。
import { ElLoading } from 'element-plus';

const filess = ref([]);
const router = useRouter(); 
const route = useRoute(); // 使用 useRoute 獲取當前路由對象
const step = ref(1);
const error = ref('');
const showEmailNotification = ref(false);
const passwordFieldType = ref('password');
const cities = ref([]);
const districts = ref([]);
const districtsByCity = ref({});
const registrationSuccess = ref(false);
const registrationData = ref({
email: '',
inputVerificationCode: '',
username: '',
password: '',
gender: '',
birthday: '',
phone: '',
selectedCity: '',
selectedDistrict: '',
address: '',
avatar: null,
});

// 發送驗證碼的函數==================================================================================
const sendVerificationCode = async () => {
const loading = ElLoading.service({
lock: true,
text: 'Loading',
background: 'rgba(0, 0, 0, 0.7)',
});

try {
const response = await axiosapi.post('/api/auth/register/step1', {
email: registrationData.value.email
});
if (response.data.success) {
loading.close(); // 關閉載入效果
step.value = 2;
error.value = '';
showEmailNotification.value = true;
setTimeout(() => showEmailNotification.value = false, 5000);
} else {
error.value = response.data.message || '無法發送驗證碼，請再試一次。';
loading.close(); // 關閉載入效果
}
} catch (err) {
console.error('Error during sendVerificationCode:', err);
loading.close(); // 關閉載入效果
error.value = '請求失敗，請稍後再試。';
}
};

// 驗證驗證碼的函數==================================================================================
async function verifyCode() {
Swal.fire({
text: "驗證中...",
allowOutsideClick: false,
showConfirmButton: false,
});

try {
const response = await axiosapi.post('/api/auth/register/step2', {
email: registrationData.value.email,
inputVerificationCode: registrationData.value.inputVerificationCode
});
if (response.data.success) {
Swal.close(); // 關閉驗證中視窗
step.value = 3;
error.value = '';
} else {
error.value = response.data.message || '驗證碼錯誤，請再試一次。';
Swal.close(); // 關閉驗證中視窗
}
} catch (error) {
console.error('Error during verifyCode:', error);
Swal.close(); // 關閉驗證中視窗
error.value = '請求失敗，請稍後再試。';
}
}


// 註冊第3步-提交資料(用戶名、密碼、性別、信箱)==================================================
async function submitStep3() {
try {
const formData = new FormData();
formData.append('username', registrationData.value.username);
formData.append('password', registrationData.value.password);
formData.append('email', registrationData.value.email);

const response = await axiosapi.post('/api/auth/register/step3', formData, {
headers: {
'Content-Type': 'multipart/form-data'
}
});

if (response.data.success) {
step.value = 4;
error.value = '';
} else {
error.value = response.data.message || '提交資料失敗，請再試一次。';
}
} catch (error) {
console.error('提交資料失敗:', error);
error.value = '提交資料失敗，請稍後再試。';
}
}


// 註冊第4步-提交資料(用戶名、密碼、性別、信箱)==================================================
async function submitStep4() {
try {
const formData = new FormData();
formData.append('gender', registrationData.value.gender);
formData.append('birth', registrationData.value.birthday); 
formData.append('phone', registrationData.value.phone);
formData.append('email', registrationData.value.email);

const response = await axiosapi.post('/api/auth/register/step4', formData, {
headers: {
'Content-Type': 'multipart/form-data'
}
});

if (response.data.success) {
step.value = 5;
error.value = '';
} else {
error.value = response.data.message || '提交資料失敗，請再試一次。';
}
} catch (error) {
console.error('提交資料失敗:', error);
error.value = '提交資料失敗，請稍後再試。';
}
}




// 註冊第5步-提交所有資料==================================================
async function submitRegistration() {
try {
// 組合完整的地址
const fullAddress = `${registrationData.value.selectedCity} ${registrationData.value.selectedDistrict} ${registrationData.value.address}`;

const formData = new FormData();
formData.append('email', registrationData.value.email);
formData.append('username', registrationData.value.username);
formData.append('password', registrationData.value.password);
formData.append('gender', registrationData.value.gender);
formData.append('birth', registrationData.value.birthday); // 修改為 "birth"
formData.append('phone', registrationData.value.phone);
formData.append('address', fullAddress); // 將組合的完整地址提交到後端
for(let i = 0; i < filess.value.length; i++) {
        formData.append("filess", filess.value[i].file);
    }

const response = await axiosapi.post('/api/auth/register/step5', formData, {
headers: {
'Content-Type': 'multipart/form-data'
}
});

if (response.data.success) {
// 註冊成功後跳轉至登入頁面
alert('註冊成功！');
router.push('/secure/login'); // 跳轉至登入頁面
} else {
error.value = response.data.message || '註冊失敗，請再試一次。';
}
} catch (error) {
console.error('註冊失敗:', error);
error.value = '註冊失敗，請稍後再試。';
}
}


// 各函數功能=================================================================================

// 載入縣市資料==========================================================================
onMounted(async () => {
// 檢查是否有查詢參數並自動填入帳號
if (route.query && route.query.email) {  // 確保 route.query 存在且 email 不為 undefined
registrationData.value.email = route.query.email;
}

try {
const response = await fetch('/taiwan_districts.json');
const data = await response.json();
cities.value = data.map(item => item.name);
districtsByCity.value = data.reduce((acc, item) => {
acc[item.name] = item.districts;
return acc;
}, {});
} catch (error) {
console.error('載入縣市資料失敗:', error);
}
});

// 根據所選城市載入區域==========================================================================
function onCityChange() {
districts.value = districtsByCity.value[registrationData.value.selectedCity] || [];
registrationData.value.selectedDistrict = '';
}

// 處理檔案變更
function handleFileChange(event) {
const file = event.target.files[0];
if (file) {
registrationData.value.avatar = file;
}
}


// 切換密碼顯示/隱藏================================================================================
function togglePasswordVisibility() {
// 切換密碼輸入框的顯示類型
passwordFieldType.value = passwordFieldType.value === 'password' ? 'text' : 'password';
}

// 返回登入頁面==========================================================================
function goToLogin() {
router.push('/secure/login');
}

// 返回上一步==========================================================================
function goBack() {
if (step.value > 1) {
step.value--;
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
background-image: url('@/assets/images/usersBackground/Forgot.jpg'); /* 设置背景图像 */
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

.register-container {
display: flex;
justify-content: center;
align-items: center;
flex-direction: column;
height: calc(89vh - 40px);
padding: 0 20px;
/* background: linear-gradient(135deg, #ffffff, #a39e9e); */
}

.card {
width: 100%;
max-width: 600px;
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
background: #dddddd;
color: black;
padding: 15px;
border: 1px solid #b5f1c3;
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

.password-wrapper {
position: relative;
display: flex;
align-items: center;
}

.password-wrapper input {
flex: 1;
padding-right: 40px; /* 給按鈕留出空間 */
}

.toggle-password {
position: absolute;
right: 10px;
top: 50%;
transform: translateY(-50%);
border: none;
background: none;
cursor: pointer;
}

</style>

