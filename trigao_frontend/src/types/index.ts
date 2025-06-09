// Contrato para o usuário autenticado
export interface User {
  id: number;
  email: string;
  role: 'padrao' | 'master';
}

// Contrato para um produto, espelhando o ProductSerializer do Rails
export interface Product {
  id: number;
  code: string;
  name: string;
  price: string; // A API retorna decimal como string, faremos o parse no cliente
  unit: string;
  status: 'active' | 'inactive';
  category: {
    id: number;
    name: string;
  }
}

// Contrato para um item dentro do carrinho de compras
export interface CartItem {
  productId: number;
  name: string;
  quantity: number;
  price: number; // No carrinho, o preço é armazenado como número
}
