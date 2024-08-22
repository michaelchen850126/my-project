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
  { image: new URL('@/assets/images/productstylethree/七龍珠Z長袖印花T恤.jpg', import.meta.url).href, name: '七龍珠Z長袖印花T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstylethree/山景刷毛印花圓領衫.jpg', import.meta.url).href, name: '山景刷毛印花圓領衫', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstylethree/文字印花T恤.jpg', import.meta.url).href, name: '漫威文字印花T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstylethree/可口可樂印花T恤.jpg', import.meta.url).href, name: '可口可樂印花T恤', link: '/Product/1', description: '' },
]);

const sportsProducts = ref([
  { image: new URL('@/assets/images/productstylethree/史努比系列口袋印花T恤.jpg', import.meta.url).href, name: '史努比系列口袋印花T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstylethree/史努比系列毛圈印花圓領衫.jpg', import.meta.url).href, name: '史努比系列毛圈印花圓領衫', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstylethree/迪士尼系列口袋印花T恤.jpg', import.meta.url).href, name: '迪士尼系列口袋印花T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstylethree/迪士尼系列刷毛電繡圓領衫.jpg', import.meta.url).href, name: '迪士尼系列刷毛電繡圓領衫', link: '/Product/1', description: '' },
]);

const workProducts = ref([
  { image: new URL('@/assets/images/productstylethree/航海王印花T恤.jpg', import.meta.url).href, name: '航海王印花T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstylethree/蠟筆小新刷毛印花圓領衫.jpg', import.meta.url).href, name: '蠟筆小新刷毛印花圓領衫', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstylethree/Jurassic World印花T恤.jpg', import.meta.url).href, name: 'Jurassic World印花T恤', link: '/Product/1', description: '' },
  { image: new URL('@/assets/images/productstylethree/STAR WARS系列長袖印花T恤.jpg', import.meta.url).href, name: '復STAR WARS系列長袖印花T恤', link: '/Product/1', description: '' },
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
