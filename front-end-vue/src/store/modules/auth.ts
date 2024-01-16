// store/modules/auth.ts
import { defineStore } from 'pinia';
import AuthRepository from '@/api/repositores/AuthRepository';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null,
    // Outros estados relacionados à autenticação
  }),
  actions: {
    async loginUser(credentials: { username: string; password: string }) {
      try {
        const user = await AuthRepository.login(credentials);
        this.user = user;
        // Lógica adicional de autenticação, como armazenar o token no estado
      } catch (error) {
        console.error('Failed to log in:', error);
      }
    },

    async createUser(userData: { username: string; password: string }) {
      try {
        const user = await AuthRepository.createUser(userData);
        // Lógica adicional de criação de usuário, se necessário
      } catch (error) {
        console.error('Failed to create user:', error);
      }
    },
  },
});
