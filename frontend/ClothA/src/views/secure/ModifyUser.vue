<template>
  <div class="divimg">
    <br>
    <br>
    <div class="registration-form">
      <h2>修改用戶資料</h2>
      <el-form :model="form" label-width="auto">
        <!-- 用戶名欄位 -->
        <el-form-item label="用戶名">
          <el-input v-model="form.username" />
        </el-form-item>
        
        <!-- 性別欄位 -->
        <el-form-item label="性別">
          <el-radio-group v-model="form.gender">
            <el-radio label="男">男</el-radio>
            <el-radio label="女">女</el-radio>
            <el-radio label="不方便透露">不方便透露</el-radio>
          </el-radio-group>
        </el-form-item>
        
        <!-- 生日欄位 -->
        <el-form-item label="生日">
          <el-date-picker v-model="form.birth" type="date" placeholder="選擇生日" />
        </el-form-item>
        
        <!-- Email欄位 -->
        <el-form-item label="Email">
          <el-input v-model="form.email" disabled />
        </el-form-item>
        
        <!-- 密碼欄位 -->
        <el-form-item label="密碼">
          <el-input v-model="form.password" type="password" placeholder="請輸入密碼" />
        </el-form-item>
        <el-form-item label="確認密碼">
          <el-input v-model="confirmPassword" type="password" placeholder="請輸入確認密碼" />
          <p v-if="passwordMismatch" class="error-message">密碼不匹配</p>
        </el-form-item>
  
        <!-- 電話號碼欄位 -->
        <el-form-item label="手機號碼">
          <el-input v-model="form.phone" />
        </el-form-item>
        
        <!-- 地址欄位 -->
        <el-form-item label="地址">
          <div class="address-fields">
            <el-select v-model="form.selectedCity" @change="onCityChange" placeholder="選擇縣市">
              <el-option v-for="city in cities" :key="city" :label="city" :value="city" />
            </el-select>
            <el-select v-model="form.selectedDistrict" placeholder="選擇區域">
              <el-option v-for="district in districts" :key="district" :label="district" :value="district" />
            </el-select>
            <el-input v-model="form.address" placeholder="請輸入詳細地址" />
          </div>
        </el-form-item>
  
        <!-- 上傳照片欄位 -->
        <el-form-item label="大頭照">
          <input type="file" @change="handleFileChange" accept="image/*" />
          <div v-if="form.avatar">
            <p>{{ form.avatar.name }}</p>
            <img :src="avatarPreview" alt="預覽圖片" style="max-width: 200px; margin-top: 10px;" />
          </div>
        </el-form-item>
  
          <!-- 按鈕區域 -->
          <div class="button-section">
            <el-form-item>
              <div class="button-group">
                <el-button type="success" :icon="Check" circle @click="submitRegistration" />
                <el-button type="info" round @click="goHome">取消</el-button>
              </div>
            </el-form-item>
            <p v-if="error" class="error-message">{{ error }}</p>
          </div>
      </el-form>
    </div>
    <br>
    <br>
    <br>
    <br>
  </div>
  </template>
  
  <script lang="ts" setup>
  import { ref, onMounted, watch, computed } from 'vue';
  import axiosapi from '@/plugins/axios';
  import { useRouter } from 'vue-router';
  import Swal from 'sweetalert2';
  import { Check } from '@element-plus/icons-vue';
  
  // 初始化路由和數據
  const router = useRouter();
  const form = ref({
    username: '',
    email: '',
    password: '',
    gender: '',
    birth: '',
    phone: '',
    address: '',
    selectedCity: '',
    selectedDistrict: '',
    avatar: null as File | null
  });
  const confirmPassword = ref('');
  const passwordMismatch = ref(false);
  const error = ref('');
  const cities = ref<string[]>([]);
  const districts = ref<string[]>([]);
  const districtsByCity = ref<Record<string, string[]>>({});
  const avatarPreview = computed(() => {
    if (form.value.avatar) {
      return URL.createObjectURL(form.value.avatar);
    }
    return '';
  });
  
  // 載入縣市和區域資料
  const loadDistricts = async () => {
    try {
      const response = await fetch('/taiwan_districts.json');
      const data = await response.json();
      cities.value = data.map((item: { name: string }) => item.name);
      districtsByCity.value = data.reduce((acc: Record<string, string[]>, item: { name: string; districts: { name: string }[] }) => {
        acc[item.name] = item.districts.map(d => d.name);
        return acc;
      }, {});
    } catch (error) {
      console.error('載入縣市資料失敗:', error);
    }
  };
  
  // 縣市變更時更新區域資料
  const onCityChange = () => {
    districts.value = districtsByCity.value[form.value.selectedCity] || [];
    form.value.selectedDistrict = '';
  };
  
  // 監控密碼匹配
  watch([() => form.value.password, confirmPassword], () => {
    passwordMismatch.value = form.value.password !== confirmPassword.value;
  });
  
  const handleFileChange = (event: Event) => {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files[0]) {
      form.value.avatar = input.files[0];
    }
  };
  
  const submitRegistration = async () => {
    if (passwordMismatch.value) {
      error.value = '密碼不匹配';
      return;
    }
  
    try {
      const formData = new FormData();
      formData.append('username', form.value.username);
      formData.append('email', form.value.email);
      formData.append('password', form.value.password);
      formData.append('gender', form.value.gender);
      formData.append('birth', form.value.birth);
      formData.append('phone', form.value.phone);
      formData.append('address', `${form.value.selectedCity} ${form.value.selectedDistrict} ${form.value.address}`);
      if (form.value.avatar) {
        formData.append('avatar', form.value.avatar);
      }
  
      const response = await axiosapi.put('/api/auth/modify', formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });
  
      if (response.data.success) {
        // 更新 sessionStorage 中的用戶資料
        const updatedUser = {
          ...JSON.parse(sessionStorage.getItem('user') || '{}'),
          username: form.value.username
        };
        sessionStorage.setItem('user', JSON.stringify(updatedUser));
        sessionStorage.setItem('username', form.value.username); // 確保更新用戶名
        sessionStorage.setItem('password', form.value.password);
        window.dispatchEvent(new Event('storage')); // 觸發 storage 事件
  
        Swal.fire({
          icon: 'success',
          text: '您的資料已成功更新。',
          showConfirmButton: false,
          timer: 1000, // 設定對話框顯示的時間（以毫秒為單位）
          willClose: () => {
            // router.push('/');
            window.location.reload(); // 重新加載頁面
          }
        });
      } else {
        error.value = response.data.message || '更新失敗，請再試一次。';
      }
    } catch (err) {
      if (err.response && err.response.status === 409) {
        error.value = '此用戶名已被註冊';
      } else {
        console.error('更新失敗:', err);
        error.value = '更新失敗，請稍後再試。';
      }
    }
  };
  
  // 獲取使用者資料
  const fetchUserProfile = async () => {
    try {
      const email = sessionStorage.getItem('userEmail');
      if (email) {
        const response = await axiosapi.get(`/api/auth/profile?userEmail=${email}`);
        if (response.data.success) {
          const user = response.data.user[0];
          form.value.username = user.name;
          form.value.email = user.email;
          form.value.gender = user.gender;
          form.value.birth = user.birth; // 確保格式為 yyyy-MM-dd
          form.value.phone = user.phone;
          form.value.address = user.address;
          const addressParts = user.address.split(' ');
          form.value.selectedCity = addressParts[0];
          form.value.selectedDistrict = addressParts[1];
          form.value.address = addressParts.slice(2).join(' ');
        } else {
          error.value = response.data.message || '無法獲取使用者資料';
        }
      }
    } catch (error) {
      console.error('獲取使用者資料失敗:', error);
      error.value = '獲取使用者資料失敗';
    }
  };
  
  // 返回首頁
  const goHome = () => {
    router.push('/');
  };
  
  // 初始化資料
  onMounted(() => {
    loadDistricts();
    fetchUserProfile();
  });
  </script>
  
  <style scoped>

