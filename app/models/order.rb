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



end
