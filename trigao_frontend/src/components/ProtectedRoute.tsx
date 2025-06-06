import React from 'react';
import { Navigate, Outlet } from 'react-router-dom';
import { useAuthStore } from '../stores/authStore';

const ProtectedRoute = () => {
  // `useAuthStore` é um hook, então ele re-renderiza o componente quando o estado muda.
  const isAuthenticated = useAuthStore((state) => state.isAuthenticated);

  // Se estiver autenticado, permite o acesso. Senão, redireciona.
  return isAuthenticated ? <Outlet /> : <Navigate to="/login" replace />;
};

export default ProtectedRoute;