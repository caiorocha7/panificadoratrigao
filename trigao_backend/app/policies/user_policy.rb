class UserPolicy < ApplicationPolicy
  # A classe Scope controla quais registros o usuário pode ver em uma listagem (index).
  class Scope < Scope
    def resolve
      if user.master?
        scope.all # Master pode ver todos os usuários.
      else
        scope.where(id: user.id) # Padrão só pode ver a si mesmo.
      end
    end
  end

  # Um usuário pode ver um perfil se for o seu próprio ou se for um master.
  def show?
    user.master? || record.id == user.id
  end

  # Apenas um master pode criar um novo usuário através deste endpoint.
  def create?
    user.master?
  end

  # Um usuário pode atualizar seu próprio perfil, mas só um master pode mudar o 'role'.
  def update?
    user.master? || record.id == user.id
  end

  # Apenas um master pode deletar um usuário.
  def destroy?
    user.master?
  end
end