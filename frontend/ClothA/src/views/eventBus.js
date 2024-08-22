import { ref } from 'vue';

const cartCount = ref(0);

export const updateCartCount = (count) => {
  cartCount.value += count;
};

export default cartCount;
