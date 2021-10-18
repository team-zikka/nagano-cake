class Item < ApplicationRecord

  has_many :customers, through: :cart_items
  has_many :cart_items, dependent: :destroy
  has_many :orders, through: :order_details
  has_many :order_details

  belongs_to :genre

  attachment :image_id

  validates :image_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :genre_id, presence: true


end
