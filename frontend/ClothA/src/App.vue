<template>
  <div>
    <Information></Information>
    <Navbar v-show="shouldShowNavbar"  style="display: flex;"/>
    <router-view @animation-completed="handleAnimationCompleted"></router-view>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import { useRoute } from 'vue-router';
import Navbar from './views/Navbar.vue';
import Information from './views/Information.vue';

const route = useRoute();
const animationCompleted = ref(false);

const shouldShowNavbar = computed(() => {
  return animationCompleted.value || route.meta.showNavbar;
});

function handleAnimationCompleted() {
  animationCompleted.value = true;
}
</script>

<style>
/* 添加样式如果需要 */
</style>