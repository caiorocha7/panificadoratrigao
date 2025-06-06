class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Se o usuário for master, ele pode ver todos os pedidos.
      if user.master?
        scope.all
      # Se não, ele só pode ver os pedidos que ele mesmo criou.
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def index?; user.present?; end

  def show?
    # O usuário deve ser o dono do pedido OU um master.
    user.master? || record.user_id == user.id
  end

  def create?; user.present?; end

  # Apenas masters podem alterar ou cancelar um pedido existente.
  def update?; user.master?; end
  def destroy?; user.master?; end
end