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
          <h2>戶外休閒</h2>
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
  { image: new URL('@/assets/images/productstyle11/蠟筆小新純棉衣.jpg', import.meta.url).href, name: '蠟筆小新純棉衣', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle11/純棉網眼素色背心.jpg', import.meta.url).href, name: '純棉網眼素色背心', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle11/純棉網眼印花T恤.jpg', import.meta.url).href, name: '純棉網眼印花T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle11/純棉印花家居套裝.jpg', import.meta.url).href, name: '純棉印花家居套裝', link: '/Product/1', description: '' },
];

const sportsProducts = [
  { image: new URL('@/assets/images/productstyle11/吸排網眼印花背心.jpg', import.meta.url).href, name: '吸排網眼印花背心', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle11/吸排網眼背心.jpg', import.meta.url).href, name: '吸排網眼背心', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle11/快乾棉圓領T恤.jpg', import.meta.url).href, name: '快乾棉圓領T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle11/吸排網眼T恤.jpg', import.meta.url).href, name: '吸排網眼T恤', link: '/Product/1', description: '' },
];

const workProducts = [
  { image: new URL('@/assets/images/productstyle11/竹節棉口袋印花T恤.jpg', import.meta.url).href, name: '竹節棉口袋印花T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle11/磨毛柔棉高領長袖T恤.jpg', import.meta.url).href, name: '磨毛柔棉高領長袖T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle11/格紋短袖襯衫.jpg', import.meta.url).href, name: '格紋短袖襯衫', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle11/柔棉長袖襯衫.jpg', import.meta.url).href, name: '柔棉長袖襯衫', link: '/Product/1', description: '' },
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
    