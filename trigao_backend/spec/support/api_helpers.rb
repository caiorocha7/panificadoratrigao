# spec/support/api_helpers.rb
module ApiHelpers
  # Gera um cabeçalho de autorização válido para um usuário
  def authenticated_header(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    # A gem `devise-jwt` nos dá este método para gerar o token
    token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
    headers.merge('Authorization' => "Bearer #{token}")
  end
end