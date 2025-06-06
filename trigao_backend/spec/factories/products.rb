FactoryBot.define do
  factory :product do
    code { "MyString" }
    name { "MyString" }
    category { nil }
    price { "9.99" }
    unit { "MyString" }
    stock_level { 1 }
    status { 1 }
    tax_info { "MyString" }
  end
end
