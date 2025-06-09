import React from 'react';
import { NavLink, useNavigate } from 'react-router-dom';
import { useAuthStore } from '../../stores/authStore';
import { useCartStore } from '../../stores/cartStore';

const Navbar = () => {
  const { clearAuth } = useAuthStore();
  const cartItemCount = useCartStore((state) => state.items.length);
  const navigate = useNavigate();

  const handleLogout = () => {
    clearAuth();
    navigate('/login');
  };
  
  const navLinkClass = ({ isActive }: { isActive: boolean }) =>
    `px-3 py-2 rounded-md text-sm font-medium ${isActive ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'}`;


  return (
    <nav className="bg-gray-800 text-white">
      <div className="container mx-auto px-4">
        <div className="relative flex items-center justify-between h-16">
          <div className="flex items-center">
            <NavLink to="/" className="font-bold text-xl">Trigão</NavLink>
            <div className="ml-10 flex items-baseline space-x-4">
              <NavLink to="/" className={navLinkClass}>Produtos</NavLink>
              <NavLink to="/checkout" className={navLinkClass}>
                Pedido ({cartItemCount})
              </NavLink>
            </div>
          </div>
          <button onClick={handleLogout} className="bg-red-500 py-2 px-4 rounded text-sm font-medium hover:bg-red-600">
            Sair
          </button>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;