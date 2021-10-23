class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  validates :amount, presence: true
  validates :price, presence: true
  validates :item_id, presence: true
  validates :order_id, presence: true

  enum making_status: { making_not: 0, making_wait: 1, making_now: 2, making_complete: 3 }

end