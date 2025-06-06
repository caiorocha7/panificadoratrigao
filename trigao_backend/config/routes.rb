# config/routes.rb

Rails.application.routes.draw do
  # Define o namespace principal para a API, que ajuda a organizar o código
  # e as URLs. Todas as rotas aqui dentro serão prefixadas com /api/
  namespace :api do
    # Define o namespace da versão 1. Todas as rotas aqui dentro
    # serão prefixadas com /api/v1/ e esperarão controllers
    # no módulo Api::V1.
    namespace :v1 do
      # Rotas de Autenticação do Devise
      devise_for :users,
        path: '',
        path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          registration: 'signup'
        },
        controllers: {
          sessions: 'api/v1/users/sessions',
          registrations: 'api/v1/users/registrations'
        }

      # Rotas de Recursos da API
      # Expõe os endpoints RESTful para produtos e pedidos.
      resources :products, except: [:new, :edit]
      resources :orders, except: [:new, :edit]
    end
  end
end