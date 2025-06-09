# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  # Usando o FactoryBot para criar um "sujeito" do teste
  subject { build(:user) }

  describe 'validações' do
    # 'it { should ... }' é a sintaxe do shoulda-matchers
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    
    # Testa se o enum 'role' está definido corretamente
    it { should define_enum_for(:role).with_values(padrao: 0, master: 1) }
  end

  describe 'associações' do
    # Testa se o User tem a associação 'has_many' com orders
    it { should have_many(:orders).dependent(:destroy) }
  end
end