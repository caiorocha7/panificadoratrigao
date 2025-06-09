class CustomFailureApp < Devise::FailureApp
  def respond
    # Se a requisição for JSON, respondemos com JSON. Senão, usamos o padrão.
    if request.format == :json || request.content_type == 'application/json'
      json_error_response
    else
      super
    end
  end

  def json_error_response
    self.status = 401 # Unauthorized
    self.content_type = 'application/json'
    # Usamos i18n_message para pegar a mensagem de erro padrão do Devise ("Invalid email or password.")
    self.response_body = {
      status: {
        code: 401,
        message: "Erro de autenticação: #{i18n_message}"
      }
    }.to_json
  end
end