class Product < ApplicationRecord
  validates :description, presence: true, uniqueness: true
  validates :merchant_id, presence: true

  belongs_to :merchant
end
