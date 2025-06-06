class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Cadastro realizado com sucesso.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        status: { message: "Não foi possível criar o usuário.", errors: resource.errors.full_messages },
        status: :unprocessable_entity
      }
    end
  end
end