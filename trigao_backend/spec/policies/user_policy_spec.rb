# spec/policies/user_policy_spec.rb
require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  # Define os sujeitos do nosso teste: um usuário master e um padrão
  let(:master_user) { create(:user, :master) }
  let(:padrao_user) { create(:user, :padrao) }

  # Define o "record" sendo testado, neste caso, outro usuário padrão
  let(:record) { create(:user, :padrao) }

  # Testes para as permissões de escopo (index)
  permissions ".scope" do
    it "para um master, retorna todos os usuários" do
      scope = Pundit.policy_scope(master_user, User)
      expect(scope.to_a).to contain_exactly(master_user, padrao_user)
    end

    it "para um usuário padrão, retorna apenas a si mesmo" do
      scope = Pundit.policy_scope(padrao_user, User)
      expect(scope.to_a).to contain_exactly(padrao_user)
    end
  end
  
  # Testes para as permissões de ações individuais
  permissions :show?, :update? do
    it "permite um usuário ver/atualizar seu próprio perfil" do
      expect(described_class).to permit(padrao_user, padrao_user)
    end

    it "permite um master ver/atualizar o perfil de outros" do
      expect(described_class).to permit(master_user, record)
    end
  end

  permissions :create?, :destroy? do
    it "nega acesso a usuários padrão" do
      expect(described_class).not_to permit(padrao_user, User)
    end

    it "permite acesso a usuários master" do
      expect(described_class).to permit(master_user, User)
    end
  end
end