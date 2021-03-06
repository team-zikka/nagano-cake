class Address < ApplicationRecord

  belongs_to :customer

  validates :postal_code, format:{with: /\A\d{7}\z/}
  validates :address, presence: true
  validates :name, presence: true
  validates :customer_id, presence: true

  def full_address
    self.postal_code + " " + self.address + " " + self.name
  end
end
