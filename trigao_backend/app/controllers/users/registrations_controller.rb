# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  # Pula a verificação de autenticação global.
  skip_before_action :authenticate_user!, only: [:create]

  respond_to :json

  # POST /api/v1/signup
  def create
    # Usamos nosso próprio `user_params` em vez do `sign_up_params` do Devise.
    build_resource(user_params)

    resource.save
    if resource.persisted?
      # CORREÇÃO: A resposta JSON não precisa acessar [:data][:attributes].
      # O serializer já retorna o hash correto.
      render json: {
        status: { code: 201, message: 'Usuário criado com sucesso.' },
        data: UserSerializer.new(resource).serializable_hash
      }, status: :created
    else
      render json: {
        status: {
          message: "Não foi possível criar o usuário.",
          errors: resource.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end

  private

  # *** A CORREÇÃO DEFINITIVA ESTÁ AQUI ***
  # Criamos nosso próprio método para lidar com os Strong Parameters,
  # ignorando completamente o `devise_parameter_sanitizer`.
  # Isso nos dá controle total e explícito.
  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end