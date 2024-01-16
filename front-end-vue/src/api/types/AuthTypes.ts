// src/api/types/AuthTypes.ts
export interface LoginCredentials {
  username: string;
  password: string;
}

export interface UserData {
  username: string;
  password: string;
}

export interface ApiResponse {
  data: any;
}
