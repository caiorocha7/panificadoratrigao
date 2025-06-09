import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Login from './pages/Login';
import ProductList from './pages/ProductList';
import Checkout from './pages/Checkout';
import ProtectedRoute from './components/ProtectedRoute';
import MainLayout from './components/layout/MainLayout';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<Login />} />

        <Route element={<ProtectedRoute />}>
          <Route element={<MainLayout />}>
            <Route path="/" element={<ProductList />} />
            <Route path="/checkout" element={<Checkout />} />
          </Route>
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;