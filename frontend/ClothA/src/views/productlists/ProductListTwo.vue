<template>
  <div class="category-page background">
    <!-- Swiper 轮播图 -->
    <div v-if="animationCompleted" class="swiper-container">
      <swiper-container
        :slides-per-view="1"
        direction="vertical"
        space-between="10"
        pagination="{ clickable: true }"
        navigation
        class="swiper-container"
      >
        <swiper-slide v-for="(slide, index) in slides" :key="index" style="height: auto; padding: 0px;">
          <router-link :to="slide.link" v-if="slide.type === 'image'">
            <div class="image-container">
              <img :src="slide.image" alt="轮播图" class="carousel-image" />
              <div class="product-info">
                <h2>{{ slide.info.title }}</h2>
                <p>{{ slide.info.subtitle }}</p>
                <span>{{ slide.info.price }}</span>
              </div>
            </div>
          </router-link>
        </swiper-slide>
      </swiper-container>
    </div>

    <!-- 横幅图片 -->

    <h2 class="category-title">精選商品分類</h2>
    <div class="cardone">
      <div class="row justify-content-center">
        <div v-for="(category, index) in categories" :key="category.name" class="col-md-4 mb-4">
          <router-link :to="category.link" class="card-link">
            <div class="card" style="border: none;">
              <div class="card-body">
                <img class="category-image" :src="category.imgSrc" alt="">
                <h3 class="card-title">{{ category.name }}</h3>
              </div>
            </div>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

// 定義響應式變量
const animationCompleted = ref(true);

// 定義幻燈片數據
const slides = [
  {
    type: 'image',
    image: new URL('@/assets/images/productlist/女裝-banner.jpg', import.meta.url).href,
    link: "/ProductStyleOne",
    info: {
      title: 'WOMEN',
    }
  },
  // 更多的輪播圖數據
];

// 定義分類數據
const categories = [
  { name: '上衣', link: "/ProductStyleOne", imgSrc: new URL('@/assets/images/productlist/女-上衣.jpg', import.meta.url).href },
  { name: '下身', link: "/ProductStyleTwo", imgSrc: new URL('@/assets/images/productlist/女-下身.jpg', import.meta.url).href },
  { name: '外套', link: "/ProductStyleThree", imgSrc: new URL('@/assets/images/productlist/女-外套.jpg', import.meta.url).href },
  { name: '牛仔褲', link: "/ProductStyleFour", imgSrc: new URL('@/assets/images/productlist/女-牛仔褲.jpg', import.meta.url).href },
  { name: '聯名T', link: "/ProductStyleFive", imgSrc: new URL('@/assets/images/productlist/男-聯名T.jpg', import.meta.url).href }, // 修正為正確的圖片路徑
];
</script>


<style src="/src/assets/Css/ProductList.css"></style>
