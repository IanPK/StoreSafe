// src/main.js
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store'
import WebFont from 'webfontloader';
import 'bootstrap/dist/css/bootstrap.min.css';
import './assets/styles.css';

// console.log('API URL:', process.env.VUE_APP_API_URL);

WebFont.load({
  google: {
    families: ['Rajdhani:300,400,500,600,700']
  }
});

createApp(App)
  .use(store)
  .use(router)
  .mount('#app');
