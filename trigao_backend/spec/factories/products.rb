FactoryBot.define do
  factory :product do
    sequence(:code) { |n| "CODE#{n}" }
    name { "Produto Exemplo" }
    price { 10.50 }
    unit { "UN" }
    status { :active }
    association :category # Associa a uma categoria criada pela factory
  end
end