<template>
    <div class="Banner" style="display: flex !important;  background-color: rgb(246, 245, 242);">
      <h1><router-link to="/">JST</router-link></h1>
      <nav class="nav">
        <div class="nav-left">
          <ul>
            <li
              class="dropdown"
              v-for="(category, index) in categories"
              :key="category.name"
              @mouseover="showDropdown(index)"
              @mouseleave="hideDropdown(index)"
            >
              <router-link :to="category.link">{{ category.name }}</router-link>
              <ul
                class="dropdown-content"
                :class="{ show: isDropdownVisible(index) }"
                @mouseover="keepDropdown(index)"
                @mouseleave="hideDropdown(index)"
              >
                <li
                  class="sub-dropdown"
                  v-for="(subCategory, subIndex) in category.subCategories"
                  :key="subCategory.name"
                  @mouseover="showSubDropdown(index, subIndex)"
                  @mouseleave="hideSubDropdown(index, subIndex)"
                >
                <router-link :to="subCategory.link" class="dropdownA">{{ subCategory.name }}</router-link>
                </li>
              </ul>
            </li>
          </ul>
        </div>



        <div class="nav-right">
          <ul>
                    <!-- 購物車 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--> 
            <li class="li2" style="margin:10px 10px 30px 0px; position: relative;">
              <router-link to="/carts/cart" @click="handleCartClick">
                <el-badge :value="cartCount" class="item" style="color: #101b2d;" >
                  <font-awesome-icon icon="fa-solid fa-cart-shopping" size="sm" />
                </el-badge>
              </router-link>
            </li>
<!-- 會員開始 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~會員開始~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~會員開始~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~會員開始-->


            <li
              v-if="user"
              class="dropdown user-dropdown"
              @mouseover="toggleUserDropdown(true)"
              @mouseleave="toggleUserDropdown(false)"
            >
              <a class="nav-link dropdown-toggle" href="#" role="button">
                <div class="flex items-center">
                <!-- 顯示用戶的大頭照 -->
                <img class="profile-img" :src="`${path}${user.email}`" :alt="user.username" />
                {{ user.username }}
            </div> 
              </a>
              <ul class="user-dropdown-menu" :class="{ show: isUserDropdownOpen }">
                <li>
                  <a class="dropdown-item" href="#" @click="promptPasswordVerification">
                    <font-awesome-icon icon="fa-solid fa-edit" size="sm" /> 編輯會員
                  </a>
                </li>


                <li>
                  <a class="dropdown-item" href="#" @click="navigateToOrderHistory">
                    <font-awesome-icon icon="fa-solid fa-receipt" size="sm"/> 歷史訂單
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="#" @click="navigateToCoupon">
                    <font-awesome-icon icon="fa-solid fa-ticket-simple" size="sm"/> 領取折價券
                  </a>
                </li>



            <li>
                <a class="dropdown-item" href="#" @click="confirmLogout">
                <font-awesome-icon icon="fa-solid fa-sign-out-alt" size="sm" /> 登出
                </a>
            </li>

              </ul>
            </li>

        <li v-if="!user" class="li2">
            <router-link :to="{ name: 'secure-login-link' }">
            <font-awesome-icon icon="fa-solid fa-user" fade size="sm" style="color: #101b2d;" /> 登入
            </router-link>
        </li>
<!-- 會員結束 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~會員結束~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~會員結束~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~會員結束-->

          </ul>
        </div>
      </nav>
    </div>
  </template>

  
  <script setup>
  import { ref, onMounted } from 'vue';
  import { useRouter } from 'vue-router';
  import Swal from 'sweetalert2';
  import axiosapi from '@/plugins/axios';
  import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
  import { ElBadge } from 'element-plus';
  import cartCount from '@/views/eventBus';


  
  const path = import.meta.env.VITE_PHOTO_API; // 读取环境变量
  const router = useRouter();
  const user = ref(null);
  const isUserDropdownOpen = ref(false);
  const dropdownVisible = ref(null);
  const subDropdownVisible = ref({});
  
// 產品功能~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~產品功能~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~產品功能~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~產品功能~~~~~~~~~~~~~~~~~~~~~~

  const categories = [
    {
      name: '男裝',
      link: '/ProductlistOne',
      subCategories: [
        { name: '上衣', link: '/ProductStyleOne' },
        { name: '下身', link: '/ProductStyleTwo' },
        { name: '聯名Ｔ', link: '/ProductStyleThree' },
        { name: '牛仔褲', link: '/ProductStyleFour' },
        { name: '外套', link: '/ProductStyleFive' },
      ],
    },
    {
      name: '女裝',
      link: '/ProductlistTwo',
      subCategories: [
        { name: '上衣', link: '/ProductStyle6' },
        { name: '下身', link: '/ProductStyle7' },
        { name: '聯名Ｔ', link: '/ProductStyle8' },
        { name: '牛仔褲', link: '/ProductStyle9' },
        { name: '外套', link: '/ProductStyle10' },
      ],
    },
    {
      name: '童裝',
      link: '/ProductlistThree',
      subCategories: [
        { name: '上衣', link: '/ProductStyle11' },
        { name: '下身', link: '/ProductStyle12' },
        { name: '聯名Ｔ', link: '/ProductStyle13' },
        { name: '牛仔褲', link: '/ProductStyle14' },
        { name: '外套', link: '/ProductStyle15' },
      ],
    },
  ];
  // 顯示下拉選單
  const showDropdown = (index) => {
    dropdownVisible.value = index;
  };
  // 隱藏下拉選單
  const hideDropdown = (index) => {
    dropdownVisible.value = null;
  };
  // 保持下拉選單顯示
  const keepDropdown = (index) => {
    dropdownVisible.value = index;
  };
  // 檢查下拉選單是否顯示
  const isDropdownVisible = (index) => {
    return dropdownVisible.value === index;
  };
  
