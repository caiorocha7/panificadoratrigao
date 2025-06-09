import React, { useState } from 'react';
import { useCartStore } from '../stores/cartStore';
import apiClient from '../services/api';
import { useNavigate } from 'react-router-dom';

const Checkout = () => {
  const { items, updateQuantity, clearCart, getTotal } = useCartStore();
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleCreateOrder = async () => {
    setLoading(true);
    // Formata os dados para o formato que a API Rails espera (com `accepts_nested_attributes_for`)
    const orderData = {
      order: {
        payment_type: 'Dinheiro', // Exemplo estático, pode ser um select
        total_amount: getTotal(),
        status: 'pending',
        order_items_attributes: items.map(item => ({
          product_id: item.productId,
          quantity: item.quantity,
          unit_price: item.price,
        })),
      },
    };

    try {
      await apiClient.post('/orders', orderData);
      alert('Pedido criado com sucesso!');
      clearCart();
      navigate('/'); // Redireciona para a página inicial após o sucesso
    } catch (error) {
      alert('Falha ao criar o pedido. Verifique o console para mais detalhes.');
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-3xl font-bold mb-6 text-gray-800">Finalizar Pedido</h1>
      <div className="bg-white p-6 rounded-lg shadow-md max-w-2xl mx-auto">
        {items.length === 0 ? (
          <p className="text-center text-gray-600">Seu carrinho está vazio.</p>
        ) : (
          <div className="space-y-4">
            {items.map((item) => (
              <div key={item.productId} className="flex justify-between items-center border-b pb-3">
                <div className="flex-grow">
                  <p className="font-semibold">{item.name}</p>
                  <p className="text-sm text-gray-600">R$ {item.price.toFixed(2)}</p>
                </div>
                <div className="flex items-center">
                  <input
                    type="number"
                    min="1"
                    value={item.quantity}
                    onChange={(e) => updateQuantity(item.productId, parseInt(e.target.value))}
                    className="w-16 text-center border rounded mx-4"
                  />
                  <p className="w-24 text-right font-medium">R$ {(item.price * item.quantity).toFixed(2)}</p>
                </div>
              </div>
            ))}
          </div>
        )}
        {items.length > 0 && (
          <div className="mt-6 text-right">
            <p className="text-2xl font-bold">Total: R$ {getTotal().toFixed(2)}</p>
            <button
              onClick={handleCreateOrder}
              disabled={loading}
              className="mt-4 bg-green-500 text-white py-2 px-6 rounded-lg font-semibold hover:bg-green-600 disabled:bg-gray-400 transition-colors"
            >
              {loading ? 'Enviando...' : 'Finalizar Pedido'}
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default Checkout;