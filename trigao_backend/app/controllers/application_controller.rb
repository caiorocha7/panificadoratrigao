# app/controllers/application_controller.rb
class ApplicationController < ActionController::API

  include Pundit::Authorization

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  # MÉTODOS PRIVADOS (Acessíveis apenas dentro deste controller)
  # Renderiza uma resposta JSON padronizada para erros de autorização (403 Forbidden).
  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    # O uso de `t` (I18n) aqui é uma boa prática para mensagens de erro.
    error_message = t("#{policy_name}.#{exception.query}", scope: "pundit", default: :default)
    
    render json: {
      status: { code: 403, message: "Acesso Negado. #{error_message}" }
    }, status: :forbidden
  end
  
  # Renderiza uma resposta JSON padronizada para erros de registro não encontrado (404 Not Found).
  def record_not_found(exception)
    render json: {
      status: { code: 404, message: "Recurso não encontrado. Verifique o ID fornecido." }
    }, status: :not_found
  end
end