import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { Product, CartItem } from '../types';

interface CartState {
  items: CartItem[];
  addItem: (product: Product) => void;
  removeItem: (productId: number) => void;
  updateQuantity: (productId: number, quantity: number) => void;
  clearCart: () => void;
  getTotal: () => number;
}

export const useCartStore = create<CartState>()(
  persist(
    (set, get) => ({
      items: [],
      addItem: (product) => {
        const items = get().items;
        const existingItem = items.find((item) => item.productId === product.id);

        if (existingItem) {
          // Se o item já existe, apenas incrementa a quantidade
          const updatedItems = items.map((item) =>
            item.productId === product.id ? { ...item, quantity: item.quantity + 1 } : item
          );
          set({ items: updatedItems });
        } else {
          // Se é um item novo, adiciona ao carrinho
          set({
            items: [...items, {
              productId: product.id,
              name: product.name,
              price: parseFloat(product.price), // Converte o preço para número
              quantity: 1
            }]
          });
        }
      },
      removeItem: (productId) => {
        set({ items: get().items.filter((item) => item.productId !== productId) });
      },
      updateQuantity: (productId, quantity) => {
        if (quantity <= 0) {
          get().removeItem(productId);
        } else {
          set({
            items: get().items.map(item => 
              item.productId === productId ? { ...item, quantity } : item
            ),
          });
        }
      },
      clearCart: () => set({ items: [] }),
      getTotal: () => {
        return get().items.reduce((total, item) => total + item.price * item.quantity, 0);
      },
    }),
    {
      name: 'trigao-cart-storage', // Chave de persistência no localStorage
    }
  )
);