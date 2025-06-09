# app/models/order.rb
class Order < ApplicationRecord
  # --- Associações ---
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  # Permite criar itens de pedido juntamente com o pedido
  accepts_nested_attributes_for :order_items, allow_destroy: true

  # --- Enum ---
  # Define os status possíveis para um pedido
  enum :status, { pending: 0, completed: 1, canceled: 2 }

  # --- Validações ---
  # Separamos as validações para maior clareza e para evitar conflitos de carga
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_type, presence: true
  validates :status, presence: true
end