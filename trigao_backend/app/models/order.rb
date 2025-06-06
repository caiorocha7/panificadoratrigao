class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  # Permite que o controller aceite dados para order_items ao criar/atualizar um pedido.
  accepts_nested_attributes_for :order_items, allow_destroy: true

  enum status: { pending: 0, completed: 1, canceled: 2 }

  validates :total_amount, :payment_type, :status, presence: true
end