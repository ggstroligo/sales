class Customer < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :orders
  has_many :items, through: :orders, class_name: 'Order::Item'
end
