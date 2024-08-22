
import ProductListOne from "./ProductListOne.vue"
import ProductListTwo from "./ProductListTwo.vue"
import ProductListThree from "./ProductListThree.vue"


export default [
    { name: "List-ProductOne", path: "/ProductListOne", component: ProductListOne, meta: { showNavbar: true } },
    { name: "List-ProductTwo", path: "/ProductListTwo", component: ProductListTwo, meta: { showNavbar: true } },
    { name: "List-ProductThree", path: "/ProductListThree", component: ProductListThree, meta: { showNavbar: true } },
]