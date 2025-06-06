class Product < ApplicationRecord
  belongs_to :category

  # Enum para um controle de status claro e eficiente.
  # Fornece métodos como: product.active!, product.inactive?
  enum :status, { active: 0, inactive: 1 }
  # Validações essenciais para a integridade dos dados
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_level, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :unit, presence: true
  validates :status, presence: true
end