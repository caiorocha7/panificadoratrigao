import React, { useEffect, useState } from 'react';
import apiClient from '../services/api';
import type { Product } from '../types';
import { Card } from '../components/ui/Card';
import { Spinner } from '../components/ui/Spinner';

const Dashboard = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await apiClient.get<Product[]>('/products');
        setProducts(response.data);
      } catch (err) {
        setError('Não foi possível carregar os produtos.');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  if (loading) return <Spinner />;
  if (error) return <p className="text-red-500">{error}</p>;

  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Dashboard</h1>
      <h2 className="text-2xl font-semibold mb-4">Produtos Ativos</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        {products.map((product) => (
          <Card key={product.id}>
            <h3 className="font-bold text-lg">{product.name}</h3>
            <p className="text-gray-600">{product.category.name}</p>
            <p className="mt-2 text-xl font-semibold text-green-600">
              R$ {product.price.toFixed(2)}
            </p>
          </Card>
        ))}
      </div>
    </div>
  );
};

export default Dashboard;