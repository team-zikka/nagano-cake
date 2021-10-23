class Order < ApplicationRecord

  belongs_to :customer

  has_many :items, through: :order_details
  has_many :order_details

  validates :postal_code, format:{with: /\A\d{7}\z/}
  validates :address, presence: true
  validates :name, presence: true
  validates :shipping_cost, presence: true
  validates :total_payment, presence: true
  validates :payment_method, presence: true
  validates :customer_id, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait: 0, confirm: 1, production: 2, ready_to_ship: 3, shipped: 4 }

end
