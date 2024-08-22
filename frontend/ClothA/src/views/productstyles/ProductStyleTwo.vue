<template>
  <div>
    <Navbar />
    <div class="product-style-container" style="background-color: rgb(246, 245, 242);">
      <input type="text" v-model="searchQuery" placeholder="產品名稱" />

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

const searchQuery = ref('');

const homeProducts = ref([
  { image: new URL('@/assets/images/productstyletwo/印花輕便短褲.jpg', import.meta.url).href, name: '印花輕便短褲', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyletwo/防潑水休閒海灘短褲.jpg', import.meta.url).href, name: '防潑水休閒海灘短褲', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyletwo/漫威系列印花輕便短褲.jpg', import.meta.url).href, name: '漫威系列印花輕便短褲', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyletwo/超人力霸王印花輕便短褲.jpg', import.meta.url).href, name: '超人力霸王印花輕便短褲', link: '/Product/1', description: '' },
]);

const sportsProducts = ref([
  { image: new URL('@/assets/images/productstyletwo/運動排汗褲.jpg', import.meta.url).href, name: '運動排汗褲', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyletwo/特涼運動褲.jpg', import.meta.url).href, name: '特涼運動褲', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyletwo/運動束褲.jpg', import.meta.url).href, name: '運動束褲', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyletwo/清涼運動束褲.jpg', import.meta.url).href, name: '清涼運動束褲', link: '/Product/1', description: '' },
]);

const workProducts = ref([
  { image: new URL('@/assets/images/productstyletwo/舒適西裝褲.jpg', import.meta.url).href, name: '舒適西裝褲', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyletwo/彈性西裝格紋九分褲.jpg', import.meta.url).href, name: '彈性西裝格紋九分褲', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyletwo/彈性西裝九分褲.jpg', import.meta.url).href, name: '彈性西裝九分褲', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstyletwo/復古Regular Fit卡其褲.jpg', import.meta.url).href, name: '復古Regular Fit卡其褲', link: '/Product/1', description: '' },
]);

const filteredHomeProducts = computed(() => {
  return homeProducts.value.filter(product => 
    (product.name && product.name.includes(searchQuery.value)) || 
    (product.description && product.description.includes(searchQuery.value))
  );
});

const filteredSportsProducts = computed(() => {
  return sportsProducts.value.filter(product => 
    (product.name && product.name.includes(searchQuery.value)) || 
    (product.description && product.description.includes(searchQuery.value))
  );
});

const filteredWorkProducts = computed(() => {
  return workProducts.value.filter(product => 
    (product.name && product.name.includes(searchQuery.value)) || 
    (product.description && product.description.includes(searchQuery.value))
  );
});
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
