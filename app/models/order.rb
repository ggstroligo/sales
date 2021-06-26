class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :sale

  has_many :order_items
end
