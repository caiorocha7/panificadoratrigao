class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all # Todos podem listar todos os produtos.
    end
  end

  # Ações de leitura são públicas.
  def index?; true; end
  def show?; true; end

  # Ações de escrita são restritas.
  def create?; user&.master?; end
  def update?; user&.master?; end
  def destroy?; user&.master?; end
end