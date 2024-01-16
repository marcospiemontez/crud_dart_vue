// router/index.ts
import type { RouteRecordRaw } from 'vue-router';
import { createRouter, createWebHistory } from 'vue-router';
import Home from '@/views/Home.vue';
import Dashboard from '@/views/Dashboard.vue';
import Login from '@/components/auth/Login.vue';
import CreateUser from '@/components/auth/CreateUser.vue';

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    component: Home,
  },
  {
    path: '/dashboard',
    component: Dashboard,
    meta: { requiresAuth: true }, // Exemplo de meta para autenticação de rotas
  },
  {
    path: '/login',
    component: Login,
  },
  {
    path: '/create-user',
    component: CreateUser,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
