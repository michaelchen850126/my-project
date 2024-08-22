<template>
  <div class="background">
    <div class="content" v-if="product">
      <div class="gallery-container">
        <div class="gallery" >
          <div class="thumbnails" >
            <img v-for="(image, index) in images" :key="index" :src="image" @click="setMainImage(image)">
          </div>
          <div class="main-image">
            <img :src="mainImage">
          </div>
        </div>
      </div>
      <div  style="max-width: 600px; padding-right: 10%; padding-top: 5%;">
        <h2>{{ product.name }}</h2>
        <h4>{{ product.style }}</h4>
        <div class="product-price">
          <p class="discounted-price" style="color: red;">特價：${{ product.discount_price }}</p>
          <p class="original-price">原價：${{ product.price }}</p>
        </div>
        <div class="product-color">
          <p>顏色</p>
          <div v-for="color in colors" :key="color" class="color-circle" :style="{ backgroundColor: color }" :class="{ selected: selectedColor === color }" @click="changeProduct(color, 'color')"></div>
        </div>
        <div class="product-size">
          <p>尺寸</p>
          <div v-for="size in sizes" :key="size" class="size-rectangle" :class="{ selected: selectedSize === size }" @click="changeProduct(size, 'size')">{{ size }}</div>
        </div>
        <div class="product-quantity">
          <button @click="decrementQuantity">-</button>
          <span class="quantity-number">{{ quantity }}</span>
          <button @click="incrementQuantity">+</button>
        </div>
        <button class="add-to-cart" @click="addToCart">加入購物車</button>
      </div>
    </div>
    <div class="product-description" v-if="product">
      <h3>商品描述</h3>
      <p>{{ product.description }}</p>
      <CommentOne></CommentOne>
    </div>
  </div>
</template>

<script>
import axiosapi from '@/plugins/axios';
import Swal from 'sweetalert2';
import CommentOne from '../comments/CommentOne.vue';
import cartCount, { updateCartCount } from '@/views/eventBus';

export default {
  components: {
    CommentOne
  },
  data() {
    return {
      product: null,
      images: [],
      mainImage: '',
      colors: ['#000', '#fff', '#0000FF'], 
      sizes: ['S', 'M', 'L'],
      quantity: 1,
      selectedSize: '',
      selectedColor: ''
    };
  },
  methods: {
    fetchProduct(productId) {
      axiosapi.get(`/products/${productId}`)
        .then(response => {
          this.product = response.data;
          this.images = [
            'data:image/jpeg;base64,' + this.product.img,
            'data:image/jpeg;base64,' + this.product.img2,
            'data:image/jpeg;base64,' + this.product.img3,
            'data:image/jpeg;base64,' + this.product.img4,
          ];
          this.setMainImageByColor();
          sessionStorage.setItem('productId', productId);
        })
        .catch(error => {
          console.error('Error fetching product:', error);
        });
    },
    setMainImage(image) {
      this.mainImage = image;
    },
    setMainImageByColor() {
      if (this.selectedColor === '#000') {
        this.mainImage = this.images[1];
      } else if (this.selectedColor === '#fff') {
        this.mainImage = this.images[2];
      } else if (this.selectedColor === '#0000FF') {
        this.mainImage = this.images[3];
      } else {
        this.mainImage = this.images[0];
      }
    },
    changeProduct(value, type) {
      if (type === 'color') {
        this.selectedColor = value;
        this.selectedSize = 'S'; 
        this.updateProduct();
      } else if (type === 'size') {
        this.selectedSize = value;
        this.updateProduct();
      }
      this.setMainImageByColor();
    },
    updateProduct() {
      let productId = 1; 
      if (this.selectedColor === '#000') { 
        if (this.selectedSize === 'S') {
          productId = 1;
        } else if (this.selectedSize === 'M') {
          productId = 2;
        } else if (this.selectedSize === 'L') {
          productId = 3;
        }
      } else if (this.selectedColor === '#fff') { 
        if (this.selectedSize === 'S') {
          productId = 4;
        } else if (this.selectedSize === 'M') {
          productId = 5;
        } else if (this.selectedSize === 'L') {
          productId = 6;
        }
      } else if (this.selectedColor === '#0000FF') { 
        if (this.selectedSize === 'S') {
          productId = 7;
        } else if (this.selectedSize === 'M') {
          productId = 8;
        } else if (this.selectedSize === 'L') {
          productId = 9;
        }
      }

      sessionStorage.setItem('productId', productId);

      this.fetchProduct(productId);
    },
    decrementQuantity() {
      if (this.quantity > 1) {
        this.quantity--;
      }
    },
    incrementQuantity() {
      this.quantity++;
    },
    addToCart() {
      const productId = sessionStorage.getItem('productId');
      const usersId = sessionStorage.getItem('userId'); 

      console.log('ProductId:', productId); 
      console.log('UsersId:', usersId); 

      if (!productId) {
        Swal.fire({
          icon: 'error',
          title: '錯誤',
          text: '請選擇商品樣式',
        });
        return;
      }

      if (!usersId) {
        Swal.fire({
          icon: 'error',
          title: '錯誤',
          text: '請先登入',
          confirmButtonText: '前往登入'
        }).then((result) => {
          if (result.isConfirmed) {
            window.location.href = '/secure/login';
          }
        });
        return;
      }

      const cartItem = {
        productId,
        usersId,
        quantity: this.quantity,
        status: 0,
        discountPrice: this.product.discount_price // 添加折扣价格字段
      };

      axiosapi.post('/api/carts/add', cartItem)
        .then(response => {
          Swal.fire({
            icon: 'success',
            title: '新增成功',
          });
          updateCartCount(this.quantity); 
          console.log('Added to cart:', response.data);
        })
        .catch(error => {
          console.error('Error adding to cart:', error);
        });
    },
  },
  mounted() {
    this.fetchProduct(1); 
  },
};
</script>

<style scoped>
@import "@/assets/css/productone.css";

/* 新增選中顏色圈圈的樣式 */
.color-circle.selected {
  border: 2px solid #9f5000;
}
</style>
