import { createRouter, createWebHistory } from 'vue-router'
import NotFound from '@/views/NotFound.vue';
import ProductHome from '@/views/ProductHome.vue';
import routerSecure from '@/views/secure/router-secure';
import routerProducts from '@/views/products/router-products';
import routerComments from '@/views/comments/router-comments';
import routerStyles from '@/views/productstyles/router-styles';
import routerProductlist from '@/views/productlists/router-productlist';
import routerCarts from '@/views/carts/router-carts';

const routes = [
    { name: "Product-Home", path: "/", component: ProductHome, meta: { showNavbar: false } },
    { name: "notfound-link", path: "/:pathMatch(.*)*", component: NotFound, meta: { showNavbar: true } },
    ...routerComments,
    ...routerProducts,
    ...routerSecure,
    ...routerStyles,
    ...routerProductlist,
    ...routerCarts
];

const router = createRouter({
    routes: routes,
    history: createWebHistory(),
});


export default router
