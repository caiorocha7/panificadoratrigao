// Define o contrato de dados para o usuário logado
export interface User {
  id: number;
  email: string;
  role: 'padrao' | 'master';
}

// Define o contrato para a resposta da API de Autenticação
export interface AuthResponse {
  data: {
    attributes: User;
  }
}

// Define o contrato para um Produto
export interface Product {
  id: number;
  code: string;
  name: string;
  price: number;
  status: 'active' | 'inactive';
  category: {
    id: number;
    name: string;
  }
}