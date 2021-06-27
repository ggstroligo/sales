class Product < ApplicationRecord
  validates_uniqueness_of :description, scope: :merchant_id

  validates :description, presence: true
  validates :merchant_id, presence: true

  belongs_to :merchant
end
