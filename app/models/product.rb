class Product < ApplicationRecord
  validates :description, presence: true, uniqueness: true

  belongs_to :merchant
  has_many :order_items
end
