import { createRouter, createWebHistory } from 'vue-router'
import Navbar from '@/components/Navbar.vue'
import ProfilePage from '../views/ProfilePage.vue'

const routes = [
    { path:"/", component: Navbar},
    { path:"/profile", component: ProfilePage},
    { path:"/home", component: Navbar},
  ];



const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router
