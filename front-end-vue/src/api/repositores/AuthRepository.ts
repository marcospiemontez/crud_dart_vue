// api/repositories/AuthRepository.ts
import apiService from '../services/ApiService';
import type { LoginCredentials, UserData, ApiResponse } from '@/api/types/AuthTypes';

class AuthRepository {
  async login(credentials: LoginCredentials): Promise<any> {
    try {
      const response: ApiResponse = await apiService.post('/login', credentials);
      return response.data;
    } catch (error) {
      throw new Error('Failed to log in');
    }
  }

  async createUser(userData: UserData): Promise<any> {
    try {
      const response: ApiResponse = await apiService.post('/create-user', userData);
      return response.data;
    } catch (error) {
      throw new Error('Failed to create user');
    }
  }
}

export default new AuthRepository();
