import { create } from 'zustand';
import apiClient from '../services/api';
import type { Product } from '../types';

interface ProductState {
  products: Product[];
  isLoading: boolean;
  error: string | null;
  fetchProducts: () => Promise<void>;
}

export const useProductStore = create<ProductState>((set) => ({
  products: [],
  isLoading: false,
  error: null,
  fetchProducts: async () => {
    set({ isLoading: true, error: null });
    try {
      // Busca apenas produtos ativos da API
      const response = await apiClient.get<Product[]>('/products');
      set({ products: response.data, isLoading: false });
    } catch (error) {
      const errorMessage = 'Falha ao buscar produtos. Verifique a conexão com a API.';
      set({ error: errorMessage, isLoading: false });
      console.error(errorMessage, error);
    }
  },
}));