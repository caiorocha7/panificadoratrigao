FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    expired_at { "2025-06-06 10:00:43" }
  end
end
