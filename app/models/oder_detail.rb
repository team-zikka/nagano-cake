class OderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  validates :amount, presence: true
  validates :price, presence: true
  validates :item_id, presence: true
  validates :order_id, presence: true


end
