import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Register from '../views/Register.vue';
import Login from '../views/Login.vue';
import StartAssessment from '../views/StartAssessment.vue';
import Assessment from '../views/Assessment.vue';
import Dashboard from '../views/Dashboard.vue';
import ResultsView from '../views/ResultsView.vue';
import AdminDashboard from '../views/AdminDashboard.vue';
import store from '../store';

const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/register', name: 'Register', component: Register },
  { path: '/login', name: 'Login', component: Login },
  { 
    path: '/dashboard', 
    name: 'Dashboard', 
    component: Dashboard,
    meta: { requiresAuth: true }
  },
  { 
    path: '/start-assessment', 
    name: 'StartAssessment', 
    component: StartAssessment,
    meta: { requiresAuth: true }
  },
  { 
    path: '/assessment/:id', 
    name: 'Assessment', 
    component: Assessment,
    meta: { requiresAuth: true }
  },
  { 
    path: '/results/:id', 
    name: 'Results', 
    component: ResultsView, 
    props: true,
    meta: { requiresAuth: true }
  },
  {
    path: '/admin',
    name: 'AdminDashboard',
    component: AdminDashboard,
    meta: { requiresAuth: true, requiresAdmin: true }
  },
];

const router = createRouter({
  history: createWebHistory('/'),
  routes,
});


router.beforeEach((to, from, next) => {
  const requiresAuth = to.matched.some(record => record.meta.requiresAuth);
  const requiresAdmin = to.matched.some(record => record.meta.requiresAdmin);
  const user = JSON.parse(localStorage.getItem('user'));
  const isLoggedIn = !!user;
  const isAdmin = user && user.isAdmin;

  if (requiresAuth && !isLoggedIn) {
    next('/login');
  } else if (requiresAdmin && !isAdmin) {
    next('/dashboard');
  } else {
    next();
  }
});



export default router;