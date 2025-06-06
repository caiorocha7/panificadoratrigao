Rails.application.routes.draw do
  # Escopo de API para futuras versões (ex: /api/v1)
  scope '/api/v1' do
    devise_for :users,
      path: '',
      path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      },
      defaults: { format: :json }
  end

  # Adicione aqui as outras rotas da sua API
  # namespace :api do
  #   namespace :v1 do
  #     resources :products
  #     resources :orders
  #   end
  # end
end