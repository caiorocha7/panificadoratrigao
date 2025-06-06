class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Login realizado com sucesso.' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      render json: { status: 200, message: "Logout realizado com sucesso." }, status: :ok
    else
      render json: { status: 401, message: "Não foi possível encontrar uma sessão ativa." }, status: :unauthorized
    end
  end
end