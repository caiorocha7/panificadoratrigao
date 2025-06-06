FactoryBot.define do
  factory :order do
    user { nil }
    order_date { "2025-06-06 12:21:56" }
    total_amount { "9.99" }
    payment_type { "MyString" }
    status { 1 }
  end
end
