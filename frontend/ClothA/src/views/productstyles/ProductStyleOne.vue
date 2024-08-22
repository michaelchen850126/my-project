<template>
  <div>
    <div class="search-bar" style="display: flex; justify-content: flex-start; background-color:rgb(246, 245, 242); padding-top: 30px; padding-left: 30px;">
      <input v-model="searchQuery" @input="fetchFilteredProducts" placeholder="產品查詢">
    </div>
    <div class="product-style-container" style="background-color: rgb(246, 245, 242);">
      <!-- 宅家舒適 -->
      <div class="style-row">
        <h2>宅家舒適</h2>
        <div class="product-cards" style="display: flex; justify-content: flex-start;">
          <div class="card" v-for="(product, index) in filteredHomeProducts" :key="index" style="margin: 20px;">
            <router-link :to="`/product/${product.id}`">
              <img :src="getImageSrc(product.img)" alt="Product Image">
            </router-link>
            <div class="card-body">
              <h5 class="card-title">{{ product.name }}</h5>
            </div>
          </div>
        </div>
      </div>

      <!-- 運動精選系列 -->
      <div class="style-row">
        <h2>運動精選系列</h2>
        <div class="product-cards" style="display: flex; justify-content: flex-start;">
          <div class="card" v-for="(product, index) in filteredSportsProducts" :key="index" style="margin: 20px;">
            <router-link :to="`/product/${product.id}`">
              <img :src="getImageSrc(product.img)" alt="Product Image">
            </router-link>
            <div class="card-body">
              <h5 class="card-title">{{ product.name }}</h5>
            </div>
          </div>
        </div>
      </div>

      <!-- 職場穿搭推薦 -->
      <div class="style-row">
        <h2>職場穿搭推薦</h2>
        <div class="product-cards" style="display: flex; justify-content: flex-start;">
          <div class="card" v-for="(product, index) in filteredWorkProducts" :key="index" style="margin: 20px;">
            <router-link :to="`/product/${product.id}`">
              <img :src="getImageSrc(product.img)" alt="Product Image">
            </router-link>
            <div class="card-body">
              <h5 class="card-title">{{ product.name }}</h5>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import axiosapi from '@/plugins/axios';

export default {
  data() {
    return {
      searchQuery: '',
      homeProducts: [],
      sportsProducts: [],
      workProducts: [],
    };
  },
  created() {
    this.fetchFilteredProducts();
  },
  methods: {
    async fetchFilteredProducts() {
      try {
        const homeResponse = await axiosapi.post('/products/search', {
          size: 'S',
          style: '宅家舒適',
          color: '黑色',
          query: this.searchQuery
        }, {
          headers: {
            'Content-Type': 'application/json'
          }
        });

        console.log('Fetched home products:', homeResponse.data); // 添加调试信息
        this.homeProducts = homeResponse.data;

        const sportsResponse = await axiosapi.post('/products/search', {
          size: 'S',
          style: '運動精選系列',
          color: '黑色',
          query: this.searchQuery
        }, {
          headers: {
            'Content-Type': 'application/json'
          }
        });

        console.log('Fetched sports products:', sportsResponse.data); // 添加调试信息
        this.sportsProducts = sportsResponse.data;

        const workResponse = await axiosapi.post('/products/search', {
          size: 'S',
          style: '職場穿搭推薦',
          color: '黑色',
          query: this.searchQuery
        }, {
          headers: {
            'Content-Type': 'application/json'
          }
        });

        console.log('Fetched work products:', workResponse.data); // 添加调试信息
        this.workProducts = workResponse.data;

      } catch (error) {
        console.error('Error fetching products:', error);
      }
    },
    getImageSrc(image) {
      // 直接返回 Base64 编码的图片
      return 'data:image/jpeg;base64,' + image;
    }
  },
  computed: {
    filteredHomeProducts() {
      return this.homeProducts.filter(product => 
        (product.name && product.name.includes(this.searchQuery)) || 
        (product.description && product.description.includes(this.searchQuery))
      );
    },
    filteredSportsProducts() {
      return this.sportsProducts.filter(product => 
        (product.name && product.name.includes(this.searchQuery)) || 
        (product.description && product.description.includes(this.searchQuery))
      );
    },
    filteredWorkProducts() {
      return this.workProducts.filter(product => 
        (product.name && product.name.includes(this.searchQuery)) || 
        (product.description && product.description.includes(this.searchQuery))
      );
    }
  }
}
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

/* Main image styles */
.main-image-container {
  margin-top: 20px;
  text-align: center;
}

.main-image {
  width: 80%;
  max-height: 400px;
  object-fit: contain;
}
</style>
