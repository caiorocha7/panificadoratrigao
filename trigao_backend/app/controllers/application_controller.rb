class ApplicationController < ActionController::API
  include Pundit::Authorization

  # Força a autenticação do Devise para todos os controllers que herdam dele.
  # Nenhuma ação será executada sem um token JWT válido, exceto se for explicitamente pulada.
  before_action :authenticate_user!

  # Trata erros do Pundit com uma resposta JSON amigável e clara.
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    error_message = t("#{policy_name}.#{exception.query}", scope: "pundit", default: :default)
    
    render json: {
      status: { code: 403, message: "Acesso Negado. #{error_message}" }
    }, status: :forbidden
  end
  
  def record_not_found(exception)
    render json: {
      status: { code: 404, message: "Recurso não encontrado. Verifique o ID fornecido." }
    }, status: :not_found
  end
end