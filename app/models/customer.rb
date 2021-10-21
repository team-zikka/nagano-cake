class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :items, through: :cart_items
  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :password, presence: true, on: :create
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, format:{ with:/\A[ァ-ヶー－]+\z/}
  validates :first_name_kana, format:{with: /\A[ァ-ヶー－]+\z/}
  validates :postal_code, format:{with: /\A\d{7}\z/}
  validates :address, presence: true
  validates :telephone_number, format:{with: /\A\d{10,11}\z/}

  #会員フルネーム
  def full_name
    self.last_name + " " + self.first_name
  end



end
