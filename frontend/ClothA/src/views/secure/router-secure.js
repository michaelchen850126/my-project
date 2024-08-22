import Login from "./Login.vue"             //登入
import Register from "./Register.vue"       //註冊
import ForgotPwd from "./ForgotPwd.vue"     //忘記密碼
import ModifyUser from "./ModifyUser.vue"   //修改會員個人資料

export default [
    { name: "secure-login-link", path: "/secure/login", component: Login , meta: { showNavbar: true } },
    { name: "secure-Register-link", path: "/secure/Register", component: Register ,  meta: { showNavbar: true } },
    { name: "secure-ForgotPwd-link", path: "/secure/ForgotPwd", component: ForgotPwd,  meta: { showNavbar: true } },
    { name: "secure-ModifyUser-link", path: "/secure/ModifyUser", component: ModifyUser ,  meta: { showNavbar: true } },

]