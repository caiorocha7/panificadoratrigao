Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users,
        path: '',
        path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          registration: 'signup'
        },
        controllers: {
          # CAMINHO CORRIGIDO:
          # Aponta para app/controllers/users/sessions_controller.rb
          sessions: 'users/sessions',
          # Aponta para app/controllers/users/registrations_controller.rb
          registrations: 'users/registrations'
        }

      # Suas rotas de CRUD (que usam Api::V1::UsersController) continuam aqui e estão corretas.
      resources :users, except: [:new, :edit]
      resources :products, except: [:new, :edit]
      resources :orders, except: [:new, :edit]
    end
  end
end