FactoryBot.define do
  factory :order_item, class: 'Order::Item' do
    order { create :order }
    product { create :product }
  end
end
