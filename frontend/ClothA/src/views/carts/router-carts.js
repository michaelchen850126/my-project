import Cart from "./Cart.vue";
import Check from "./Check.vue";
import OrderDetail from "./OrderDetail.vue";
import Complete from "./Complete.vue";
import OrderList from "./OrderList.vue";
import GoList from "./GoList.vue";
import CouponList from "./CouponList.vue";



export default [
    { name: "pages-cart-link", path: "/carts/cart", component: Cart , meta: { showNavbar: true } },    //STEP1.購物車頁面
    { name: "pages-check-link", path: "/carts/check", component: Check  , meta: { showNavbar: true }},    //STEP2.輸入結帳資訊頁面
    { name: "pages-orderDetail-link", path: "/carts/orderDetail", component: OrderDetail , meta: { showNavbar: true }},    //STEP3.結帳頁面
    { name: "pages-complete-link", path: "/carts/complete", component: Complete , meta: { showNavbar: true }},    //STEP4.訂購成功頁面
    { name: "pages-OrderList-link", path: "/carts/orderList", component: OrderList  , meta: { showNavbar: true }},//查詢歷史訂單
    { name: "pages-goList-link", path: "/carts/goList", component: GoList  , meta: { showNavbar: true }},//查詢歷史訂單
    { name: "pages-couponList-link", path: "/carts/couponList", component: CouponList  , meta: { showNavbar: true }}
]