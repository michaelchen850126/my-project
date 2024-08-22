<template>
    <div>
      <Navbar />
      <div class="product-style-container" style="background-color: rgb(246, 245, 242);">
        <input type="text" v-model="searchQuery" placeholder="產品名稱" @input="filterProducts" />
  
        <div class="style-row">
          <h2>宅家舒適</h2>
          <div class="product-cards">
            <div class="card" v-for="(product, index) in filteredHomeProducts" :key="index">
              <router-link :to="product.link">
                <img :src="product.image" alt="Product Image">
              </router-link>
              <div class="card-body">
                <h5 class="card-title">{{ product.name }}</h5>
                <p class="card-text">{{ product.description }}</p>
              </div>
            </div>
          </div>
        </div>
  
        <div class="style-row">
          <h2>運動精選系列</h2>
          <div class="product-cards">
            <div class="card" v-for="(product, index) in filteredSportsProducts" :key="index">
              <router-link :to="product.link">
                <img :src="product.image" alt="Product Image">
              </router-link>
              <div class="card-body">
                <h5 class="card-title">{{ product.name }}</h5>
                <p class="card-text">{{ product.description }}</p>
              </div>
            </div>
          </div>
        </div>
  
        <div class="style-row">
          <h2>職場穿搭推薦</h2>
          <div class="product-cards">
            <div class="card" v-for="(product, index) in filteredWorkProducts" :key="index">
              <router-link :to="product.link">
                <img :src="product.image" alt="Product Image">
              </router-link>
              <div class="card-body">
                <h5 class="card-title">{{ product.name }}</h5>
                <p class="card-text">{{ product.description }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
    
  <script setup>
  import { ref, computed } from 'vue';
  
  // 定義響應式變量
  const searchQuery = ref('');
  
  // 定義產品數據
  const homeProducts = [
    { image: new URL('@/assets/images/productstyle10/毛圈連帽外套.jpg', import.meta.url).href, name: '毛圈連帽外套', link: '/Product/1', description: '' },
    { image: new URL('@/assets/images/productstyle10/長版罩衫.jpg', import.meta.url).href, name: '長版罩衫', link: '/Product/1', description: '' },
    { image: new URL('@/assets/images/productstyle10/軍裝連帽水洗外套.jpg', import.meta.url).href, name: '軍裝連帽水洗外套', link: '/Product/1', description: '' },
    { image: new URL('@/assets/images/productstyle10/寬版圓領開襟外套.jpg', import.meta.url).href, name: '寬版圓領開襟外套', link: '/Product/1', description: '' },
  ];
  
  const sportsProducts = [
    { image: new URL('@/assets/images/productstyle10/吸排抗UV網眼連帽外套.jpg', import.meta.url).href, name: '吸排抗UV網眼連帽外套', link: '/Product/1', description: '' },
    { image: new URL('@/assets/images/productstyle10/吸排彈性修身立領外套.jpg', import.meta.url).href, name: '吸排彈性修身立領外套', link: '/Product/1', description: '' },
    { image: new URL('@/assets/images/productstyle10/空氣層短版連帽外套.jpg', import.meta.url).href, name: '空氣層短版連帽外套', link: '/Product/1', description: '' },
    { image: new URL('@/assets/images/productstyle10/涼感抗UV寬襬立領外套.jpg', import.meta.url).href, name: '涼感抗UV寬襬立領外套', link: '/Product/1', description: '' },
  ];
  
  const workProducts = [
    { image: new URL('@/assets/images/productstyle10/休閒格紋西裝外套.jpg', import.meta.url).href, name: '休閒格紋西裝外套', link: '/Product/1', description: '' },
    { image: new URL('@/assets/images/productstyle10/輕型無領西裝外套.jpg', import.meta.url).href, name: '輕型無領西裝外套', link: '/Product/1', description: '' },
    { image: new URL('@/assets/images/productstyle10/輕薄排釦西裝外套.jpg', import.meta.url).href, name: '輕薄排釦西裝外套', link: '/Product/1', description: '' },
    { image: new URL('@/assets/images/productstyle10/雙排釦格紋西裝外套.jpg', import.meta.url).href, name: '雙排釦格紋西裝外套', link: '/Product/1', description: '' },
  ];
  
  // 計算屬性
  const filteredHomeProducts = computed(() => 
    homeProducts.filter(product => 
      (product.name && product.name.includes(searchQuery.value)) || 
      (product.description && product.description.includes(searchQuery.value))
    )
  );
  
  const filteredSportsProducts = computed(() => 
    sportsProducts.filter(product => 
      (product.name && product.name.includes(searchQuery.value)) || 
      (product.description && product.description.includes(searchQuery.value))
    )
  );
  
  const filteredWorkProducts = computed(() => 
    workProducts.filter(product => 
      (product.name && product.name.includes(searchQuery.value)) || 
      (product.description && product.description.includes(searchQuery.value))
    )
  );
  </script>
  
  
    
    <style scoped>
    .product-style-container {
      padding: 20px;
    }
    
    .style-row {
      margin-bottom: 40px;
    }
    
    .style-row h2 {
      margin-bottom: 20px;
      text-align: center;
      font-size: 1.5em;
      color: #333;
    }
    
    .product-cards {
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
    }
    
    .card {
      width: 18%;
      border: none;
      overflow: hidden;
      transition: transform 0.2s;
      margin-bottom: 20px;
      background-color: rgb(246, 245, 242); 
    }
    
    .card img {
      width: 100%;
      height: 300px;
    }
    
    .card-body {
      padding: 15px;
      text-align: center;
    }
    
    .card-title {
      font-size: 1.25em;
      margin-bottom: 10px;
    }
    
    .card-text {
      font-size: 1em;
      margin-bottom: 15px;
    }
    
    .card:hover {
      transform: scale(1.05);
    }
    
    .card-link:hover .card-title {
      color: #9f5000;
    }
    </style>
    