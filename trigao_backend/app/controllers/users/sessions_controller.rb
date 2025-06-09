# Este controller customiza o comportamento padrão do Devise para sessões (login/logout),
# adaptando-o para funcionar perfeitamente com uma API JSON stateless.
class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: [:create]
  # Garante que este controller responderá apenas a requisições JSON.
  respond_to :json

  private

  # Este método é um hook do Devise, chamado automaticamente após um login bem-sucedido.
  # Nós o sobrescrevemos para construir uma resposta JSON customizada.
  #
  # @param resource [User] - O objeto do usuário que acabou de ser autenticado.
  # @param _opts [Hash] - Opções adicionais (não utilizadas aqui).
  #
  # Nota: O token JWT é adicionado automaticamente ao cabeçalho (header) 'Authorization'
  # pela gem 'devise-jwt'. Nossa única responsabilidade aqui é formatar o corpo (body) da resposta.
  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Login realizado com sucesso.' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  # Este método é outro hook do Devise, chamado após um logout (destroy) bem-sucedido.
  # Em uma API stateless, o "logout" do lado do servidor invalida o token.
  # Esta resposta serve como uma confirmação para o cliente.
  def respond_to_on_destroy
    # Verificamos se a requisição de logout continha um token de autorização.
    # Se sim, significa que o processo de logout do 'devise-jwt' provavelmente foi bem-sucedido.
    if request.headers['Authorization'].present?
      render json: {
        status: 200,
        message: "Logout realizado com sucesso."
      }, status: :ok
    else
      # Se não havia token, informamos que não havia uma sessão ativa para encerrar.
      render json: {
        status: 401,
        message: "Não foi possível encontrar uma sessão ativa."
      }, status: :unauthorized
    end
  end
end