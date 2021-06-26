FactoryBot.define do
  factory :product do
    description { Faker::Food.dish }
    price { rand 1..100 }
    merchant { create :merchant }
  end
end
