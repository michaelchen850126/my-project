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

const searchQuery = ref('');

const homeProducts = [
  { image: new URL('@/assets/images/productstyle15/毛圈連帽外套.jpg', import.meta.url).href, name: '毛圈連帽外套', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle15/休閒連帽外套.jpg', import.meta.url).href, name: '休閒連帽外套', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle15/棉質針織外套.jpg', import.meta.url).href, name: '棉質針織外套', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle15/輕型印花外套.jpg', import.meta.url).href, name: '輕型印花外套', link: '/Product/1', description: '' },
];

const sportsProducts = [
  { image: new URL('@/assets/images/productstyle15/AIRism防曬抗UV網眼連帽外套.jpg', import.meta.url).href, name: 'AIRism防曬抗UV網眼連帽外套', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle15/運動空氣層連帽外套.jpg', import.meta.url).href, name: '運動空氣層連帽外套', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle15/輕便休閒連帽外套.jpg', import.meta.url).href, name: '輕便休閒連帽外套', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle15/抗UV羅紋連帽外套.jpg', import.meta.url).href, name: '抗UV羅紋連帽外套', link: '/Product/1', description: '' },
];

const workProducts = [
  { image: new URL('@/assets/images/productstyle15/防曬可攜式連帽外套.jpg', import.meta.url).href, name: '防曬可攜式連帽外套', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle15/毛圈連帽外套.jpg', import.meta.url).href, name: '毛圈連帽外套', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle15/史努比系列雙面穿連帽外套.jpg', import.meta.url).href, name: '史努比系列雙面穿連帽外套', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyle15/鋪棉飛行外套.jpg', import.meta.url).href, name: '鋪棉飛行外套', link: '/Product/1', description: '' },
];

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
    