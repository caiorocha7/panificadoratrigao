import React, { useEffect } from 'react';
import { useProductStore } from '../stores/productStore';
import { useCartStore } from '../stores/cartStore';
import type { Product } from '../types';

// Componente para um único cartão de produto
const ProductCard: React.FC<{ product: Product; onAddToCart: (product: Product) => void }> = ({ product, onAddToCart }) => (
  <div className="border rounded-lg p-4 shadow-sm flex flex-col justify-between bg-white">
    <div>
      <h2 className="text-lg font-semibold text-gray-800">{product.name}</h2>
      <p className="text-sm text-gray-500">{product.category.name}</p>
      <p className="text-xl font-bold text-green-600 mt-2">R$ {parseFloat(product.price).toFixed(2)}</p>
    </div>
    <button
      onClick={() => onAddToCart(product)}
      className="mt-4 w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-600 transition-colors"
    >
      Adicionar ao Pedido
    </button>
  </div>
);

const ProductList = () => {
  const { products, isLoading, error, fetchProducts } = useProductStore();
  const addItem = useCartStore((state) => state.addItem);

  useEffect(() => {
    // Busca os produtos ao montar o componente
    fetchProducts();
  }, [fetchProducts]);

  if (isLoading) return <div className="text-center p-10">Carregando produtos...</div>;
  if (error) return <div className="text-center p-10 text-red-500 font-semibold">{error}</div>;

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-3xl font-bold mb-6 text-gray-800">Produtos Disponíveis</h1>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-6">
        {products.map((product) => (
          <ProductCard key={product.id} product={product} onAddToCart={addItem} />
        ))}
      </div>
    </div>
  );
};

export default ProductList;