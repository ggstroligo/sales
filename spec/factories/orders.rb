FactoryBot.define do
  factory :order do
    customer { create :customer }
    sale { create :sale }
  end
end
