<template>
  <navbar></navbar>
  <div id="home" class="d-flex justify-content-center align-items-center vh-100">
    <div class="animation-container" v-if="!animationCompleted">
      <div class="letter" id="letter-j">J</div>
      <div class="letter" id="letter-s">S</div>
      <div class="letter" id="letter-t">T</div>
    </div>
    <!-- 轮播图 -->
    <div v-if="animationCompleted" class="swiper-container">
      <swiper-container
        :slides-per-view="1"
        direction="vertical"
        space-between="10"
        pagination="{ clickable: true }"
        navigation
        autoplay="{ delay: 2000 }"
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
          <router-link :to="slide.link" v-else-if="slide.type === 'video'" class="video-container">
            <video autoplay loop muted class="carousel-video">
              <source :src="slide.video" type="video/mp4" />
              Your browser does not support the video tag.
            </video>
            <div class="product-info">
              <h2>{{ slide.info.title }}</h2>
              <p>{{ slide.info.subtitle }}</p>
              <span>{{ slide.info.price }}</span>
            </div>
          </router-link>
        </swiper-slide>
      </swiper-container>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import 'swiper/swiper-bundle.min.css'; // 导入 Swiper 的样式
import { RouterLink } from 'vue-router';
import { Swiper, SwiperSlide } from 'swiper/vue';
import Navbar from './Navbar.vue';

// Adjust the paths here
const slides = [
  { type: 'video', video: new URL('../assets/videos/4919748-hd_2048_1080_60fps.mp4', import.meta.url).href, info: { title: '品牌聯名', subtitle: '特別活動', price: '點我搶購！' }, link: '/ProductListTwo' },
  { type: 'image', image: new URL('../assets/images/producthome/首頁1.jpg', import.meta.url).href, link: '/ProductListOne', info: { title: '男裝', subtitle: '夏季特賣', price: '特價399起' } },
  { type: 'image', image: new URL('../assets/images/producthome/首頁2.jpg', import.meta.url).href, link: '/ProductListTwo', info: { title: '女裝', subtitle: '夏季特賣', price: '特價399起' } },
  { type: 'image', image: new URL('../assets/images/producthome/首頁3.jpg', import.meta.url).href, link: '/ProductListThree', info: { title: '童裝', subtitle: '夏季特賣', price: '特價399起' } },
];

const animationCompleted = ref(false);

onMounted(() => {
  startAnimation();
});

function startAnimation() {
  const letterJ = document.getElementById('letter-j');
  const letterS = document.getElementById('letter-s');
  const letterT = document.getElementById('letter-t');

  letterJ.classList.add('animate-j');
  letterS.classList.add('animate-s');
  letterT.classList.add('animate-t');

  // 动画完成后显示轮播图
  setTimeout(() => {
    animationCompleted.value = true;
  }, 2500); // 根据实际动画时间设置
}
</script>

<style src="/src/assets/Css/ProductHome.css" scoped></style>