.divimg {
  background-image: url('@/assets/images/usersBackground/Modifier.jpg'); /* 设置背景图像 */
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

  .registration-form {
    position: relative; /* 設置為 relative 以便內部的 absolute 定位元素相對於這個元素定位 */
    max-width: 600px;
    margin: 0 auto;
    background-color: #f5f5f5;  /* 淺木頭色背景 */
    color: #333; /* 深色文字 */
    padding: 20px;
    border-radius: 12px; /* 更圓的邊角 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 柔和的陰影 */
  }
  
  h2 {
    color: #8d6e63; /* 木頭色調 */
    border-bottom: 2px solid #8d6e63; /* 木頭色底部邊框 */
    padding-bottom: 10px; /* 底部內邊距 */
  }
  
  .el-form-item {
    margin-bottom: 20px; /* 增加間距 */
  }
  
  .el-form-item label {
    font-weight: 400; /* 更輕的字重 */
    color: #8d6e63; /* 木頭色 */
  }
  
  .el-input,
  .el-date-picker,
  .el-select {
    border-radius: 6px; /* 更柔和的邊角 */
    background-color: #fff; /* 白色背景 */
    color: #333; /* 深色文字 */
    border: 1px solid #ddd; /* 淺色邊框 */
    box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1); /* 柔和的內部陰影 */
  }
  
  .el-input::placeholder,
  .el-date-picker__placeholder {
    color: #aaa; /* 更柔和的佔位文字顏色 */
  }
  
  .el-button {
    border-radius: 6px; /* 更柔和的邊角 */
    padding: 12px 24px; /* 增加內邊距 */
    font-weight: 400; /* 更輕的字重 */
  }
  
  .el-button.success {
    background-color: #8d6e63; /* 木頭色 */
    color: white;
    border: 1px solid #8d6e63;
  }
  
  .el-button.info {
    background-color: #a1887f; /* 更柔和的木頭色 */
    color: white;
    border: 1px solid #a1887f;
  }
  
  .el-button.success:hover,
  .el-button.info:hover {
    opacity: 0.85; /* 更柔和的懸停效果 */
  }
  
  .address-fields {
    display: flex;
    flex-direction: column;
    gap: 12px; /* 增加間距 */
  }
  
  img {
    border-radius: 10px; /* 更柔和的邊角 */
  }
  
  .error-message {
    color: #f44336; /* 文青風格的紅色 */
    font-size: 15px; /* 增加字體大小 */
    margin-top: 12px; /* 增加間距 */
  }
  
  .button-group {
    display: flex;
    gap: 12px; /* 增加間距 */
    justify-content: flex-end;
  }
  
  .button-section {
    position: absolute;
    bottom: 20px; /* 距離底部 20px */
    right: 45px; /* 距離右側 20px */
    display: flex;
    flex-direction: column;
    align-items: flex-end; /* 按鈕右對齊 */
  }
  </style>
  
  
  