// 顯示子下拉選單
const showSubDropdown = (categoryIndex, subCategoryIndex) => {
if (!subDropdownVisible.value[categoryIndex]) {
    subDropdownVisible.value[categoryIndex] = {};
}
subDropdownVisible.value[categoryIndex][subCategoryIndex] = true;
};

  
// 隱藏子下拉選單
const hideSubDropdown = (categoryIndex, subCategoryIndex) => {
if (subDropdownVisible.value[categoryIndex]) {
    subDropdownVisible.value[categoryIndex][subCategoryIndex] = false;
}
};
  
// 檢查子下拉選單是否顯示
const isSubDropdownVisible = (categoryIndex, subCategoryIndex) => {
return (
    subDropdownVisible.value[categoryIndex] &&
    subDropdownVisible.value[categoryIndex][subCategoryIndex]
);
};

// 會員在這兒~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~會員在這兒~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~會員在這兒~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~會員在這兒~~~~~~~~~~~~~~~~~~~~~~



  
// 切換用戶下拉選單的顯示狀態
const toggleUserDropdown = (state) => {
isUserDropdownOpen.value = state;
};
  

  
  
// 確認是否登出
const confirmLogout = () => {
Swal.fire({
    title: '確認登出?',
    text: '您確定要登出嗎？',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: '是的，登出',
    cancelButtonText: '取消',
}).then((result) => {
    if (result.isConfirmed) {
    logout();
    }
});
};


  const logout = () => {
    sessionStorage.clear();
    user.value = null;
    axiosapi.defaults.headers.authorization = '';
    Swal.fire({
      icon: 'success',
      title: '已登出',
      text: '您已成功登出！',
      showConfirmButton: false,
      timer: 1000,
    }).then(() => {
      window.location.reload();
    });
    router.push('/');
  };
  
// 初始化用戶資料
onMounted(() => {
const storedUser = JSON.parse(sessionStorage.getItem('user'));
if (storedUser) {
    user.value = storedUser;
}
});
  

// 顯示密碼驗證對話框
const promptPasswordVerification = () => {
Swal.fire({
    title: '請輸入密碼',
    input: 'password',
    inputAttributes: {
    autocapitalize: 'off',
    placeholder: '請輸入密碼'
    },
    showCancelButton: true,
    confirmButtonText: '確認',
    showLoaderOnConfirm: true,
    preConfirm: (password) => {
    return axiosapi.post('/api/auth/verify-password', {
        email: user.value.email,
        password: password
    }).then(response => {
        if (!response.data.success) {
        throw new Error(response.data.message || '驗證失敗');
        }
        return response.data;
    }).catch(error => {
        Swal.showValidationMessage(`請求失敗: ${error.message}`);
    });
    },
    allowOutsideClick: () => !Swal.isLoading()
}).then((result) => {
    if (result.isConfirmed && result.value.success) {
    router.push({ name: 'secure-ModifyUser-link' });
    }
});
};

  function navigateToOrderHistory() {
  router.push('/carts/OrderList');
}

function navigateToCoupon() {
  router.push('/carts/CouponList');
}

function handleCartClick() {
    if(user.value != null){
  router.push('/carts/cart');
}else{
  router.push('/secure/Login');
}
}
  </script>
  
  <style scoped>
@import '../assets/Css/navbar.css';




.chat-icon {
  position: absolute;
  bottom: 20px;
  right: 20px;
  z-index: 1000;
}

.dropdown-content,
.sub-dropdown-content {
  display: none;
}

.show {
  display: block;
}

.user-dropdown-menu {
  position: absolute;
  right: 0;
  top: 100%;
  background-color: rgb(240, 235, 227);;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  list-style: none;
  border-radius: 25px;
  padding: 0;
  margin: 0;
  display: none;
  z-index: 2000; /* 确保下拉菜单在其他内容之上 */
}

.user-dropdown-menu.show {
  display: block;
}

.user-dropdown-menu li {
  padding: 10px 20px;
  font-size: 20px;
  font-weight: bold;
}

.user-dropdown-menu li a {
  color: #333;
  text-decoration: none;
  font-size: 20px;
  font-weight: bold;
}

.user-dropdown-menu li a:hover {
  background-color: #f5f5f5;
  color: #9f5000;
}

.profile-img {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  margin-right: 10px;
}
.dropdown-toggle::after {
  display: none;
}

</style>
  