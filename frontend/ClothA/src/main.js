import App from './App.vue';
import router from './router/router';
import ElementPlus from 'element-plus';
import FontAwesomeIcon from '@/plugins/font-awesome.js'
import { createApp } from 'vue';
import { library } from '@fortawesome/fontawesome-svg-core';
import { fas } from '@fortawesome/free-solid-svg-icons';
import { faImages } from '@fortawesome/free-solid-svg-icons'; // 使用 solid icons
import { faImage, faPaperPlane } from '@fortawesome/free-regular-svg-icons';
import 'bootstrap/dist/css/bootstrap.min.css'; // 引入 Bootstrap CSS
import 'bootstrap/dist/js/bootstrap.bundle.min.js'; // 引入r Bootstrap JS
import 'element-plus/dist/index.css';
import '@/assets/Css/navbar.css'; // 确保这里的路径是正确的




library.add(fas);
library.add(faImages);
library.add(faImage, faPaperPlane);

const app = createApp(App);
app.component('font-awesome-icon', FontAwesomeIcon);
app.use(router);
app.mount('#app');
app.use(ElementPlus);


















