FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "teste#{n}@trigao.com" }
    password { "password123" }

    # Cria um 'trait' para o papel de master, facilitando a criação
    trait :master do
      role { :master }
    end

    # O papel padrão é 'padrao' por default no nosso modelo
    trait :padrao do
      role { :padrao }
    end
  end
end