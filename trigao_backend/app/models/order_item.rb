class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :unit_price, presence: true

  # Método auxiliar para o serializer
  def total_price
    quantity * unit_price
  end
end