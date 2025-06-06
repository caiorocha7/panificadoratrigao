class User < ApplicationRecord
  enum :role, { padrao: 0, master: 1 }

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  # Adicionaremos um modelo de denylist em breve
end